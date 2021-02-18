//
//  HProgressView.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/25.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "HProgressView.h"
#import "HColorTextLabel.h"

@interface HProgressView ()

@property (nonatomic, assign) CGFloat progressValue;

@property (nonatomic, strong) CAShapeLayer *bgLayer;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) HColorTextLabel *titleLabel;
@property (nonatomic, assign) CGFloat titlePrecent;
@property (nonatomic, strong) CAGradientLayer *gradientTitleLayer;


@end

#define RGB(r,g,b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.0]

@implementation HProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _progressValue = 0.0;
        [self initWithBgLayer];
//        [self setup];
    }
    return self;
}

- (void)setup{
    
    [self.layer addSublayer:self.bgLayer];
    [self.layer addSublayer:self.gradientLayer];
//    if (_showTitle) {
//        if (_style == XZMGradientProgressStyleLine) {
//            [self.layer addSublayer:self.gradientTitleLayer];
//        }else{
//            [self addSubview:self.titleLabel];
//            self.titleLabel.center = CGPointMake(Width(self)/2.f, Height(self)/2.f);
//        }
//    }
}

- (void)startDraw {
    _progressValue = 1;
    [self.maskLayer addAnimation:[self basicAnimationWithKey:@"strokeEnd" toValue:@(_progressValue)] forKey:@"strokeEnd"];
}


#pragma mark -- Lazzy
- (CAShapeLayer *)bgLayer{
    if(!_bgLayer){
        _bgLayer = [CAShapeLayer layer];
        _bgLayer.lineWidth = 5;
        _bgLayer.strokeColor = RGB(243, 243, 243).CGColor;
        _bgLayer.fillColor = [UIColor clearColor].CGColor;
        _bgLayer.lineCap = kCALineCapRound;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(50, 300)];
        [path addLineToPoint:CGPointMake(300, 300)];
        _bgLayer.path = [path CGPath];
    }
    return _bgLayer;
}

- (CAShapeLayer *)maskLayer{
    
    if(!_maskLayer){
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.fillColor = [UIColor clearColor].CGColor;
        _maskLayer.lineWidth = 5;
        _maskLayer.strokeColor = [UIColor redColor].CGColor;
        _maskLayer.lineCap = kCALineCapRound;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 5)];
        [path addLineToPoint:CGPointMake(250, 5)];
        _maskLayer.path = [path CGPath];
        _maskLayer.strokeEnd = 0;
    }
    return _maskLayer;
}

- (CAGradientLayer *)gradientLayer{
    
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        CGRect rect;
        rect = CGRectMake(50, 295, self.frame.size.width, 10);
        _gradientLayer.frame = rect;
        _gradientLayer.cornerRadius = 10/2.f;
        _gradientLayer.masksToBounds = YES;
        _gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor redColor].CGColor,(id)[UIColor cyanColor].CGColor,(id)[UIColor magentaColor].CGColor, nil];
//        _gradientLayer.locations = [self getLocations];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1, 0);
        _gradientLayer.mask = self.maskLayer;
    }
    return _gradientLayer;
}

- (CABasicAnimation *)basicAnimationWithKey:(NSString *)key toValue:(NSValue *)toValue{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 2;
    animation.repeatCount = 1;
    animation.toValue = toValue;
    //禁止还原
    animation.autoreverses = NO;
    //禁止完成即移除
    animation.removedOnCompletion = NO;
    //让动画保持在最后状态
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}


- (void)initWithBgLayer {
    CAShapeLayer *bgShapeLayer = [CAShapeLayer layer];
    bgShapeLayer.lineWidth = 5;
    bgShapeLayer.lineCap = kCALineCapRound;
    bgShapeLayer.fillColor = [UIColor clearColor].CGColor;
    bgShapeLayer.strokeColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:bgShapeLayer];
    
    UIBezierPath *bgPath = [UIBezierPath bezierPath];
//    [bgPath moveToPoint:CGPointMake(50, 200)];
//    [bgPath addLineToPoint:CGPointMake(300, 200)];
    [bgPath addArcWithCenter:CGPointMake(100, 500) radius:75 startAngle:-M_PI_4*5 endAngle:M_PI_4 clockwise:YES];
    bgShapeLayer.path = bgPath.CGPath;
    
    [self initMaskProgressView];
}

