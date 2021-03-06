//
//  HKSOGridView.m
//  Sudoku
//
//  Created by HMC on 9/12/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import "HKDDGridView.h"

@interface HKDDGridView() {
    NSMutableArray* _cells;
    
    id _target;
    SEL _action;
}

@end

@implementation HKDDGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _cells = [[NSMutableArray alloc] init];
        
        CGFloat buttonSize = frame.size.height/12.0;
        
        CGFloat thickBorder = buttonSize/2;
        CGFloat thinBorder = buttonSize/6;
        
        CGFloat x = thickBorder;
        CGFloat y = thickBorder;
        
        for (int row = 0; row < 9; ++row) {
            for (int column = 0; column < 9; ++column) {
                CGRect buttonFrame = CGRectMake (x,y,buttonSize,buttonSize);
                UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
                button.backgroundColor = [UIColor whiteColor];
                button.tag = column*10 + row; // tag is a 2 digit number, column-row
                
                UIImage* image = [self imageWithColor:[UIColor colorWithRed:133/255.0f green:184/255.0f blue:242/255.0f alpha:1]];
                
                [button setBackgroundImage:image forState:UIControlStateHighlighted];
                [button setShowsTouchWhenHighlighted:YES];
                
                [_cells addObject:button];
                [self addSubview:button];
                
                [button addTarget:self action:@selector(cellSelected:) forControlEvents: UIControlEventTouchDown];

                // calculate x values for the next column
                if (column == 8) {
                    x = thickBorder;
                }
                else if (column%3 == 2) {
                    x = x + buttonSize + thickBorder;
                }
                else {
                    x = x + buttonSize + thinBorder;
                }
            }
            // calculate y values for the next row
            if (row%3 == 2) {
                y = y + buttonSize + thickBorder;
            }
            else {
                y = y + buttonSize + thinBorder;
            }
        }
    }
    return self;
}

- (void) setValueAtRow:(int)row column:(int)col to:(int)value initial:(bool)initial
{
    UIButton* button = [_cells objectAtIndex:9*row+col];
    
    // 0 represents a blank cell
    if (value != 0) {
        [button setTitle:[NSString stringWithFormat:@"%d",value] forState:UIControlStateNormal];
        if (initial){
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:30];
        }
        else{
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Regular" size:30]];
        }
        
    }
    else {
        [button setTitle: @"" forState: UIControlStateNormal];
    }
}

- (void) addTarget: (id) theTarget action:(SEL)theAction
{
    _target = theTarget;
    _action = theAction;
}

- (void) cellSelected:(id)sender
{
    [_target performSelector:_action withObject:((UIButton*) sender)];
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
