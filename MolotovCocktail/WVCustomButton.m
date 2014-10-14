//
//  WVCustomButton.m
//  MolotovCocktail
//
//  Created by Wesley Vance on 10/14/14.
//  Copyright (c) 2014 Wesley Vance. All rights reserved.
//

#import "WVCustomButton.h"

@implementation WVCustomButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color =[UIColor colorWithRed:0.114 green:0.114 blue:1 alpha:1];
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, self.bounds);
    
}


@end
