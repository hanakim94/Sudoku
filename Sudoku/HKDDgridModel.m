//
//  HKDDgridModel.m
//  Sudoku
//
//  Created by Dani Demas on 9/19/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import "HKDDgridModel.h"

@implementation HKDDgridModel

int initialGrid [9][9]={{7,0,0,4,2,0,0,0,9},
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
    cells[row][column] = value;
}

- (bool) isMutableAtRow:(int)row column:(int)column
{
    return initialGrid[row][column] == 0;
}

- (bool) isConsistentAtRow:(int)row column:(int)column for:(int)value
{
    // Check the column
    
    // Check the row
    initialGrid[row][x] = value
    
    // Check the square
    
}

@end
