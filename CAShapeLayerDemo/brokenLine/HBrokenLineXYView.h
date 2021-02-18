//
//  HBrokenLineXYView.h
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/19.
//  Copyright © 2019 H&L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBrokenLineXYView : UIView

- (instancetype)initWithXAxisArray:(NSArray *)xAxisArray YAxis:(NSArray *)yAxisArray XAxisSpac:(CGFloat)xAxisSpac YAxisSpac:(CGFloat)yAxisSpac isSowXLine:(BOOL)isShowXline isShowYLine:(BOOL)isShowYLine;

// x轴节点数组
@property (nonatomic, strong) NSArray *xNodeArray;
// y轴节点数组
@property (nonatomic, strong) NSArray *yNodeArray;

// dot数组
@property (nonatomic, strong) NSArray *dotArray;

// 刷新节点数据
- (void)reloadXNodeSubViews;
- (void)reloadYNodeSubViews;

// 刷新折线数据
- (void)reloadLineChatView;

@end

NS_ASSUME_NONNULL_END
