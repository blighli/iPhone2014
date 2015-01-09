//
//  CLLRefreshHeadView.h
//  RefreshLoadView
//
//  Created by chuliangliang on 14-6-12.
//  Copyright (c) 2014年 aikaola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLLRefreshCircleView.h"
#define CLLDefaultRefreshTotalPixels 60

@interface CLLRefreshHeadView : UIView

//刷新操作提示
@property (nonatomic,strong)UILabel *statusLabel;

//刷新时间
@property (nonatomic,strong)UILabel *timeLabel;

//刷新圆圈
@property (nonatomic,strong)CLLRefreshCircleView *circleView;
@end
