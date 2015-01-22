//
//  CountViewController.h
//  EasyCount
//
//  Created by yingxl1992 on 14/12/20.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "XYPieChart.h"

@interface CountViewController : UIViewController<SlideNavigationControllerDelegate,XYPieChartDataSource,XYPieChartDelegate>
{
    NSMutableArray *slices;
    NSArray *sliceColors;
    NSString *username;
    NSMutableArray *titles;
    NSArray *titleStrs;
}

@property (weak, nonatomic) IBOutlet XYPieChart *countPie;
@property (weak, nonatomic) IBOutlet UILabel *resLable;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;

@end
