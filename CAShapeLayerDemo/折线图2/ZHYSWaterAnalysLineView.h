//
//  ZHYSWaterAnalysLineView.h
//  ZHKJYouShuiApp
//
//  Created by H&L on 2020/1/10.
//  Copyright © 2020 Loveff. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHYSWaterAnalysLineView : UIView

// 数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

// 重绘
- (void)reloadDrawLineView;


@end

NS_ASSUME_NONNULL_END
