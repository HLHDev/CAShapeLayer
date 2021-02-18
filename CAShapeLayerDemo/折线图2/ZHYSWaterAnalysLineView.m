//
//  ZHYSWaterAnalysLineView.m
//  ZHKJYouShuiApp
//
//  Created by H&L on 2020/1/10.
//  Copyright © 2020 Loveff. All rights reserved.
//

#import "ZHYSWaterAnalysLineView.h"
#import "HBasicShapeLayer.h"
#import "ZHYSExponentView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define FONT10SIZE       [UIFont systemFontOfSize:10]
#define FONT11SIZE       [UIFont systemFontOfSize:11]

@interface ZHYSWaterAnalysLineView ()


// 点的x轴
@property (nonatomic, strong) NSMutableArray *pointXArray;
// 点的y轴
@property (nonatomic, strong) NSMutableArray *pointYArray;

// x轴宽度
@property (nonatomic, assign) CGFloat maxWidth;
// y轴高度
@property (nonatomic, assign) CGFloat maxHight;

// 0~0.5高度
@property (nonatomic, assign) CGFloat biggerHight;
// 0.5～2.5高度
@property (nonatomic, assign) CGFloat smallHight;
// x轴间隔
@property (nonatomic, assign) CGFloat spaceXWith;
// x轴原点
@property (nonatomic, assign) CGFloat origenX;
// y轴原点
@property (nonatomic, assign) CGFloat origenY;
// y轴溢出高度
@property (nonatomic, assign) CGFloat overflowY;
// y轴距离视图顶部距离
@property (nonatomic, assign) CGFloat distancSlefY;
// y轴原点距离顶部
@property (nonatomic, assign) CGFloat allHightY;
// 单前点
@property (nonatomic, assign) int currentIndex;
// 光标
@property (nonatomic, strong) UIView *lineView;
//
@property (nonatomic, assign) int oldIndex;
// 光标时间显示
@property (nonatomic, strong) UILabel *dateLabel;
// 第一个日期
@property (nonatomic, strong) UILabel *firstXLabel;
// 最后一个日期
@property (nonatomic, strong) UILabel *lastXLabel;
// y轴单位
@property (nonatomic, strong) UILabel *unitYLabel;

// x轴单位
@property (nonatomic, strong) UILabel *unitXLabel;

// 渐变图层
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
// 指数
@property (nonatomic, strong) ZHYSExponentView *exponentView;

@end

@implementation ZHYSWaterAnalysLineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [NSMutableArray arrayWithObjects:@"0.1",@"0.2",@"0.11",@"0.3",@"0.7",@"0.32",@"0.36",@"1",@"1.1",@"1.5",@"2.3",@"2",@"1.6",@"0.5",@"0.31",@"0.22",@"0.1",@"0.5",@"0.4",@"0.3", nil];
        self.overflowY = 10;
        self.maxWidth = SCREEN_WIDTH - 60;
        self.biggerHight = 150;
        self.smallHight = 60;
        self.maxHight = _biggerHight + _smallHight + self.overflowY;
        self.spaceXWith = (self.maxWidth - 10)/20;
        self.distancSlefY = 25;
        self.origenX = 45;
        self.origenY = self.distancSlefY + self.maxHight;
        self.allHightY = self.distancSlefY + self.maxHight;
        self.currentIndex = 100;
        self.oldIndex = 100;
        [self initWithUI];
    }
    return self;
}

