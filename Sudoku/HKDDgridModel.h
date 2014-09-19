//
//  HKDDgridModel.h
//  Sudoku
//
//  Created by Dani Demas on 9/19/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKDDgridModel : NSObject

- (void)generateGrid;
- (int)getValueAtRow:(int)row column:(int)column;
- (void) setValueAtRow:(int)row column:(int)column to:(int)value;
- (bool) isMutableAtRow:(int)row column:(int)column;
- (bool) isConsistentAtRow:(int)row column:(int)column for:(int)value;

@end
