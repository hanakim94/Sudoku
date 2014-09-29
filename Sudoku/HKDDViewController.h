//
//  HKSOViewController.h
//  Sudoku
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKDDGridView.h"

@interface HKDDViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *headerLabel;

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;

- (void) gridCellSelected:(id)sender;

- (void) updateTitleLabel;

- (void) updateMessageLabel;

- (void) hideMessageLabel;

- (IBAction) newGame;

- (IBAction) startOver;

- (IBAction) showInfo;

@end
