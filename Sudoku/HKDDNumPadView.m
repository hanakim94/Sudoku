//
//  HKDDNumPadView.m
//  Sudoku
//
//  Created by Dani Demas on 9/19/14.
//  Copyright (c) 2014 Hana Kim Dani Demas. All rights reserved.
//

#import "HKDDNumPadView.h"

@interface HKDDNumPadView() {
    
    NSMutableArray* _cells;
    int _currentValue;
}

@end

@implementation HKDDNumPadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _cells = [[NSMutableArray alloc] init];
        
        CGFloat buttonSize = frame.size.width/11.5;
        CGFloat thinBorder = buttonSize/8;
        
        CGFloat x = (frame.size.width - (10*buttonSize + 9*thinBorder))/2;
        CGFloat y = (frame.size.height - buttonSize)/2;
        
        for (int cellNum = 0; cellNum < 10; ++cellNum) {
            
            CGRect buttonFrame = CGRectMake (x,y,buttonSize,buttonSize);
            UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
            button.backgroundColor = [UIColor whiteColor];
            
            button.tag = cellNum; // tag is a 2 digit number, column-row
            
            UIImage* image = [self imageWithColor:[UIColor colorWithRed:133/255.0f green:184/255.0f blue:242/255.0f alpha:1]];
            [button setBackgroundImage:image forState:UIControlStateHighlighted];
            [button setShowsTouchWhenHighlighted:YES];
            
            [_cells addObject:button];
            [self addSubview:button];
            
            [button addTarget:self action:@selector(cellSelected:) forControlEvents: UIControlEventTouchDown];
            
            if (cellNum == 0) {
                [button setTitle:@"Erase" forState:UIControlStateNormal];
            }
            else {
                [button setTitle:[NSString stringWithFormat:@"%d",cellNum] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:30];
            }
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            x += thinBorder + buttonSize;
        }
        _currentValue = 0;
    }
    return self;
}

- (void) cellSelected:(id)sender
{
    // return last selected button's background color to white
    ((UIButton*)_cells[_currentValue]).backgroundColor = [UIColor whiteColor];
    
    UIButton* button = (UIButton*) sender;
    
    _currentValue = button.tag;
    
    button.backgroundColor = [UIColor colorWithRed:133/255.0f green:184/255.0f blue:242/255.0f alpha:1];
}

- (int) getCurrentValue
{
    return _currentValue;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
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
