//
//  HKSOViewController.m
//  Sudoku
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKSOViewController.h"
#import "HKSOGridView.h"


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

@interface HKSOViewController () {
    UIView * _gridView;
}

@end

@implementation HKSOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // create grid frame
    CGRect frame = self.view.frame;
    
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // create grid view
    _gridView = [[HKSOGridView alloc] initWithFrame:gridFrame];
    _gridView.backgroundColor = [UIColor blackColor];

    [self initializeGrid];
    [self.view addSubview:_gridView];
    [(HKSOGridView*)_gridView addTarget:(self) action:@selector(gridCellSelected:)];
    
}

- (void) initializeGrid
{
    for (int row = 0; row < 9; ++row) {
        for (int column = 0; column < 9; ++column) {
            [(HKSOGridView*)_gridView setValueAtRow:row column:column to: initialGrid[row][column]];
        }
    }
}

- (void) gridCellSelected:(id) cell
{
    UIButton * button = (UIButton *) cell;
    NSLog(@"Row: %d, Column: %d", button.tag%10, button.tag/10);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
