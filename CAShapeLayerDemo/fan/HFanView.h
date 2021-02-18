//
//  HFanView.h
//  CAShapeLayerDemo
//
//  Created by H&L on 2019/12/23.
//  Copyright © 2019 H&L. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFanView : UIView

- (instancetype)initWithFrame:(CGRect)frame radies:(CGFloat)radies rateDataArray:(NSArray *)rateArray colors:(NSArray *)colors;

- (void)drawFanRect;
- (void)stroke;

@end


























@interface HFanShapeLayer : CAShapeLayer

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, assign) BOOL isSelect;

@end








NS_ASSUME_NONNULL_END
