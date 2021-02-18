//
//  HFanView.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/23.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "HFanView.h"

@interface HFanView ()

@property (nonatomic, strong) NSArray *rateArray;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, assign) CGFloat radies;
@property (nonatomic, assign) CGPoint rCenter;
@property (nonatomic, assign) CGFloat total;

@end

#define KOffsetRadius 10 //偏移距离


@implementation HFanView

- (instancetype)initWithFrame:(CGRect)frame radies:(CGFloat)radies rateDataArray:(nonnull NSArray <NSNumber *> *)rateArray colors:(nonnull NSArray <UIColor *> *)colors {
    self = [super initWithFrame:frame];
    if (self) {
        _radies = radies;
        _rCenter = CGPointMake(frame.size.width/2, frame.size.height/2);
        _rateArray = rateArray;
        _colors = colors;
        [self initMaskShapeLayer];
    }
    return self;
}

- (void)initMaskShapeLayer {
    _maskLayer = [[CAShapeLayer alloc] init];
    //通过mask来控制显示区域
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithArcCenter:_rCenter radius:self.bounds.size.width/4.f startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    //设置边框颜色为不透明，则可以通过边框的绘制来显示整个view
     _maskLayer.strokeColor = [UIColor greenColor].CGColor;
     _maskLayer.lineWidth = self.bounds.size.width/2.f;
     //设置填充颜色为透明，可以通过设置半径来设置中心透明范围
     _maskLayer.fillColor = [UIColor clearColor].CGColor;
     _maskLayer.path = maskPath.CGPath;
     _maskLayer.strokeEnd = 0;
     self.layer.mask = _maskLayer;
}

- (void)drawFanRect {
    CGFloat startAng = - M_PI_2;
    CGFloat endAng = startAng;
    //计算总和
    _total = 0.0f;
    for (int i = 0; i < _rateArray.count; i++) {
        _total += [_rateArray[i] floatValue];
    }
    
    for (int i = 0; i < _rateArray.count; i++) {
        //4.计算当前end位置 = 上一个结束位置 + 当前部分百分比
        endAng = startAng + M_PI*2 *[_rateArray[i] floatValue];
        HFanShapeLayer *shapeLayer = [HFanShapeLayer layer];
        [self.layer addSublayer:shapeLayer];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:_rCenter];
        [path addArcWithCenter:_rCenter radius:_radies startAngle:startAng endAngle:endAng clockwise:YES];
        
        shapeLayer.fillColor = [_colors[i] CGColor];
        shapeLayer.startAngle = startAng;
        shapeLayer.endAngle = endAng;
        shapeLayer.path = path.CGPath;
        
        startAng = endAng;
    }
    [self stroke];
}

- (void)stroke {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.f;
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:1.f];
    //禁止还原
    animation.autoreverses = NO;
    //禁止完成即移除
    animation.removedOnCompletion = NO;
    //让动画保持在最后状态
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_maskLayer addAnimation:animation forKey:@"strokeEnd"];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.anyObject locationInView:self];
    
    [self upDateLayersWithPoint:point];
    
    NSLog(@"%@",NSStringFromCGPoint(point));
}

- (void)upDateLayersWithPoint:(CGPoint)point{
    
    //如需做点击效果，则应采用第二种方法较好
    for (HFanShapeLayer *layer in self.layer.sublayers) {
        
        if (CGPathContainsPoint(layer.path, &CGAffineTransformIdentity, point, 0) && !layer.isSelect) {
            layer.isSelect = YES;
            
            //原始中心点为（0，0），扇形所在圆心、原始中心点、偏移点三者是在一条直线，通过三角函数即可得到偏移点的对应x，y。
            CGPoint currPos = layer.position;
            double middleAngle = (layer.startAngle + layer.endAngle)/2.0;
            CGPoint newPos = CGPointMake(currPos.x + KOffsetRadius*cos(middleAngle), currPos.y + KOffsetRadius*sin(middleAngle));
            layer.position = newPos;
//            CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
//            opacityAnimation.fromValue = @0.8;
//            opacityAnimation.toValue = @1.2;
//            opacityAnimation.duration = 0.5;
//            opacityAnimation.autoreverses = YES;
//            opacityAnimation.repeatCount = INFINITY;
//            opacityAnimation.fillMode = kCAFillModeBoth;
//            opacityAnimation.removedOnCompletion = NO;
//            [layer addAnimation:opacityAnimation forKey:@"beginHeartbeatAnimation"];
        }else{
            
            layer.position = CGPointMake(0, 0);
            layer.isSelect = NO;
//            CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
//            opacityAnimation.fromValue = @0.8;
//            opacityAnimation.toValue = @1;
//            opacityAnimation.duration = 0.5;
//            opacityAnimation.autoreverses = YES;
//            opacityAnimation.repeatCount = INFINITY;
//            opacityAnimation.fillMode = kCAFillModeBoth;
//            opacityAnimation.removedOnCompletion = NO;
//            [layer addAnimation:opacityAnimation forKey:@"beginHeartbeatAnimation"];
        }
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end












@implementation HFanShapeLayer


@end
