//
//  HProgressBarViewController.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/24.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "HProgressBarViewController.h"
#import "HProgressView.h"

@interface HProgressBarViewController ()
@property (nonatomic, strong) CALayer *bgLayer;
@property (nonatomic, assign) CGFloat progressValue;
@property (nonatomic, strong) HProgressView *pView;


@end

@implementation HProgressBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _pView = [[HProgressView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_pView];
    
//    [self initProgressBgView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_pView startDraw];
}

- (void)initProgressBgView {
    CALayer *layer = [CALayer layer];
     layer.backgroundColor = [UIColor redColor].CGColor; //圆环底色
     layer.frame = CGRectMake(100, 100, 110, 110);


     //创建一个圆环
     UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(55, 55) radius:50 startAngle:0 endAngle:M_PI*2 clockwise:YES];

     //圆环遮罩
     CAShapeLayer *shapeLayer = [CAShapeLayer layer];
     shapeLayer.fillColor = [UIColor clearColor].CGColor;
     shapeLayer.strokeColor = [UIColor redColor].CGColor;
     shapeLayer.lineWidth = 5;
     shapeLayer.strokeStart = 0;
     shapeLayer.strokeEnd = 0.8;
     shapeLayer.lineCap = @"round";
     shapeLayer.lineDashPhase = 0.8;
     shapeLayer.path = bezierPath.CGPath;

     //颜色渐变
     NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor redColor].CGColor,(id)[UIColor whiteColor].CGColor, nil];
     CAGradientLayer *gradientLayer = [CAGradientLayer layer];
     gradientLayer.shadowPath = bezierPath.CGPath;
     gradientLayer.frame = CGRectMake(50, 50, 60, 60);
     gradientLayer.startPoint = CGPointMake(0, 1);
     gradientLayer.endPoint = CGPointMake(1, 0);
     [gradientLayer setColors:[NSArray arrayWithArray:colors]];
     [layer addSublayer:gradientLayer]; //设置颜色渐变
     [layer setMask:shapeLayer]; //设置圆环遮罩
     [self.view.layer addSublayer:layer];

     //动画
     CABasicAnimation *scaleAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
     scaleAnimation1.fromValue = [NSNumber numberWithFloat:1.0];
     scaleAnimation1.toValue = [NSNumber numberWithFloat:1.5];
     scaleAnimation1.autoreverses = YES;
    // scaleAnimation1.fillMode = kCAFillModeForwards;
     scaleAnimation1.duration = 0.8;

     CABasicAnimation *rotationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
     rotationAnimation2.fromValue = [NSNumber numberWithFloat:0];
     rotationAnimation2.toValue = [NSNumber numberWithFloat:6.0*M_PI];
     rotationAnimation2.autoreverses = YES;
    // scaleAnimation.fillMode = kCAFillModeForwards;
     rotationAnimation2.repeatCount = MAXFLOAT;
     rotationAnimation2.beginTime = 0.8; //延时执行，注释掉动画会同时进行
     rotationAnimation2.duration = 2;


     //组合动画
     CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
     groupAnnimation.duration = 4;
     groupAnnimation.autoreverses = YES;
     groupAnnimation.animations = @[scaleAnimation1, rotationAnimation2];
     groupAnnimation.repeatCount = MAXFLOAT;
     [layer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
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
