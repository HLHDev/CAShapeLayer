//
//  HBrokenLineXYView.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/19.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "HBrokenLineXYView.h"
#import "HBasicShapeLayer.h"
#import "HBrokenPointInfoView.h"

@interface HBrokenLineXYView()

// x轴间距
@property (nonatomic, assign) CGFloat xAxisSpac;
// y轴间距
@property (nonatomic, assign) CGFloat yAxisSpac;
// 显示y轴虚线
@property (nonatomic, assign) BOOL isShowYLine;
// 显示x轴虚线
@property (nonatomic, assign) BOOL isShowXline;
// 原点坐标
@property (nonatomic, assign) CGPoint originPoint;

// x轴总长度
@property (nonatomic, assign) CGFloat yHight;
// y轴总长度
@property (nonatomic, assign) CGFloat xWidth;
// x轴距离superView的距离
@property (nonatomic, assign) CGFloat xTopSpace;
// y轴距离superView的距离
@property (nonatomic, assign) CGFloat yTopSpace;

@property (nonatomic, strong) HBrokenPointInfoView *infoView;

@property (nonatomic, strong) NSMutableArray *topPointArray;


@end

@implementation HBrokenLineXYView

- (instancetype)initWithXAxisArray:(NSArray *)xAxisArray YAxis:(NSArray *)yAxisArray XAxisSpac:(CGFloat)xAxisSpac YAxisSpac:(CGFloat)yAxisSpac isSowXLine:(BOOL)isShowXline isShowYLine:(BOOL)isShowYLine {
    self = [super init];
    if (self) {
        self.xNodeArray = xAxisArray;
        self.yNodeArray = yAxisArray;
        self.xAxisSpac = xAxisSpac;
        self.yAxisSpac = yAxisSpac;
        self.isShowXline = isShowXline;
        self.isShowYLine = isShowYLine;
        
        self.topPointArray = [[NSMutableArray alloc] init];
        
        [self calculateoriginPoint];
        [self drawXLineLayer];
        [self drawYLineLayer];
        
        [self createYLineLabel];
        [self createXLineLabel];
        
        [self calculatePointDotLocation];
        
        [self drawLine];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self drawLine];
//        });
        [self addSubview:self.infoView];
    }
    return self;
}

- (HBrokenPointInfoView *)infoView {
    if (!_infoView) {
        _infoView = [[HBrokenPointInfoView alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
        _infoView.alpha = 0;
    }
    return _infoView;
}

// 计算坐标
- (void)calculateoriginPoint {
    _xTopSpace = 20;
    _yTopSpace = 10;
    _xWidth = (self.xNodeArray.count+1) * _xAxisSpac + _xAxisSpac/2;
    _yHight = self.yNodeArray.count * _yAxisSpac + _yAxisSpac/2 + _yTopSpace;
    _originPoint = CGPointMake(_xTopSpace, _yHight);
    
    _dotArray = @[@"0.5",@"0.2",@"1",@"1.3",@"0.8",@"0.4",@"0.9",@"1.8",@"1.1",@"0.7"];
}

// x轴
- (void)drawXLineLayer {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.lineWidth = 2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_originPoint];
    [path addLineToPoint:CGPointMake(_xWidth, _yHight)];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 1.0;
    
    [shapeLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    
    for (NSInteger i = 1;i < self.xNodeArray.count + 1; i++ ) {
        // 分割线属性
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor darkTextColor].CGColor;
        dashLayer.fillColor = [UIColor darkTextColor].CGColor;
        dashLayer.lineWidth = 0.5;
        dashLayer.lineDashPattern = @[@5,@5];
        // 绘制分割线
        UIBezierPath *path = [[UIBezierPath alloc]init];
        // 分割线起始点
        [path moveToPoint:CGPointMake(_xTopSpace + self.xAxisSpac * i, self.yHight)];
        [path addLineToPoint:CGPointMake(_xTopSpace + self.xAxisSpac * i, _yTopSpace)];
        dashLayer.path = path.CGPath;
        [self.layer addSublayer:dashLayer];
        
        CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
        ani.fromValue = @0;
        ani.toValue = @1;
        ani.duration = 1.0;
        
        [dashLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    }
}

// y轴
- (void)drawYLineLayer {
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.lineWidth = 2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_originPoint];
    [path addLineToPoint:CGPointMake(_xTopSpace, _yTopSpace)];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 1.0;
    
    [shapeLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    for (NSInteger i = 0;i < self.yNodeArray.count; i++ ) {
        // 分割线属性
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor darkTextColor].CGColor;
        dashLayer.fillColor = [UIColor darkTextColor].CGColor;
        dashLayer.lineWidth = 0.5;
        dashLayer.lineDashPattern = @[@5,@5];
        // 绘制分割线
        UIBezierPath *path = [[UIBezierPath alloc]init];
        // 分割线起始点
        [path moveToPoint:CGPointMake(_xTopSpace, _yTopSpace + _yAxisSpac/2 + self.yAxisSpac * i)];
        [path addLineToPoint:CGPointMake(_xWidth, _yTopSpace + _yAxisSpac/2 + self.yAxisSpac * i)];
        
        dashLayer.path = path.CGPath;
        [self.layer addSublayer:dashLayer];
        
        CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
        ani.fromValue = @0;
        ani.toValue = @1;
        ani.duration = 1.0;
        
        [dashLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    }
}

// x轴标题
- (void)createXLineLabel {
    for (int i = 1; i < self.xNodeArray.count+1; i++) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(_xTopSpace + self.xAxisSpac * i - 15, _yHight, 30, 20);
        titleLabel.text = self.xNodeArray[i - 1];
        titleLabel.tag = 100+i-1;
        titleLabel.textColor = [UIColor redColor];
        titleLabel.font = [UIFont systemFontOfSize:10];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
    }
}

// y轴标题
- (void)createYLineLabel {
    for (int i = 0; i < self.yNodeArray.count; i++) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, _yTopSpace + _yAxisSpac/2 + self.yAxisSpac * i - 20/2, _xTopSpace, 20);
        titleLabel.text = self.yNodeArray[self.yNodeArray.count-1 - i];
        titleLabel.textColor = [UIColor redColor];
        titleLabel.tag = 300+i;
        titleLabel.font = [UIFont systemFontOfSize:10];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
    }
}

