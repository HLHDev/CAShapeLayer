//
//  ViewController.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/12.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "ViewController.h"
#import "BezierViewController.h"
#import "HBrokenLineXYViewController.h"
#import "HFanViewController.h"
#import "HProgressBarViewController.h"
#import "HLineChat2ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"cellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellName];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"柱状图";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"折线图";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"扇形图";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"进度条";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"折线图2";
    }
    else {
        cell.textLabel.text = [NSString stringWithFormat:@"indexPath.row:%ld",indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BezierViewController *vc = [[BezierViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        HBrokenLineXYViewController *lineView = [[HBrokenLineXYViewController alloc] init];
        [self.navigationController pushViewController:lineView animated:YES];
    } else if (indexPath.row == 2) {
        HFanViewController *fanVC = [[HFanViewController alloc] init];
        [self.navigationController pushViewController:fanVC animated:YES];
    } else if (indexPath.row == 3) {
        HProgressBarViewController *proVC = [[HProgressBarViewController alloc] init];
//        [self.navigationController pushViewController:proVC animated:YES];
        proVC.modalPresentationStyle =UIModalPresentationPageSheet;// UIModalPresentationFullScreen;
        [self presentViewController:proVC animated:YES completion:nil];
    } else if (indexPath.row == 4) {
        HLineChat2ViewController *line2VC = [[HLineChat2ViewController alloc] init];
    //        [self.navigationController pushViewController:proVC animated:YES];
//            line2VC.modalPresentationStyle = UIModalPresentationFullScreen;
//            [self presentViewController:line2VC animated:YES completion:nil];
        [self.navigationController pushViewController:line2VC animated:YES];
        }
}


@end
