//
//  HKDDNumPadView.h
//  Sudoku
//
//  Created by Dani Demas on 9/19/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKDDNumPadView : UIView

- (void) cellSelected:(id)sender;

- (int) getCurrentValue;

@end
