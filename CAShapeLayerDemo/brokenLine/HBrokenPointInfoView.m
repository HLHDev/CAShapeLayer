//
//  HBrokenPointInfoView.m
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/20.
//  Copyright © 2019 H&L. All rights reserved.
//

#import "HBrokenPointInfoView.h"

@implementation HBrokenPointInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)initWithUI {
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor lightGrayColor];
    bgView.alpha = 0.5;
    [self addSubview:bgView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
