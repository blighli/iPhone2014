//
//  ViewController.h
//  project3
//
//  Created by zack on 14-11-11.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *taskInput;
- (IBAction)insertTask:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;

@end

