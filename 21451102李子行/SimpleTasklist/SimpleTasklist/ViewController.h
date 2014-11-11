//
//  ViewController.h
//  SimpleTasklist
//
//  Created by lzx on 14/11/7.
//  Copyright (c) 2014年 lzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *textfield;

- (IBAction)insertAction:(UIButton *)sender;


@property (strong, nonatomic) IBOutlet UITableView *mytableview;


@end