- (void)initMaskProgressView {
//    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:50.0f startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//
//    CAShapeLayer * shapeLayer= [CAShapeLayer layer];
//    shapeLayer.frame = CGRectMake(15, 15, 0, 0);
//    //边缘颜色
//    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
//    //填充颜色
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    //端点处的样式
//    shapeLayer.lineCap = @"round";
//    //轨迹
//    shapeLayer.path = path.CGPath;
//
//    //画虚线的时候用
//    //从10的坐标点开始显示
//    //    shapeLayer.lineDashPhase = 10;
//    //画10个点,空20格点,画20个点,虚10个点,画20个点,,,这样这三个数一直循环
//    //    shapeLayer.lineDashPattern = @[@10,@20,@20];
//
//
//    shapeLayer.lineWidth = 10.0f;
//    //开始点
//    shapeLayer.strokeStart = 0.0;
//    //结束点
//    shapeLayer.strokeEnd = 0.8f;
////    self.start = 0.0;
////    self.end = 0.8;
////
////    self.shapeL = shapeLayer;
//    [self.layer addSublayer:shapeLayer];
//    [self.layer setMask:shapeLayer];
//
////    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        shapeLayer.speed = 0.1;
////        shapeLayer.strokeStart = 0.5;
////        shapeLayer.strokeEnd= 0.9;
////        shapeLayer.lineWidth = 6.0f;
////    });
//
//    CABasicAnimation * basicA = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    basicA.duration = 1.0f;
//    basicA.fromValue = @(0.0f);
//    basicA.toValue = @(0.8f);
//    [shapeLayer addAnimation:basicA forKey:@"anyone"];
//
//    CAGradientLayer * colorLager = [CAGradientLayer layer];
//    colorLager.frame =CGRectMake(0, 0, self.bounds.size.width+15, self.bounds.size.height+15);
//
//    [colorLager setColors:[NSArray arrayWithObjects:(id)[UIColor redColor].CGColor,(id)[UIColor cyanColor].CGColor,(id)[UIColor magentaColor].CGColor,nil]];
//    colorLager.shadowPath = path.CGPath;
//    [colorLager setLocations:@[@(0.2),@(0.3),@(0.8)]];
//    [colorLager setStartPoint:CGPointMake(0, 0)];
//    [colorLager setEndPoint:CGPointMake(1, 1)];
//
//    [self.layer addSublayer:colorLager];
    

    CAShapeLayer *maskShapeLayer = [CAShapeLayer layer];
    maskShapeLayer.lineWidth = 5;
    maskShapeLayer.lineCap = kCALineCapRound;
//    maskShapeLayer.strokeStart = 0;
    maskShapeLayer.strokeEnd = 0;
    maskShapeLayer.fillColor = [UIColor clearColor].CGColor;
    maskShapeLayer.strokeColor = [UIColor redColor].CGColor;
//    [_bgView.layer addSublayer:maskShapeLayer];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
//    [maskPath moveToPoint:CGPointMake(50, 200)];
//    [maskPath addLineToPoint:CGPointMake(300, 200)];
    [maskPath addArcWithCenter:CGPointMake(100, 500) radius:75 startAngle:-M_PI_4*5 endAngle:M_PI_4 clockwise:YES];
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    gradientLayer.locations = @[@0.3,@0.5,@0.8];
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor brownColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    maskShapeLayer.path = maskPath.CGPath;
    [gradientLayer setMask:maskShapeLayer];
    [self.layer addSublayer:gradientLayer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_progressValue = 0.8;
        [maskShapeLayer addAnimation:[self basicAnimationWithKey:@"strokeEnd" toValue:@(self->_progressValue)] forKey:@"strokeEnd"];
    });
    
    _titleLabel = [[HColorTextLabel alloc]initWithFrame:CGRectMake(50, 180, 50, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textAlignment = 1;
    _titleLabel.text = @"0%";
    [self addSubview:_titleLabel];
    
    _gradientTitleLayer = [[CAGradientLayer alloc]init];
    _gradientTitleLayer.frame = CGRectMake(0, 100, self.frame.size.width, 40);
    _gradientTitleLayer.colors = @[(id)[UIColor grayColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor brownColor].CGColor];;
//    _gradientTitleLayer.locations = [self getLocations];
    _gradientTitleLayer.startPoint = CGPointZero;
    _gradientTitleLayer.endPoint = CGPointMake(0, 1);
//    _gradientTitleLayer.mask = self.titleLabel.layer;
//    [self.layer addSublayer:self.gradientTitleLayer];
    
    
    CAShapeLayer *titleShapeLayer = [CAShapeLayer layer];
    titleShapeLayer.lineWidth = 5;
    titleShapeLayer.lineCap = kCALineCapRound;
    //    maskShapeLayer.strokeStart = 0;
    titleShapeLayer.strokeEnd = 0;
    titleShapeLayer.fillColor = [UIColor blueColor].CGColor;
    titleShapeLayer.strokeColor = [UIColor redColor].CGColor;
    //    [_bgView.layer addSublayer:maskShapeLayer];
    
    UIBezierPath *titlePath = [UIBezierPath bezierPath];
    [titlePath moveToPoint:CGPointMake(50, 200)];
    [titlePath addLineToPoint:CGPointMake(50, 20)];
    
    titleShapeLayer.path = titlePath.CGPath;
    _gradientTitleLayer.mask = titleShapeLayer;
//    titleShapeLayer.mask = self.titleLabel.layer;
    [self.titleLabel.layer addSublayer:_gradientTitleLayer];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2 animations:^{
            _titleLabel.frame = CGRectMake(50, 20, 40, 20);
        } completion:^(BOOL finished) {
            
        }];
//        [self.titleLabel.layer addAnimation:[self basicAnimationWithKey:@"position"
//                                   toValue:[NSValue valueWithCGPoint:CGPointMake(self.frame.size.width/2, 10/2.f)]]
//        forKey:@"position"];
//        self->_progressValue = 0.8;
//        titleShapeLayer.strokeEnd = 0.8;
//        [titleShapeLayer addAnimation:[self basicAnimationWithKey:@"strokeEnd" toValue:@(self->_progressValue)] forKey:@"strokeEnd"];
        
        self->_titlePrecent = 0;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeTitleText:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    });
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation.duration = 1.f;
//    animation.fromValue = [NSNumber numberWithFloat:0.f];
//    animation.toValue = [NSNumber numberWithFloat:_progressValue];
//    maskShapeLayer.strokeEnd = _progressValue;
//    // 禁止还原
//    animation.autoreverses = NO;
//    // 禁止完成即移除
//    animation.removedOnCompletion = NO;
//    // 让动画保持在最后状态
//    animation.fillMode = kCAFillModeForwards;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [maskShapeLayer addAnimation:animation forKey:@"strokeEnd"];
//    [CATransaction commit];
}