- (void)initWithUI {
    
    _pointXArray = [[NSMutableArray alloc] init];
    _pointYArray = [[NSMutableArray alloc] init];
    
    [self drawXLineLayer];
    [self drawYLineLayer];
    [self calculatePointDot];
    [self drawLine];
    [self drawPointDotLocation];
    [self drawGredientLayer];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:pan];
    
    [self addSubview:self.lineView];
    [self addSubview:self.dateLabel];
    [self addSubview:self.unitYLabel];

    [self addSubview:self.exponentView];
    
    [self addSubview:self.firstXLabel];
    [self addSubview:self.lastXLabel];
    [self addSubview:self.unitXLabel];
    
    self.unitYLabel.center = CGPointMake(_origenX, self.distancSlefY/2);
    self.firstXLabel.center = CGPointMake([_pointXArray[0] floatValue], self.maxHight+self.distancSlefY + 30/2);
    self.lastXLabel.center = CGPointMake([_pointXArray[_pointXArray.count - 1] floatValue]-5, self.maxHight+self.distancSlefY + 30/2);
    self.unitXLabel.center = CGPointMake([_pointXArray[_pointXArray.count - 1] floatValue] + 10, self.maxHight+self.distancSlefY + 30/2);
    
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(45+20, _distancSlefY + _overflowY, 0.5, self.maxHight - self.overflowY)];
        _lineView.backgroundColor = [UIColor whiteColor];
        _lineView.hidden = YES;
    }
    return _lineView;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(45+20, self.maxHight+self.distancSlefY + 30, 30, 30)];
        _dateLabel.text = @"19";
        _dateLabel.font = FONT10SIZE;
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.hidden = YES;
    }
    return _dateLabel;
}

- (UILabel *)unitYLabel {
    if (!_unitYLabel) {
        _unitYLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, self.distancSlefY)];
        _unitYLabel.text = @"（mg/L）";
        _unitYLabel.font = FONT10SIZE;
        _unitYLabel.textColor = [UIColor whiteColor];
        _unitYLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _unitYLabel;
}

