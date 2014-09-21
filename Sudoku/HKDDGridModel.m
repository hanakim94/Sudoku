//
//  HKDDGridModel.m
//  Sudoku
//
//  Created by Dani Demas on 9/19/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import "HKDDGridModel.h"

@implementation HKDDGridModel

int initGrid [9][9]={{7,0,0,4,2,0,0,0,9},
    {0,0,9,5,0,0,0,0,4},
    {0,2,0,6,9,0,5,0,0},
    {6,5,0,0,0,0,4,3,0},
    {0,8,0,0,0,6,0,0,7},
    {0,1,0,0,4,5,6,0,0},
    {0,0,0,8,6,0,0,0,2},
    {3,4,0,9,0,0,1,0,0},
    {8,0,0,3,0,2,7,4,0}};
int cells [9][9]={{7,0,0,4,2,0,0,0,9},
    {0,0,9,5,0,0,0,0,4},
    {0,2,0,6,9,0,5,0,0},
    {6,5,0,0,0,0,4,3,0},
    {0,8,0,0,0,6,0,0,7},
    {0,1,0,0,4,5,6,0,0},
    {0,0,0,8,6,0,0,0,2},
    {3,4,0,9,0,0,1,0,0},
    {8,0,0,3,0,2,7,4,0}};

- (void)generateGrid
{
    
}

- (int)getValueAtRow:(int)row column:(int)column
{
    return cells[row][column];
}

- (void) setValueAtRow:(int)row column:(int)column to:(int)value
{
    NSLog(@"in setValueAtRow");
    cells[row][column] = value;
}

- (bool) isMutableAtRow:(int)row column:(int)column
{
    NSLog(@"initalGrid value here: %d", initGrid[row][column]);
    return initGrid[row][column] == 0;
}

- (bool) isConsistentAtRow:(int)row column:(int)column for:(int)value
{
    NSLog(@"in isConsistentAtRow");
    
    // Check the column
    for (int r = 0; r < 9; ++r){
        if (cells[r][column] == value){
            return false;
        }
    }
    // Check the row
    for (int c = 0; c < 9; ++c){
        if (cells[row][c] == value){
            return false;
        }
    }
    
    int subgridRow = row/3;
    int subgridCol = column/3;
    // Check the square
    for (int r = 0; r < 3; ++r) {
        for (int c = 0; c < 3; ++c) {
            if (cells[3*subgridRow + r][3*subgridCol + c] == value){
                return false;
            }
        }
    }
    return true;
}

@end