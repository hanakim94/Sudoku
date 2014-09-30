//
//  SudokuTests.m
//  SudokuTests
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HKDDGridModel.h"
#import "HKDDGridGenerator.h"

@interface SudokuTests : XCTestCase {
    HKDDGridModel* _model;
    HKDDGridGenerator* _generator;
}

@end

@implementation SudokuTests

NSMutableArray* _initialGrid;

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _model = [[HKDDGridModel alloc] init];
    [_model generateGrid];
    _generator = [[HKDDGridGenerator alloc] init];
    _initialGrid = [_model initialGrid];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetForInvalidValues
{
    XCTAssertThrowsSpecific([_model setValueAtRow:1 column:1 to:10], NSException, @"value > 9");

    XCTAssertThrowsSpecific([_model setValueAtRow:2 column:2 to:-1], NSException, @"value < 0");
}

- (void)testSetAndGet
{
    // set up grid with [1,2,...,9] in each row
    for (int row = 0; row < 9; ++row){
        for (int col = 0; col < 9; ++col){
            [_model setValueAtRow:row column:col to:row+1];
        }
    }
    
    XCTAssertTrue([[[_model currentGrid] objectAtIndex:0] intValue] == 1, @"Directly checking if setValue works at row 0 column 0");
    XCTAssertTrue([[[_model currentGrid] objectAtIndex:3*9 + 6] intValue] == 4, @"Directly checking if setValue works at row 3 column 6");
    
    // get the value of each cell and check if it's the correct value
    for (int row = 0; row < 9; ++row){
        for (int col = 0; col < 9; ++col){
            XCTAssertTrue([_model getValueAtRow:row column:col] == row+1, @"Checking row %d & col %d", row, col);
        }
    }
}

- (void) testMutableAtRow
{
    for (int row = 0; row < 9; ++row){
        for (int col = 0; col < 9; ++col){
            if ([[_initialGrid objectAtIndex:(row*9 + col)] intValue] == 0) {
                XCTAssertTrue([_model isMutableAtRow:row column:col], @"Is mutable at row %d column %d", row, col);
            }
            else {
                XCTAssertFalse([_model isMutableAtRow:row column:col], @"Is not mutable at row %d column %d", row, col);
            }
        }
    }
}

- (void) testConsistentAtRow
{
    // make an empty grid
    for (int row = 0; row < 9; ++row){
        for (int col = 0; col < 9; ++col){
            [_model setValueAtRow:row column:col to:0];
        }
    }
    
    // set cell (4,3) to 5
    [_model setValueAtRow:4 column:3 to:5];
    
    XCTAssertFalse([_model isConsistentAtRow:4 column:6 for:5], @"Checking if not consistent in row 4");
    
    XCTAssertFalse([_model isConsistentAtRow:7 column:3 for:5], @"Checking if not consistent in column 3");

    XCTAssertFalse([_model isConsistentAtRow:5 column:4 for:5], @"Checking if not consistent in subgrid (middle square)");
    
    XCTAssertTrue([_model isConsistentAtRow:1 column:1 for:5], @"Checking if consistent at (1,1)");
}

- (void) testLengthOfGrid
{
    [_generator generateGrid];
    XCTAssertTrue([[_generator getGrid] count] == 81, @"Checking if size of grid is 81");
}

- (void) testGridValues
{
    [_generator generateGrid];
    for (int x = 0; x < 81; ++x){
        int value = [[[_generator getGrid] objectAtIndex: x] intValue];
        XCTAssertTrue(value >= 0 && value <= 9, @"Checking if value is between 0 and 9");
    }
}

- (void) testIfGridInFile
{
    // get all grid strings
    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"grid1" ofType:@"txt"];
    NSString* path2 = [[NSBundle mainBundle] pathForResource:@"grid2" ofType:@"txt"];
    
    NSError* error;
    
    NSString* grid1 = [[NSString alloc] initWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:&error];
    
    NSString* grid2 = [[NSString alloc] initWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:&error];
    
    NSString* allGrids = [NSString stringWithFormat: grid1, grid2];
    
    NSString* theGrid = @"";
    
    [_generator generateGrid];
    NSMutableArray* gridArray = [_generator getGrid];
    
    for (int x = 0; x < 81; ++x){
        NSString* next = [[gridArray objectAtIndex:x] stringValue];
        if ([next isEqualToString: (NSString*)@"0"])
            theGrid = [NSString stringWithFormat: @"%@%@", theGrid, @"."];
        else
            theGrid = [NSString stringWithFormat: @"%@%@", theGrid, next];
    }
    
    XCTAssertFalse([allGrids rangeOfString: theGrid].location == NSNotFound, @"Checking if the generated grid is in the list of valid grids");
}

@end
