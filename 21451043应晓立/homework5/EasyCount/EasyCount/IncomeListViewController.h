//
//  IncomeListViewController.h
//  EasyCount
//
//  Created by yingxl1992 on 14/12/20.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "CustomIOS7AlertView.h"
#import "AddViewController.h"
#import "EditViewController.h"
#import "Record.h"

@interface IncomeListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SlideNavigationControllerDelegate,UIPickerViewDelegate,CustomIOS7AlertViewDelegate>
{
    NSArray *pics;
    NSArray *titles;
    NSString *username;
    NSMutableArray *data;
    NSString *currentDate;
    UIDatePicker *picker;
}

@property (weak, nonatomic) IBOutlet UITableView *listTable;

@property (weak, nonatomic) IBOutlet UILabel *sumLabel;

@property NSString *username;
@property NSMutableArray *data;

@end
