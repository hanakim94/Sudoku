//
//  HKSOViewController.m
//  Sudoku
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKDDViewController.h"
#import "HKDDGridView.h"
#import "HKDDNumPadView.h"
#import "HKDDGridModel.h"


int initialGrid [9][9]={
    {7,0,0,4,2,0,0,0,9},
    {0,0,9,5,0,0,0,0,4},
    {0,2,0,6,9,0,5,0,0},
    {6,5,0,0,0,0,4,3,0},
    {0,8,0,0,0,6,0,0,7},
    {0,1,0,0,4,5,6,0,0},
    {0,0,0,8,6,0,0,0,2},
    {3,4,0,9,0,0,1,0,0},
    {8,0,0,3,0,2,7,4,0}
};


@interface HKDDViewController () {
    
    UIView * _gridView;
    UIView * _numPadView;
    HKDDGridModel * _gridModel;
}

@end

@implementation HKDDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // create frame
    CGRect frame = self.view.frame;
    
    // create grid view
    
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    _gridView = [[HKDDGridView alloc] initWithFrame:gridFrame];
    _gridView.backgroundColor = [UIColor blackColor];
    
    [self initializeGrid];
    [self.view addSubview:_gridView];
    [(HKDDGridView*)_gridView addTarget:(self) action:@selector(gridCellSelected:)];

    
    // create numpad view
    
    CGFloat numPadX = x;
    CGFloat numPadY = 2*y + size;
    CGFloat numPadHeight = y;
    CGFloat numPadWidth = size;
    
    CGRect numPadFrame = CGRectMake(numPadX, numPadY, numPadWidth, numPadHeight);
    
    _numPadView = [[HKDDNumPadView alloc] initWithFrame:numPadFrame];
    _numPadView.backgroundColor = [UIColor blackColor];

    [self.view addSubview:_numPadView];
    //[(HKDDNumPadView*)_numPadView addTarget:(self) action:@selector(numPadCellSelected:)];
    
    _gridModel = [HKDDGridModel alloc];
}

- (void) initializeGrid
{
    for (int row = 0; row < 9; ++row) {
        for (int column = 0; column < 9; ++column) {
            [(HKDDGridView*)_gridView setValueAtRow:row column:column to: initialGrid[row][column]];
        }
    }
}


- (void) gridCellSelected:(id) cell
{
    UIButton * button = (UIButton *) cell;
    int row = button.tag%10;
    int column = button.tag/10;
    NSLog(@"Row: %d, Column: %d", row, column);
    
    if (![_gridModel isMutableAtRow:row column:column]) {
        NSLog(@"Not mutable cell!");
        return;
    }
    
    int currentValue = [(HKDDNumPadView*)_numPadView getCurrentValue];
    NSLog(@"Current value is: %d", currentValue);
    
    if (![_gridModel isConsistentAtRow:row column:column for:currentValue]) {
        NSLog(@"Not consistent!");
        return;
    }
    
    NSLog(@"setting value to current value: %d", currentValue);
    // if value was consistent, set cell to currentValue
    [(HKDDGridView*)_gridView setValueAtRow:row column:column to: currentValue];
    
    // set gridModel's value to currentValue
    [_gridModel setValueAtRow:row column:column to:currentValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