- (UILabel *)firstXLabel {
    if (!_firstXLabel) {
        _firstXLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _firstXLabel.text = @"1";
        _firstXLabel.font = FONT10SIZE;
        _firstXLabel.textColor = [UIColor whiteColor];
        _firstXLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _firstXLabel;
}

- (UILabel *)lastXLabel {
    if (!_lastXLabel) {
        _lastXLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _lastXLabel.text = @"20";
        _lastXLabel.font = FONT10SIZE;
        _lastXLabel.textColor = [UIColor whiteColor];
        _lastXLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _lastXLabel;
}

- (UILabel *)unitXLabel {
    if (!_unitXLabel) {
        _unitXLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _unitXLabel.text = @"(日)";
        _unitXLabel.font = FONT10SIZE;
        _unitXLabel.textColor = [UIColor whiteColor];
        _unitXLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _unitXLabel;
}

- (ZHYSExponentView *)exponentView {
    if (!_exponentView) {
        _exponentView = [[ZHYSExponentView alloc] initWithFrame:CGRectMake(0, 0, 90, 55)];
        _exponentView.hidden = YES;
    }
    return _exponentView;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Began = %lf",point.x);
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (point.x > [_pointXArray[_pointXArray.count - 1] floatValue]) {
            _currentIndex = (int)_pointXArray.count-1;
        } else {
            for (int i =  0; i < _pointXArray.count; i++) {
                CGFloat pointX = [_pointXArray[i] floatValue];
                CGFloat resultW = point.x - pointX;
                if (resultW < _spaceXWith) {
                    if (resultW < _spaceXWith/2) {
                        _currentIndex = i;
                    } else {
                        _currentIndex = i+1;
                    }
                    break;
                }
            }
            NSLog(@"_currentIndex = %d",_currentIndex);
            if (_currentIndex > _pointXArray.count - 1) {
                _currentIndex = (int)_pointXArray.count-1;
            }
        }
        
        
        if (_oldIndex == _currentIndex) {
            return;
        }
        _oldIndex  = _currentIndex;
        _lineView.center = CGPointMake([_pointXArray[_currentIndex] floatValue], _distancSlefY + _overflowY+self.maxHight/2-5);
        _lineView.hidden = NO;
        _dateLabel.center = CGPointMake([_pointXArray[_currentIndex] floatValue], self.maxHight+self.distancSlefY + 30/2);
        if (_currentIndex == 0 || _currentIndex == _pointXArray.count -1) {
            _dateLabel.hidden = YES;
        } else {
            _dateLabel.hidden = NO;
        }
        
        if ([_pointXArray[_currentIndex] floatValue] <= SCREEN_WIDTH/2) {
            _exponentView.center = CGPointMake([_pointXArray[_currentIndex] floatValue] + 10 + 90/2, [_pointYArray[_currentIndex] floatValue]);
        } else {
            _exponentView.center = CGPointMake([_pointXArray[_currentIndex] floatValue] - 10 - 90/2, [_pointYArray[_currentIndex] floatValue]);
        }
        _exponentView.hidden = NO;
        
        _dateLabel.text = [NSString stringWithFormat:@"%d",_currentIndex+1];
        for (id emptyObj in self.subviews) {
            if ([emptyObj isKindOfClass:[UIButton class]]) {
                UIButton * btn = (UIButton *)emptyObj;
                [btn.layer removeAllAnimations];
            }
        }
        UIButton *sender = [self viewWithTag:500+_currentIndex];
        [self doScaleAnimationWithView:sender];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Ended = %lf",point.x);
        _lineView.hidden = YES;
        _oldIndex = 100;
        _dateLabel.hidden  = YES;
        _exponentView.hidden = YES;
         UIButton *sender = [self viewWithTag:500+_currentIndex];
        [sender.layer removeAllAnimations];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    CGPoint point = [touches.anyObject locationInView:self];
    
    
    for (int i =  0; i < _pointXArray.count; i++) {
        CGFloat pointX = [_pointXArray[i] floatValue];
        CGFloat resultW = point.x - pointX;
        if (resultW < _spaceXWith) {
            if (resultW < _spaceXWith/2) {
                _currentIndex = i;
            } else {
                _currentIndex = i+1;
            }
            break;
        }
    }
    if (_oldIndex == _currentIndex) {
        return;
    }
    _oldIndex  = _currentIndex;
    _lineView.center = CGPointMake([_pointXArray[_currentIndex] floatValue], _distancSlefY + _overflowY+self.maxHight/2-5);
    _lineView.hidden = NO;
    _dateLabel.center = CGPointMake([_pointXArray[_currentIndex] floatValue], self.maxHight+self.distancSlefY + 30/2);
    if (_currentIndex == 0 || _currentIndex == _pointXArray.count -1) {
        _dateLabel.hidden = YES;
    } else {
        _dateLabel.hidden = NO;
    }
    _dateLabel.text = [NSString stringWithFormat:@"%d",_currentIndex+1];
    
    if ([_pointXArray[_currentIndex] floatValue] <= SCREEN_WIDTH/2) {
        _exponentView.center = CGPointMake([_pointXArray[_currentIndex] floatValue] + 10 + 90/2, [_pointYArray[_currentIndex] floatValue]);
    } else {
        _exponentView.center = CGPointMake([_pointXArray[_currentIndex] floatValue] - 10 - 90/2, [_pointYArray[_currentIndex] floatValue]);
    }
    
    _exponentView.hidden = NO;
    
    for (id emptyObj in self.subviews) {
        if ([emptyObj isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton *)emptyObj;
            [btn.layer removeAllAnimations];
        }
    }
    UIButton *sender = [self viewWithTag:500+_currentIndex];
    [self doScaleAnimationWithView:sender];
    
    NSLog(@"touchesBegan_currentIndex = %d",_currentIndex);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    CGPoint point = [touches.anyObject locationInView:self];
    NSLog(@"Ended = %d",_currentIndex);
    _lineView.hidden = YES;
    _oldIndex = 100;
    _dateLabel.hidden  = YES;
    _exponentView.hidden = YES;
    UIButton *sender = [self viewWithTag:500+_currentIndex];
    [sender.layer removeAllAnimations];

}

- (void)calculatePointDot {
    [_pointXArray removeAllObjects];
    [_pointYArray removeAllObjects];
    for (int i = 0; i < _dataArray.count; i++) {
        NSString *value = _dataArray[i];
        CGFloat dotV = [value floatValue];
        
        CGFloat xdotPoint = 45 + 20 +_spaceXWith*i;
        CGFloat ydotPoint = 0;
        if (dotV <= 0.5) {
            CGFloat hight = dotV*2*self.biggerHight;
            ydotPoint = self.allHightY - hight;
        } else if (dotV > 0.5 && dotV<=1.5 ){
            CGFloat hight = (dotV - 0.5) * self.smallHight/2;
            ydotPoint = self.allHightY - hight - self.biggerHight;
        } else {
            CGFloat hight = (dotV - 1.5) * self.smallHight/2;
            ydotPoint = self.allHightY - hight - self.biggerHight - self.smallHight/2;
        }
        
        NSString *xstr = [NSString stringWithFormat:@"%.2lf",xdotPoint];
        NSString *ystr = [NSString stringWithFormat:@"%.2lf",ydotPoint];
        
        [_pointXArray addObject:xstr];
        [_pointYArray addObject:ystr];
    }
}

// x轴
- (void)drawXLineLayer {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 1;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_origenX, _origenY)];
    [path addLineToPoint:CGPointMake(_maxWidth+45, _origenY)];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 1.0;
    
    [shapeLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
}

// y轴
- (void)drawYLineLayer {
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 1;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_origenX, _origenY)];
    [path addLineToPoint:CGPointMake(_origenX, _distancSlefY)];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 1.0;
    [shapeLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    NSArray *titleArray = @[@"2",@"1.5",@"0.5"];
    for (NSInteger i = 0;i < 3; i++ ) {
        // 分割线属性
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor whiteColor].CGColor;
        dashLayer.fillColor = [UIColor whiteColor].CGColor;
        dashLayer.lineWidth = 0.5;
        dashLayer.lineDashPattern = @[@5,@5];
        // 绘制分割线
        UIBezierPath *path = [[UIBezierPath alloc]init];
        // 分割线起始点
        [path moveToPoint:CGPointMake(_origenX, _distancSlefY + _overflowY +30 *i)];
        [path addLineToPoint:CGPointMake(_maxWidth+45, _distancSlefY + _overflowY + 30*i)];
        dashLayer.path = path.CGPath;
        [self.layer addSublayer:dashLayer];

        CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
        ani.fromValue = @0;
        ani.toValue = @1;
        ani.duration = 1.0;
        [dashLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, (_distancSlefY + _overflowY +30 *i) - 20/2, 30, 20)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = FONT11SIZE;
        label.textColor = [UIColor whiteColor];
        label.text = titleArray[i];
        [self addSubview:label];
    }
}