// 计算坐标点数据
- (void)calculatePointDotLocation {
    
    for (int i = 0; i < _dotArray.count; i++) {
        NSString *value = _dotArray[i];
        CGFloat dotV = [value floatValue];
        CGFloat hight = (float)dotV/2 * (self.yNodeArray.count * _yAxisSpac);
        
        CGFloat mhight = (self.yNodeArray.count * _yAxisSpac) - hight;
        
        CGFloat rsultH = _yAxisSpac/2 + _yTopSpace + mhight;
        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(0, 0, 20, 20);;
//        button.backgroundColor = [UIColor blueColor];
//        button.center = CGPointMake(_xTopSpace + self.xAxisSpac * (i + 1), _yHight);
//        button.alpha = 0;
//        button.tag = 500+i;
//        button.layer.cornerRadius = 10;
//        button.layer.masksToBounds = YES;
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:button];
//        [UIView animateWithDuration:1 animations:^{
//            button.center = CGPointMake(self->_xTopSpace + self.xAxisSpac * (i + 1), rsultH);
//            button.alpha = 1;
//        } completion:^(BOOL finished) {
//            button.alpha = 1;
//            [self bringSubviewToFront:button];
//        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, 20, 20);
        titleLabel.backgroundColor = [UIColor blueColor];
        titleLabel.center = CGPointMake(_xTopSpace + self.xAxisSpac * (i + 1), _yHight);
        titleLabel.alpha = 0;
        titleLabel.tag = 500+i;
        titleLabel.layer.cornerRadius = 10;
        titleLabel.layer.masksToBounds = YES;
        titleLabel.userInteractionEnabled = YES;
        [self addSubview:titleLabel];
        
        UILongPressGestureRecognizer *recongnizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizer:)];
        [titleLabel addGestureRecognizer:recongnizer];
        
        [UIView animateWithDuration:1 animations:^{
            titleLabel.center = CGPointMake(self->_xTopSpace + self.xAxisSpac * (i + 1), rsultH);
            titleLabel.alpha = 1;
        } completion:^(BOOL finished) {
            titleLabel.alpha = 1;
            [self bringSubviewToFront:titleLabel];
        }];
    }
}

