//
//  HKDDNumPadView.m
//  Sudoku
//
//  Created by Dani Demas on 9/19/14.
//  Copyright (c) 2014 Hana Kim Sean Okeeffe. All rights reserved.
//

#import "HKDDNumPadView.h"

//@interface HKDDNumPadView (){
    
    NSMutableArray* _cells;
    int _currentValue;
    
//}

//@end

@implementation HKDDNumPadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _cells = [[NSMutableArray alloc] init];
        
        CGFloat buttonSize = frame.size.width/12.0;
        CGFloat thinBorder = buttonSize/4;
        
        CGFloat x = (frame.size.width - (9*buttonSize + 8*thinBorder))/2;
        CGFloat y = (frame.size.height - buttonSize)/2;
        
        for (int cellNum = 0; cellNum < 9; ++cellNum) {
            CGRect buttonFrame = CGRectMake (x,y,buttonSize,buttonSize);
            UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
            button.backgroundColor = [UIColor whiteColor];
            button.tag = cellNum; // tag is a 2 digit number, column-row
            
            UIImage* image = [self imageWithColor:[UIColor yellowColor]];
            [button setBackgroundImage:image forState:UIControlStateHighlighted];
            [button setShowsTouchWhenHighlighted:YES];
            [_cells addObject:button];
            [self addSubview:button];
            
            [button addTarget:self action:@selector(cellSelected:) forControlEvents: UIControlEventTouchDown];
            
            [button setTitle:[NSString stringWithFormat:@"%d",cellNum+1] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            x += thinBorder + buttonSize;
        }
        
    }
    return self;
}

- (void) cellSelected:(id)sender
{
    if (_currentValue != 0) {
        // return last selected button's background color to white
        ((UIButton*)_cells[_currentValue - 1]).backgroundColor = [UIColor whiteColor];
    }
    // account for 0-index by adding 1
    UIButton* button = (UIButton*) sender;
    _currentValue = button.tag + 1;
    
    NSLog(@" current value is now: %d", _currentValue);
    
    button.backgroundColor = [UIColor yellowColor];
}

- (int) getCurrentValue
{
    
    return _currentValue;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
