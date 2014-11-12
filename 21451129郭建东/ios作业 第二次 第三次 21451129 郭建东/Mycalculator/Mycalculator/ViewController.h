//
//  ViewController.h
//  Mycalculator
//
//  Created by cstlab on 14/11/12.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kClear          10
#define kDel            11
#define kDevide         12
#define kMultiply       13
#define kSub            14
#define kPlus           15
#define kEqual          16
#define kRightBracket   17
#define kLeftBracket    18
#define kDot            19
#define kPower          20
#define kSin            21
#define kCos            22
#define kLog            24


@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *totalResultLabel;
@property (weak, nonatomic) IBOutlet UITextField *resultText;


- (IBAction)taoAction:(UIButton *)sender;


@end

