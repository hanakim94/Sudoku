//
//  HKSOViewController.m
//  Sudoku
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import "HKDDViewController.h"
#import "HKDDGridView.h"
#import "HKDDNumPadView.h"
#import "HKDDGridModel.h"

@interface HKDDViewController() {
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
    
    _gridModel = [HKDDGridModel alloc];
    
    [self initializeGrid];
    [self.view addSubview:_gridView];
    [(HKDDGridView*)_gridView addTarget:(self) action:@selector(gridCellSelected:)];

    
    // create numpad view
    
    CGFloat numPadX = x/2;
    CGFloat numPadY = 1.75*y + size;
    CGFloat numPadHeight = y;
    CGFloat numPadWidth = size+x;
    
    CGRect numPadFrame = CGRectMake(numPadX, numPadY, numPadWidth, numPadHeight);
    
    _numPadView = [[HKDDNumPadView alloc] initWithFrame:numPadFrame];
    _numPadView.backgroundColor = [UIColor blackColor];

    [self.view addSubview:_numPadView];
}

- (void) initializeGrid
{
    [_gridModel generateGrid];
    
    for (int row = 0; row < 9; ++row) {
        for (int column = 0; column < 9; ++column) {
            int value = [_gridModel getValueAtRow:row column:column];
            [(HKDDGridView*)_gridView setValueAtRow:row column:column to:value initial:YES];
        }
    }
}

- (void) gridCellSelected:(id) cell
{
    [self hideMessageLabel];
    UIButton * button = (UIButton *) cell;
    int row = button.tag%10;
    int column = button.tag/10;
    
    if (![_gridModel isMutableAtRow:row column:column]) {
        [self updateMessageLabel];
        return;
    }
    
    int currentValue = [(HKDDNumPadView*)_numPadView getCurrentValue];
    
    // if not equal to zero, check if consistent
    if (currentValue != 0){
        if (![_gridModel isConsistentAtRow:row column:column for:currentValue]) {
            [self updateMessageLabel];
            return;
        }
    }
    
    // if value was consistent, set cell to currentValue
    [(HKDDGridView*)_gridView setValueAtRow:row column:column to:currentValue initial:NO];
    
    // set gridModel's value to currentValue
    [_gridModel setValueAtRow:row column:column to:currentValue];
    
    // check if user won game and update label accordingly
    [self updateTitleLabel];
}

- (void) updateTitleLabel
{
    NSString* displayMessage;
    bool isComplete = YES;
    
    for (int row = 0; row < 9; ++row) {
        for (int col = 0; col < 9; ++col) {
            if ([_gridModel getValueAtRow: row column:col] == 0) {
                isComplete = NO;
            }
        }
    }
    
    if (isComplete) {
        displayMessage = @"You win!!";
    }
    else {
        displayMessage = @"SUDOKU";
    }
    
    self.headerLabel.text = displayMessage;
}

- (void) updateMessageLabel
{
    self.messageLabel.text = @"Can't put that number there!";
}

- (void) hideMessageLabel
{
    self.messageLabel.text = @"";
}

- (IBAction) newGame
{
    self.headerLabel.text = @"SUDOKU";
    [self initializeGrid];
}

- (IBAction) startOver
{
    self.headerLabel.text = @"SUDOKU";
    
    for (int row = 0; row < 9; ++row){
        for (int column = 0; column < 9; ++column){
            if ([_gridModel isMutableAtRow:row column:column]) {
                [(HKDDGridView*)_gridView setValueAtRow:row column:column to:0 initial:NO];
                [_gridModel setValueAtRow:row column:column to:0];
            }
        }
    }
}

- (IBAction) showInfo
{
    UIAlertView *showView = [[UIAlertView alloc]
                             initWithTitle:@"How to Play Sudoku:"
                             message:@"\n The numbers 1 though 9 should appear only once in each row, column, and subgrid. \n There is only one possible solution, so choose wisely! \n To place a number into the grid, select a number in the number pad (below the grid), then select the cell you would like to place the number in. \n If you think you have placed a number incorrectly, you can use the erase button to clear your input or choose to replace it with a different number. \n To erase all of the numbers that you have put in the grid (i.e. you are stuck and have no more moves), you can tap the \"Start Over\" button and replay the same game. \n At any time, if you want to play a different Sudoku board, you can tap the \"New Game\" button. \n If you try to place a number in a row, column, or subgrid where that number already exists, you will receive a warning message telling you that you cannot place that number there. \n Once you have filled in the entire grid, you win! Good luck :)"
                             delegate:nil
                             cancelButtonTitle:@"Close"
                             otherButtonTitles:nil];
    [showView show];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
