//
//  ViewController.h
//  TaskList
//
//  Created by 周翔 on 14/11/10.
//  Copyright (c) 2014年 周翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong) IBOutlet UITextField *taskField;
@property(nonatomic,strong) IBOutlet UITableView *taskTable;

-(IBAction) insertButton:(id)sender;


-(void) addTasks:(id) sender;





@end

