//
//  HBrokenLineXYViewController.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/19.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "HBrokenLineXYViewController.h"
#import "HBrokenLineView.h"

@interface HBrokenLineXYViewController ()

@end

@implementation HBrokenLineXYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    HBrokenLineView *lineView = [[HBrokenLineView alloc] init];
    lineView.frame = CGRectMake(15, 100, [UIScreen mainScreen].bounds.size.width-30, 400);
    [self.view addSubview:lineView];
    
//    UILongPressGestureRecognizer *recongnizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizer:)];
////    recongnizer.delegate = self;
//    [self.view addGestureRecognizer:recongnizer];
}

//- (void)longPressGestureRecognizer:(UILongPressGestureRecognizer *)gesture {
//    // 一般开发中,长按操作只会做一次
//    // 假设在一开始长按的时候就做一次操作
////    NSLog(@"%ld",gesture.state);
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        NSLog(@"%ld",gesture.state);
//    } else if (gesture.state == UIGestureRecognizerStateEnded) {
//        NSLog(@"%ld",gesture.state);
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
