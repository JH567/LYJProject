//
//  LYJAnimationView.m
//  LYJProject
//
//  Created by LYJ on 2022/2/20.
//

#import "LYJAnimationView.h"

@implementation LYJAnimationView

- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(ctx, 200, 250, 150, 0, 2 * M_PI, 1);
    
    //CGContextAddEllipseInRect(ctx, CGRectMake(50, 100, 300, 300));
    
    CGContextAddRect(ctx, CGRectMake(50, 100, 300, 300));
    
    CGContextStrokePath(ctx);
    
}

@end
