//
//  HKDDGridModel.m
//  Sudoku
//
//  Created by Dani Demas on 9/19/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import "HKDDGridModel.h"
#import "HKDDGridGenerator.h"

@implementation HKDDGridModel



HKDDGridGenerator* _generator;

- (void)generateGrid
{
    _generator = [HKDDGridGenerator alloc];
    [_generator generateGrid];
    _initialGrid = [_generator getGrid];
    _cells = _initialGrid;
}

- (int)getValueAtRow:(int)row column:(int)column
{
    NSLog(@"cells objectAtIndex: %@ ", [_cells objectAtIndex:(row*9 + column)]);
    return [[_cells objectAtIndex:(row*9 + column)] intValue];
}

- (void) setValueAtRow:(int)row column:(int)column to:(int)value
{
    NSAssert(value<=9, @"Invalid: value > 9");
    NSAssert(value>=0, @"Invalid: value < 0");
    
    [_cells replaceObjectAtIndex:(row*9 + column) withObject:[NSNumber numberWithInt:value]];
}

- (bool) isMutableAtRow:(int)row column:(int)column
{

    return [[_initialGrid objectAtIndex:(row*9 + column)] intValue] == 0;
}

- (bool) isConsistentAtRow:(int)row column:(int)column for:(int)value
{
    // Check the column
    for (int r = 0; r < 9; ++r){
        if ([[_cells objectAtIndex:(r*9 + column)] intValue] == value){
            return false;
        }
    }
    // Check the row
    for (int c = 0; c < 9; ++c){
        if ([[_cells objectAtIndex:(row*9 + c)] intValue] == value){
            return false;
        }
    }
    
    int subgridRow = row/3;
    int subgridCol = column/3;
    
    // Check the square
    for (int r = 0; r < 3; ++r) {
        for (int c = 0; c < 3; ++c) {
            int rowIndex = 3*subgridRow + r;
            int colIndex = 3*subgridCol + c;
            if ([[_cells objectAtIndex:rowIndex*9 + colIndex] intValue] == value){
                return false;
            }
        }
    }
    return true;
}

@end