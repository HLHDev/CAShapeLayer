//
//  ZHYSExponentView.m
//  ZHKJYouShuiApp
//
//  Created by H&L on 2020/1/13.
//  Copyright © 2020 Loveff. All rights reserved.
//

#import "ZHYSExponentView.h"
#import <Masonry.h>

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define FONT11SIZE       [UIFont systemFontOfSize:11]

@implementation ZHYSExponentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithUI];
    }
    return self;
}

- (void)initWithUI {
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    WS(weakSelf);
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.mas_equalTo(weakSelf);
    }];
    
    UIView *subBView = [[UIView alloc] init];
    subBView.backgroundColor = [UIColor blackColor];
    subBView.alpha = 0.5;
    subBView.layer.cornerRadius = 5;
    subBView.layer.masksToBounds = YES;
    [bgView addSubview:subBView];
    [subBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.mas_equalTo(bgView);
    }];
    
    _tocLabel = [[UILabel alloc] init];
    _tocLabel.font = FONT11SIZE;
    _tocLabel.textColor = [UIColor whiteColor];
    _tocLabel.textAlignment = NSTextAlignmentCenter;
    _tocLabel.text = @"TOC：5.1";
    [bgView addSubview:_tocLabel];
    [_tocLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.left.right.mas_equalTo(bgView);
    }];
    
    _exponentLabel = [[UILabel alloc] init];
    _exponentLabel.font = FONT11SIZE;
    _exponentLabel.textColor = [UIColor whiteColor];
    _exponentLabel.textAlignment = NSTextAlignmentCenter;
    _exponentLabel.text = @"综合指数：2.7";
    [bgView addSubview:_exponentLabel];
    [_exponentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(bgView);
        make.bottom.mas_equalTo(weakSelf.tocLabel.mas_top).offset(-5);
    }];
    
    _codLabel = [[UILabel alloc] init];
    _codLabel.font = FONT11SIZE;
    _codLabel.textColor = [UIColor whiteColor];
    _codLabel.textAlignment = NSTextAlignmentCenter;
    _codLabel.text = @"COD：4.2";
    [bgView addSubview:_codLabel];
    [_codLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(bgView);
        make.top.mas_equalTo(weakSelf.tocLabel.mas_bottom).offset(5);
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