// 画折线(直线)
- (void)drawLine {
    // 折线属性
    HBasicShapeLayer * dashLayer = [HBasicShapeLayer layer];
    dashLayer.strokeColor = [UIColor whiteColor].CGColor;
    dashLayer.fillColor = [UIColor clearColor].CGColor;
    dashLayer.tag = 1000;
    dashLayer.lineWidth = 1;
    // 绘制折线
    UIBezierPath * path = [[UIBezierPath alloc]init];
    // 折线图起点 brokenOrigin
    CGPoint brokenOrigin = CGPointMake(_origenX, _origenY);
    // 折线起点
    [path moveToPoint:brokenOrigin];
    [self.layer addSublayer:dashLayer];
    // 便利折线图数据
    for (int i = 0;i < _dataArray.count; i++ ) {

        // 折线终点
        CGFloat x = [_pointXArray[i] floatValue];
        CGFloat y = [_pointYArray[i] floatValue];
        CGPoint point = CGPointMake(x, y);
        [path addLineToPoint:point];
        dashLayer.path = path.CGPath;
    }
    // 折线显示动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [dashLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

// 计算坐标点数据
- (void)drawPointDotLocation {
    
    for (int i = 0; i < _dataArray.count; i++) {
        
//        UILabel *titleLabel = [[UILabel alloc] init];
//        titleLabel.frame = CGRectMake(0, 0, 10, 10);
//        titleLabel.backgroundColor = [UIColor whiteColor];
//        CGFloat x = [_pointXArray[i] floatValue];
//        CGFloat y = [_pointYArray[i] floatValue];
//        titleLabel.alpha = 0;
//        titleLabel.tag = 500+i;
//        titleLabel.layer.cornerRadius = 5;
//        titleLabel.layer.masksToBounds = YES;
//        titleLabel.userInteractionEnabled = YES;
//        [self addSubview:titleLabel];
//
//        UILongPressGestureRecognizer *recongnizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizer:)];
//        [titleLabel addGestureRecognizer:recongnizer];
//
//        [UIView animateWithDuration:1 animations:^{
//            titleLabel.center = CGPointMake(x, y);
//            titleLabel.alpha = 1;
//        } completion:^(BOOL finished) {
//            titleLabel.alpha = 1;
//            [self bringSubviewToFront:titleLabel];
//        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(0, 0, 4, 4);
        CGFloat x = [_pointXArray[i] floatValue];
        CGFloat y = [_pointYArray[i] floatValue];
        button.alpha = 0;
        button.tag = 500+i;
        button.layer.cornerRadius = 2;
        button.layer.masksToBounds = YES;
        button.userInteractionEnabled = YES;
        [self addSubview:button];
        [UIView animateWithDuration:1 animations:^{
            button.center = CGPointMake(x, y);
            button.alpha = 1;
        } completion:^(BOOL finished) {
            button.alpha = 1;
            [self bringSubviewToFront:button];
        }];
        
    }
}

- (void)doScaleAnimationWithView:(UIView *)view{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.3;
    animation.values = @[@2,@1.5,@0.8,@1,@2];
    animation.repeatCount = 1e100;
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [view.layer addAnimation:animation forKey:@"scaleAnimations"];
}

/*

 @parameter 背景颜色填充
 */

- (void)drawGredientLayer{
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.maxHight+self.distancSlefY);
    _gradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:1 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.2].CGColor];
