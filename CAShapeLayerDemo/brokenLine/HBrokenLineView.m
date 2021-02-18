//
//  HBrokenLineView.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/18.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "HBrokenLineView.h"
#import "HBrokenLineXYView.h"
#import <Masonry.h>

@interface HBrokenLineView ()

@property (nonatomic, strong) HBrokenLineXYView *xyLineView;

@end

@implementation HBrokenLineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithXYLineView];
        self.backgroundColor = [UIColor darkGrayColor];
    }
    return self;
}

- (void)initWithXYLineView {
    NSArray *xArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    NSArray *yArray = @[@"0.1",@"0.5",@"1",@"2"];
    
    _xyLineView = [[HBrokenLineXYView alloc] initWithXAxisArray:xArray YAxis:yArray XAxisSpac:30 YAxisSpac:60 isSowXLine:YES isShowYLine:YES];
    [self addSubview:_xyLineView];
//    xyLineView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _xyLineView.backgroundColor = [UIColor yellowColor];
    [_xyLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-50);
    }];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"刷新X轴" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"刷新Y轴" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"刷新折线" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button3];
    
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(button1.mas_right).offset(20);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(button2.mas_right).offset(20);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
}

- (void)button1Action {
    NSArray *xArray = @[@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
    _xyLineView.xNodeArray = xArray;
    [_xyLineView reloadXNodeSubViews];
}
- (void)button2Action {
    NSArray *yArray = @[@"0.3",@"0.8",@"1.5",@"2"];
    _xyLineView.yNodeArray = yArray;
    [_xyLineView reloadYNodeSubViews];
}
- (void)button3Action {
    NSArray *dotArray = @[@"0.3",@"0.8",@"1.2",@"1",@"0.7",@"1.5",@"0.9",@"1.5",@"1.1",@"1"];
    _xyLineView.dotArray = dotArray;
    [_xyLineView reloadLineChatView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
