//
//  IncomeCountViewController.h
//  EasyCount
//
//  Created by yingxl1992 on 15/1/8.
//  Copyright (c) 2015年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "CustomIOS7AlertView.h"
#import "AddViewController.h"
#import "EditViewController.h"
#import "Record.h"
#import "XYPieChart.h"

@interface IncomeCountViewController : UIViewController<SlideNavigationControllerDelegate,XYPieChartDataSource,XYPieChartDelegate>
{
    NSMutableArray *slices;
    NSArray *sliceColors;
    NSString *username;
    NSMutableArray *titles;
    NSArray *titleStrs;
    NSInteger type;
}

@property (weak, nonatomic) IBOutlet XYPieChart *countPie;
@property (weak, nonatomic) IBOutlet UILabel *resLable;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@end