// 画折线(直线)
- (void)drawLine {
    // 折线属性
    HBasicShapeLayer * dashLayer = [HBasicShapeLayer layer];
    dashLayer.strokeColor = [UIColor blackColor].CGColor;
    dashLayer.fillColor = [UIColor clearColor].CGColor;
    dashLayer.tag = 1000;
    dashLayer.lineWidth = 2;
    // 绘制折线
    UIBezierPath * path = [[UIBezierPath alloc]init];
    // 折线图起点 brokenOrigin
    CGPoint brokenOrigin = CGPointMake(_xTopSpace, _yHight);
    // 折线起点
    [path moveToPoint:brokenOrigin];
    [self.layer addSublayer:dashLayer];
    // 便利折线图数据
    for (int i = 0;i < _dotArray.count; i++ ) {
        NSString *value = _dotArray[i];
        CGFloat dotV = [value floatValue];
        CGFloat hight = (float)dotV/2 * (self.yNodeArray.count * _yAxisSpac);
        
        CGFloat mhight = (self.yNodeArray.count * _yAxisSpac) - hight;
        
        CGFloat rsultH = _yAxisSpac/2 + _yTopSpace + mhight;
        // 折线终点
        brokenOrigin = CGPointMake(_xTopSpace + self.xAxisSpac * (i + 1), rsultH);
        [path addLineToPoint:brokenOrigin];
        dashLayer.path = path.CGPath;
    }
    // 折线显示动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [dashLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

// 画折线（曲线）
- (void)drawLineCurve {
    // 折线属性
    HBasicShapeLayer * dashLayer = [HBasicShapeLayer layer];
    dashLayer.strokeColor = [UIColor blackColor].CGColor;
    dashLayer.fillColor = [UIColor redColor].CGColor;
    dashLayer.tag = 1000;
    dashLayer.lineWidth = 2;
    // 绘制折线
    UIBezierPath * path = [[UIBezierPath alloc]init];
    // 折线图起点 brokenOrigin
    CGPoint brokenOrigin = CGPointMake(_xTopSpace, _yHight);
    [self.layer addSublayer:dashLayer];
    CGPoint PrePonit;
    // 便利折线图数据
    for (int i = 0;i < _dotArray.count; i++ ) {
        NSString *value = _dotArray[i];
        CGFloat dotV = [value floatValue];
        CGFloat hight = (float)dotV/2 * (self.yNodeArray.count * _yAxisSpac);
        
        CGFloat mhight = (self.yNodeArray.count * _yAxisSpac) - hight;
        
        CGFloat rsultH = _yAxisSpac/2 + _yTopSpace + mhight;
        // 折线终点
        brokenOrigin = CGPointMake(_xTopSpace + self.xAxisSpac * (i + 1), rsultH);
        
        if (i==0) {
            // 折线起点
            PrePonit = CGPointMake(_xTopSpace + self.xAxisSpac * (i + 1), rsultH);
            [path moveToPoint:PrePonit];
        }else{
            CGPoint NowPoint = brokenOrigin;
            [path addCurveToPoint:NowPoint controlPoint1:CGPointMake((PrePonit.x+NowPoint.x)/2, PrePonit.y) controlPoint2:CGPointMake((PrePonit.x+NowPoint.x)/2, NowPoint.y)]; //三次曲线
            PrePonit = NowPoint;
        }
        dashLayer.path = path.CGPath;
    }
    // 折线显示动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [dashLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}


- (void)drawGredientLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:250/255.0 green:170/255.0 blue:10/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.4].CGColor];
    
    gradientLayer.locations=@[@0.0,@1.0];
    gradientLayer.startPoint = CGPointMake(0.0,0.0);
    gradientLayer.endPoint = CGPointMake(1,0);
   
    
//    UIBezierPath *gradientPath = [UIBezierPath bezierPath];
//    CGPoint topPoint1 = CGPointFromString(_topPointArray[0]);
//    [gradientPath moveToPoint:CGPointMake([_topPointArray[0] floatValue], self.frame.size.height-bottomMarginScale)];
//    for (int i=0; i<_LineChartDataArray.count; i++) {
//        [gradientPath addLineToPoint:CGPointMake([_pointXArray[i] floatValue], self.frame.size.height-[_LineChartDataArray[i] floatValue]-bottomMarginScale)];
//    }
//    [gradientPath addLineToPoint:CGPointMake([_pointXArray[_pointXArray.count-1] floatValue], self.frame.size.height-bottomMarginScale)];
//    CAShapeLayer *arc = [CAShapeLayer layer];
//    arc.path = gradientPath.CGPath;
//    gradientLayer.mask = arc;
//    [self.mainScroll.layer addSublayer:gradientLayer];

}

/// Touch Method
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = touches.anyObject;
//    CGPoint point = [touch locationInView:self];
//    [self touchLayerWithPoint:point];
//}
//
//- (void)touchLayerWithPoint:(CGPoint)point {
//    NSMutableArray *subbarLayers = [NSMutableArray array];
//    for (CALayer *sublayer in self.layer.sublayers) {
//        if ([sublayer isKindOfClass:[HBasicShapeLayer class]]) {
//            if (((HBasicShapeLayer *)sublayer).tag == 1000) {
//                [sublayer removeFromSuperlayer];
//                break;
//            }
//        }
//    }
//    __weak __typeof(self) weakSelf = self;
    
//    [subbarLayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        HMBasicLayer *layer = (HMBasicLayer *)obj;
//        CGPathRef path = layer.path;
//        if (CGPathContainsPoint(path, &CGAffineTransformIdentity, point, NO)) {
//            if (weakSelf.completionValue) {
//                weakSelf.completionValue(layer.userInfo);
//            }
//        }
//    }];
//}

