//
//  BezierPathView.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/12.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView
/*
 * 重回drawRect方法
 * 创建UIBezierPath对象
 * moveToPoint设置初始点
 * 根据UIBezierPath类方法绘图（如，画线，圆，弧，矩形等）
 * 设置UIBezierPath相关属性
 * 用stroke或fill结束绘图
 */

//
- (void)drawRect:(CGRect)rect {
    
    for (int i = 0; i < 7; i++) {
        UIColor *color = [UIColor redColor];
        [color set];
        //    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 30, 30, 230) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(3.0, 3.0)];
            // 画一条线
            UIBezierPath *path = [UIBezierPath bezierPath];
        //    [path appendPath:path1];
            [path moveToPoint:CGPointMake(20+(50 * i), 230)];
            [path addLineToPoint:CGPointMake(20+(50 * i), 30+i*7)];
        //    [path addLineToPoint:CGPointMake(300, 50)];
        //    path.lineWidth = 10;
        //    path.lineCapStyle = kCGLineCapSquare;
        //    path.lineJoinStyle=  kCGLineJoinRound;
        //    [path closePath];
        //    [path stroke];

            CAShapeLayer *gressLayer = [CAShapeLayer layer];

            gressLayer.strokeColor = [UIColor blueColor].CGColor;
        if (i == 6) {
            gressLayer.strokeColor = [UIColor redColor].CGColor;
        }
            gressLayer.fillColor = [UIColor clearColor].CGColor;
            gressLayer.lineCap = kCALineCapSquare;
            gressLayer.path = path.CGPath;
            gressLayer.lineWidth = 30;
            gressLayer.lineJoin = kCALineJoinRound;

            [self.layer addSublayer:gressLayer];
            
            CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
            ani.fromValue = @0;
            ani.toValue = @1;
            ani.duration = 1.0;
            
            [gressLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    }
    
    
    
//    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:gressLayer.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10.0, 10.0)];
//    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//    layer.frame = gressLayer.bounds;
//    layer.path = path1.CGPath;
//    [gressLayer addSublayer:layer];
//
    
    
    /*画一个多边形*/
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    path.lineWidth = 5;
//    path.lineCapStyle = kCGLineCapRound;
//    path.lineJoinStyle = kCGLineJoinRound;
//    [path moveToPoint:CGPointMake(300, 300)];
//    [path addLineToPoint:CGPointMake(100, 450)];
//    [path addLineToPoint:CGPointMake(120, 600)];
//    [path addLineToPoint:CGPointMake(<#CGFloat x#>, <#CGFloat y#>)]
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    [self touchLayerWithPoint:point];
}

- (void)touchLayerWithPoint:(CGPoint)point {
    NSMutableArray *subbarLayers = [NSMutableArray array];
    for (CALayer *sublayer in self.layer.sublayers) {
        if ([sublayer isKindOfClass:[CAShapeLayer class]]) {
//            if (((CAShapeLayer *)sublayer).tag == MASKPATH_TAG) {
//                [subbarLayers addObject:sublayer];
//            }
        }
    }
    __weak __typeof(self) weakSelf = self;
    
    [subbarLayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *layer = (CAShapeLayer *)obj;
        CGPathRef path = layer.path;
        if (CGPathContainsPoint(path, &CGAffineTransformIdentity, point, NO)) {
//            if (weakSelf.completionValue) {
//                weakSelf.completionValue(layer.userInfo);
//            }
            
        }
    }];
}


/* path的属性
    [color set] 设置线条颜色，也就是画笔的颜色
    path.lineWidth 线条的宽度
    path.lineCapStyle这个线段起点是终点的样式，这个样式有三种：（
        1、kCGLineCapButt该属性值指定不绘制端点， 线条结尾处直接结束。这是默认值。
        2、kCGLineCapRound 该属性值指定绘制圆形端点， 线条结尾处绘制一个直径为线条宽度的半圆。
        3、kCGLineCapSquare 该属性值指定绘制方形端点。 线条结尾处绘制半个边长为线条宽度的正方形。需要说明的是，这种形状的端点与“butt”形状的端点十分相似，只是采用这种形式的端点的线条略长一点而已 ）
    path.lineJoinStyle这个属性是用来设置两条线连结点的样式，同样它也有三种样式供我们选择 (
        1、kCGLineJoinMiter 斜接
        2、kCGLineJoinRound 圆滑衔接
        3、kCGLineJoinBevel 斜角连接 ）
    [path stroke];用 stroke 得到的是不被填充的 view ，[path fill]; 用 fill 得到的内部被填充的 view，这点在下面的代码还有绘制得到的图片中有，可以体会一下这两者的不同
 */






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
