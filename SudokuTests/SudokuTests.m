//
//  SudokuTests.m
//  SudokuTests
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HKDDGridModel.h"

@interface SudokuTests : XCTestCase {
    HKDDGridModel* _model;
}

@end

@implementation SudokuTests

int initGrid [9][9] =  {{7,0,0,4,2,0,0,0,9},
                        {0,0,9,5,0,0,0,0,4},
                        {0,2,0,6,9,0,5,0,0},
                        {6,5,0,0,0,0,4,3,0},
                        {0,8,0,0,0,6,0,0,7},
                        {0,1,0,0,4,5,6,0,0},
                        {0,0,0,8,6,0,0,0,2},
                        {3,4,0,9,0,0,1,0,0},
                        {8,0,0,3,0,2,7,4,0}};

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _model = [[HKDDGridModel alloc] init];
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
            if (initGrid[row][col] == 0) {
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

@end
