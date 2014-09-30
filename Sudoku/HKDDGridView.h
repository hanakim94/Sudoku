//
//  HKSOGridView.h
//  Sudoku
//
//  Created by HMC on 9/12/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKDDGridView : UIView

- (void) setValueAtRow:(int)row column:(int)col to:(int)value initial:(bool)initial;

- (void) addTarget:(id)theTarget action:(SEL)theAction;

- (void) cellSelected:(id)sender;

@end
