//
//  ViewController.h
//  SimpleTasklist
//
//  Created by 张榕明 on 14/11/9.
//  Copyright (c) 2014年 张榕明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *textfield;

- (IBAction)insertAction:(UIButton *)sender;


@property (strong, nonatomic) IBOutlet UITableView *mytableview;


@end