// 刷新x轴数据
- (void)reloadXNodeSubViews {
    for (int i = 0; i < _xNodeArray.count; i++) {
        UILabel *titleLabel = [self viewWithTag:100+i];
        titleLabel.text = _xNodeArray[i];
    }
}
// 刷新Y轴数据
- (void)reloadYNodeSubViews {
    for (int i = 0; i < _yNodeArray.count; i++) {
        UILabel *titleLabel = [self viewWithTag:300+i];
        titleLabel.text = self.yNodeArray[self.yNodeArray.count-1 - i];
    }
}

// 刷新折线数据
- (void)reloadLineChatView {
    for (int i = 0; i < _dotArray.count; i++) {
        NSString *value = _dotArray[i];
        CGFloat dotV = [value floatValue];
        CGFloat hight = (float)dotV/2 * (self.yNodeArray.count * _yAxisSpac);
        
        CGFloat mhight = (self.yNodeArray.count * _yAxisSpac) - hight;
        
        CGFloat rsultH = _yAxisSpac/2 + _yTopSpace + mhight;
        
        UIButton *button = [self viewWithTag:500+i];
//        titleLabel.text = _yNodeArray[i];
        button.alpha = 0;
        button.center = CGPointMake(_xTopSpace + self.xAxisSpac * (i + 1), _yHight);
        [UIView animateWithDuration:1 animations:^{
            button.center = CGPointMake(self->_xTopSpace + self.xAxisSpac * (i + 1), rsultH);
            button.alpha = 1;
        } completion:^(BOOL finished) {
            button.alpha = 1;
            [self bringSubviewToFront:button];
        }];
    }
    
    for (CALayer *sublayer in self.layer.sublayers) {
        if ([sublayer isKindOfClass:[HBasicShapeLayer class]]) {
            if (((HBasicShapeLayer *)sublayer).tag == 1000) {
                [sublayer removeFromSuperlayer];
                break;
            }
        }
    }
    [self drawLine];
}

- (void)buttonAction:(UIButton *)sender {
    CGRect rect = sender.frame;
    NSLog(@"rect.origin.x = %lf, rect.origin.x = %lf",rect.origin.x,rect.origin.y);
    
    CGFloat halfFloat = [[UIScreen mainScreen] bounds].size.width/2;
    CGRect vRect;
    if (rect.origin.x < halfFloat) {
        CGFloat orx = sender.center.x + rect.size.width/2 +5;
        CGFloat ory = sender.center.y - 60/2;
        CGFloat w = 100;
        CGFloat h = 60;
        vRect = CGRectMake(orx, ory, w, h);
    } else {
        CGFloat orx = sender.center.x - rect.size.width/2 - 5 - 100;
        CGFloat ory = sender.center.y - 60/2;
        CGFloat w = 100;
        CGFloat h = 60;
        vRect = CGRectMake(orx, ory, w, h);
    }
    [UIView animateWithDuration:1 animations:^{
        self.infoView.frame = vRect;
    } completion:^(BOOL finished) {
        self.infoView.alpha = 1;
    }];
}

- (void)longPressGestureRecognizer:(UILongPressGestureRecognizer *)gesture {
    
    NSInteger tag = [gesture view].tag;
    UILabel *titleLabel = [self viewWithTag:tag];
    // 一般开发中,长按操作只会做一次
    // 假设在一开始长按的时候就做一次操作
//    NSLog(@"%ld",gesture.state);
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"%ld",gesture.state);
        CGRect rect = titleLabel.frame;
        NSLog(@"rect.origin.x = %lf, rect.origin.x = %lf",rect.origin.x,rect.origin.y);
        
        CGFloat halfFloat = [[UIScreen mainScreen] bounds].size.width/2;
        CGRect vRect;
        if (rect.origin.x < halfFloat) {
            CGFloat orx = titleLabel.center.x + rect.size.width/2 +5;
            CGFloat ory = titleLabel.center.y - 60/2;
            CGFloat w = 100;
            CGFloat h = 60;
            vRect = CGRectMake(orx, ory, w, h);
        } else {
            CGFloat orx = titleLabel.center.x - rect.size.width/2 - 5 - 100;
            CGFloat ory = titleLabel.center.y - 60/2;
            CGFloat w = 100;
            CGFloat h = 60;
            vRect = CGRectMake(orx, ory, w, h);
        }
        self.infoView.frame = vRect;
        [UIView animateWithDuration:1 animations:^{
            self.infoView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"%ld",gesture.state);
        [UIView animateWithDuration:1 animations:^{
//            self.infoView.frame = vRect;
            self.infoView.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
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
