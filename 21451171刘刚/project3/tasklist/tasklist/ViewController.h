//
//  ViewController.h
//  tasklist
//
//  Created by liug on 14-11-8.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import <UIKit/UIKit.h>
NSString *docPath(void);
NSMutableArray *tasklist;
@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tasktable;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end
