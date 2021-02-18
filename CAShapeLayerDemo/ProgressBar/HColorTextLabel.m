//
//  HColorTextLabel.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/28.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "HColorTextLabel.h"

@implementation HColorTextLabel

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 获取文字mask
    [self.text drawInRect:self.bounds withAttributes:@{NSFontAttributeName : self.font}];
    CGImageRef textMask = CGBitmapContextCreateImage(context);
    
    // 清空画布
    CGContextClearRect(context, rect);
    
    // 设置蒙层
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, textMask);
    
    // 绘制渐变
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0, 0.5, 1};
    CGFloat colors[] = {1.0,0.0,0.0,1.0,
                        0.0,1.0,0.0,1.0,
                        0.0,0.0,1.0,1.0};
    CGGradientRef gradient=CGGradientCreateWithColorComponents(colorSpace, colors, locations, 3);
    CGPoint start = CGPointMake(0, self.bounds.size.height / 2.0);
    CGPoint end = CGPointMake(self.bounds.size.width, self.bounds.size.height / 2.0);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation);
    
    // 释放
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    CGImageRelease(textMask);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
