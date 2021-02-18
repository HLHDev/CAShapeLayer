//
//  HFanViewController.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/23.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "HFanViewController.h"
#import "HFanView.h"

@interface HFanViewController ()

@end

@implementation HFanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self createFanView];
    
    HFanView *fanView = [[HFanView alloc] initWithFrame:self.view.bounds radies:100 rateDataArray:@[@0.3,@0.1,@0.2,@0.4] colors:@[[UIColor redColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor]]];
    [self.view addSubview:fanView];
    [fanView drawFanRect];
    
}


- (void)createFanView {
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGPoint center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    CGFloat redius = 100;
    CGFloat startAng = -M_PI_2;
    CGFloat endAng = M_PI_2*3;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:redius startAngle:startAng endAngle:endAng clockwise:YES];
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor yellowColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = 1;
    layer.strokeStart = 0.0f;
    layer.strokeEnd   = 1.0f;
    layer.zPosition   = 1;
    layer.fillRule = kCAFillRuleEvenOdd;
    [view.layer addSublayer:layer];
    
    //通过mask来控制显示区域
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithArcCenter:center radius:view.bounds.size.width/4.f startAngle:-M_PI_2 endAngle:M_PI_2*3*0.8 clockwise:YES];
    //设置边框颜色为不透明，则可以通过边框的绘制来显示整个view
     maskLayer.strokeColor = [UIColor greenColor].CGColor;
     maskLayer.lineWidth = view.bounds.size.width/2.f;
     //设置填充颜色为透明，可以通过设置半径来设置中心透明范围
     maskLayer.fillColor = [UIColor clearColor].CGColor;
     maskLayer.path = maskPath.CGPath;
     maskLayer.strokeEnd = 0;
     view.layer.mask = maskLayer;
    
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
    [maskLayer addAnimation:animation forKey:@"strokeEnd"];
    
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 3;
//    pathAnimation.repeatCount = 1;
//    pathAnimation.removedOnCompletion = YES;
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    [layer addAnimation:pathAnimation forKey:@"strokeEnd"];
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation.duration  = 3;
//    animation.fromValue = @0.0f;
//    animation.toValue   = @1.0f;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.removedOnCompletion = YES;
//    [layer addAnimation:animation forKey:@"circleAnimation"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
