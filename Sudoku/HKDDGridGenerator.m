//
//  HKDDGridGenerator.m
//  Sudoku
//
//  Created by HMC on 9/24/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import "HKDDGridGenerator.h"
#include <stdlib.h>

@implementation HKDDGridGenerator
    
NSMutableArray* _grid;

- (void) generateGrid {
    
    _grid = [[NSMutableArray alloc] init];
    
    // open and read files grid1.txt and grid2.txt
    
    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"grid1" ofType:@"txt"];
    NSString* path2 = [[NSBundle mainBundle] pathForResource:@"grid2" ofType:@"txt"];

    NSError* error;
    
    NSString* grid1 = [[NSString alloc] initWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:&error];
    
     NSString* grid2 = [[NSString alloc] initWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:&error];
    
    NSString* allGrids = [NSString stringWithFormat: grid1, grid2];

    
    // pick a grid randomly
    
    int random = arc4random() % ([allGrids length])/82;
    int gridNumber = random*82;
    
    NSString* gridString = [allGrids substringWithRange: NSMakeRange(gridNumber, 81)];

    for (int i = 0; i < 81; ++i) {
        NSString* nextCell = [gridString substringWithRange: NSMakeRange(i, 1)];

        if ([nextCell isEqual: @"."]){
            [_grid insertObject: [NSNumber numberWithInt:0] atIndex: i];
        }
        else {
            [_grid insertObject:[NSNumber numberWithInt: [nextCell intValue]] atIndex: i];
        }
    }
}

- (NSMutableArray*) getGrid {
    return _grid;
}

@end