- (void)changeTitleText:(NSTimer *)timer{
    _titlePrecent += _progressValue*100.f/(2/0.1f);
    if (_titlePrecent > _progressValue*100) {
        [timer invalidate];
        timer = nil;
        _titlePrecent = _progressValue*100;
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%.0f%%",_titlePrecent];
    
}

//- (void)commonInit{
//    _progressValue = 0.8;
//    [self initWithBgLayer];
//
//    [self initMaskProgressView];
//}
//
//- (void)initWithBgLayer {
////    CAShapeLayer *bgShapeLayer = [CAShapeLayer layer];
////    bgShapeLayer.lineWidth = 5;
////    bgShapeLayer.lineCap = kCALineCapRound;
////    bgShapeLayer.fillColor = [UIColor clearColor].CGColor;
////    bgShapeLayer.strokeColor = [UIColor yellowColor].CGColor;
////    [self.layer addSublayer:bgShapeLayer];
////
//    UIBezierPath *bgPath = [UIBezierPath bezierPath];
//    [bgPath moveToPoint:CGPointMake(50, 200)];
//    [bgPath addLineToPoint:CGPointMake(300, 200)];
//    _bgShapeLayer.path = bgPath.CGPath;
//
//    [self.layer addSublayer:_bgShapeLayer];
////
////    [self initMaskProgressView];
//}
//
//- (CAShapeLayer *)bgShapeLayer {
//    if (!_bgShapeLayer) {
//        _bgShapeLayer = [CAShapeLayer layer];
//        _bgShapeLayer.lineCap = kCALineCapRound;
//        _bgShapeLayer.lineWidth = 5;
//        _bgShapeLayer.fillColor = [UIColor yellowColor].CGColor;
//    }
//    return _bgShapeLayer;
//}
//
//- (void)initMaskProgressView {
//
//    UIBezierPath *maskPath = [UIBezierPath bezierPath];
//    [maskPath moveToPoint:CGPointMake(50, 200)];
//    [maskPath addLineToPoint:CGPointMake(300, 200)];
//
//    self.maskShapeLayer = [CAShapeLayer layer];
//    self.maskShapeLayer.lineWidth = 5;
//    self.maskShapeLayer.lineCap = kCALineCapRound;
//    self.maskShapeLayer.fillColor = [UIColor clearColor].CGColor;
//    self.maskShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = CGRectMake(0,0,self.frame.size.width,self .frame.size.height);
//    gradient.colors = @[(id)[UIColor colorWithRed:1
//                                            green:178 / 255.0
//                                             blue:101 / 255.0
//                                            alpha:1].CGColor,
//                        (id)[UIColor colorWithRed:1
//                                            green:69 / 255.0
//                                             blue:69 / 255.0
//                                            alpha:1].CGColor];
//        [gradient setLocations:@[@0, @0.5, @0.7]];
//    gradient.startPoint = CGPointMake(0, 0);
//    gradient.endPoint = CGPointMake(1.0, 0);
//    self.maskShapeLayer.path = maskPath.CGPath;
//    [gradient setMask:self.maskShapeLayer];
//    [self.layer addSublayer:gradient];
//
//
//    [self setCurrentProgress:_progressValue];
//}
//
//- (void)setCurrentProgress:(CGFloat)progress {
//
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation.duration = 2;
//    self.maskShapeLayer.strokeEnd = progress;
//
//    [self.maskShapeLayer addAnimation:animation forKey:@"animationStrokeEnd"];
//    [CATransaction commit];
//
//    _progressValue = progress;
//
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
