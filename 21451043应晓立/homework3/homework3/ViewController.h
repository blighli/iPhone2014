//
//  ViewController.h
//  homework3
//
//  Created by yingxl1992 on 14/11/7.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>

{
    NSInteger currentrow;
    NSMutableArray *taskdata;
    NSArray *keylist;
    NSMutableDictionary *dict;
    NSMutableArray *indexlist;
}

@property (weak, nonatomic) IBOutlet UITextField *text_insert;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UILabel *lable_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_insert;

@end

