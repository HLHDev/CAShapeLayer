//
//  HLineChat2ViewController.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2020/1/13.
//  Copyright © 2020 H&L. All rights reserved.
//

#import "HLineChat2ViewController.h"
#import "ZHYSWaterAnalysLineView.h"

@interface HLineChat2ViewController ()

@end

@implementation HLineChat2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZHYSWaterAnalysLineView *analysisView = [[ZHYSWaterAnalysLineView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 280)];
    analysisView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:analysisView];
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
