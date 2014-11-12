//
//  ViewController.h
//  tasklist2
//
//  Created by tanglie1993 on 14/11/9.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>



@property(nonatomic,strong) IBOutlet UITextField *taskField;
@property(nonatomic,strong) IBOutlet UITableView *taskTable;
@property(nonatomic,strong) IBOutlet UIButton *insertButton;

- (IBAction)insertButton: (id)sender;


@end