//    _gradientLayer.locations=@[@0.0,@1.0];
    _gradientLayer.startPoint = CGPointMake(0.0,0.0);
    _gradientLayer.endPoint = CGPointMake(0,1);
    
    UIBezierPath *gradientPath = [UIBezierPath bezierPath];
    [gradientPath moveToPoint:CGPointMake(_origenX, _origenY)];
    for (int i=0; i<_dataArray.count; i++) {
        CGFloat x = [_pointXArray[i] floatValue];
        CGFloat y = [_pointYArray[i] floatValue];
        [gradientPath addLineToPoint:CGPointMake(x, y)];
    }
    CGFloat lastX = [_pointXArray[_pointXArray.count - 1] floatValue];
    [gradientPath addLineToPoint:CGPointMake(lastX+10, _origenY)];
    
    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.fillRule = kCAFillRuleEvenOdd;
//    arc.strokeEnd = 0;
//    arc.fillColor = [UIColor redColor].CGColor;
//    arc.strokeColor = [UIColor redColor].CGColor;
    
    arc.path = gradientPath.CGPath;
    _gradientLayer.mask = arc;
    [self.layer addSublayer:_gradientLayer];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        self->_progressValue = 0.8;
//        [arc addAnimation:[self basicAnimationWithKey:@"strokeEnd" toValue:@(1)] forKey:@"strokeEnd"];
//    });

}

- (CABasicAnimation *)basicAnimationWithKey:(NSString *)key toValue:(NSValue *)toValue{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 1;
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


- (void)reloadDrawLineView {
    
    [self calculatePointDot];
    
    for (CALayer *sublayer in self.layer.sublayers) {
        if ([sublayer isKindOfClass:[HBasicShapeLayer class]]) {
            if (((HBasicShapeLayer *)sublayer).tag == 1000) {
                [sublayer removeFromSuperlayer];
                break;
            }
        }
    }
    [_gradientLayer removeFromSuperlayer];
    
    for (int i = 0; i < _dataArray.count; i++) {
        CGFloat x = [_pointXArray[i] floatValue];
        CGFloat y = [_pointYArray[i] floatValue];
        UIButton *button = [self viewWithTag:500+i];
        button.alpha = 0;
        [UIView animateWithDuration:1 animations:^{
            button.center = CGPointMake(x, y);
            button.alpha = 1;
        } completion:^(BOOL finished) {
            button.alpha = 1;
            [self bringSubviewToFront:button];
        }];
    }
    
    
    [self drawLine];
//    [self drawPointDotLocation];
    [self drawGredientLayer];
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
