//
//  BezierViewController.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/12.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "BezierViewController.h"
#import "BezierPathView.h"

@interface BezierViewController ()

@end

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    BezierPathView *view = [[BezierPathView alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
    view.backgroundColor = [UIColor yellowColor];
    view.clipsToBounds = YES;
    [self.view addSubview:view];
    
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
