//
//  HKDDGridModel.h
//  Sudoku
//
//  Created by Dani Demas on 9/19/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKDDGridModel : NSObject

@property NSMutableArray* initialGrid;

@property NSMutableArray* currentGrid;

- (void) generateGrid;

- (int) getValueAtRow:(int)row column:(int)column;

- (void) setValueAtRow:(int)row column:(int)column to:(int)value;

- (bool) isMutableAtRow:(int)row column:(int)column;

- (bool) isConsistentAtRow:(int)row column:(int)column for:(int)value;

@end

