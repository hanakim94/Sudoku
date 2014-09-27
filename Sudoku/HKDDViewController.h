//
//  HKSOViewController.h
//  Sudoku
//
//  Created by HMC on 9/11/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKDDGridView.h"

@interface HKDDViewController : UIViewController

- (void) gridCellSelected:(id)sender;

- (IBAction) newGame;

- (IBAction) startOver;

@end
