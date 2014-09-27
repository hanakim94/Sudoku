//
//  HKDDGridGenerator.m
//  Sudoku
//
//  Created by HMC on 9/24/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKDDGridGenerator.h"
#include <stdlib.h>

@implementation HKDDGridGenerator
    
NSMutableArray* _grid;

- (void) generateGrid {
    
    _grid= [[NSMutableArray alloc] init];
    
    NSString* path1 = [[NSBundle mainBundle] pathForResource:@"grid1" ofType:@"txt"];
    NSString* path2 = [[NSBundle mainBundle] pathForResource:@"grid2" ofType:@"txt"];

    NSError* error;
    
    NSString* grid1 = [[NSString alloc] initWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:&error];
    
     NSString* grid2 = [[NSString alloc] initWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:&error];
    
    NSString* allGrids = [NSString stringWithFormat: grid1, grid2];

    
    int random = arc4random() % ([allGrids length])/82;
    
    NSLog (@" random: %d", random);
    
    int gridNumber = random*82;
    
    NSLog (@"gridNumber: %d", gridNumber);
    
    NSString* gridString;
    
    gridString = [allGrids substringWithRange: NSMakeRange(gridNumber, 81)];

    NSLog(@"gridString: %@", gridString);
    
    for (int i = 0; i < 81; ++i){
        NSString* nextCell = [gridString substringWithRange: NSMakeRange(i, 1)];
        
        NSLog(@"%@", nextCell);
        
        int number = [NSNumber numberWithInt: [nextCell intValue]];
        NSLog(@"number : %d", number);
        
        if ([nextCell isEqual: @"."]){
            [_grid insertObject: [NSNumber numberWithInt:0] atIndex: i];
        }
        else {
            [_grid insertObject:[NSNumber numberWithInt: [nextCell intValue]] atIndex: i];
        }
    }
    
    for (int j = 0; j < 81; ++j){
        NSLog(@"%@", [_grid objectAtIndex:j]);
    }
}

- (NSMutableArray*) getGrid {
    return _grid;
}

@end
