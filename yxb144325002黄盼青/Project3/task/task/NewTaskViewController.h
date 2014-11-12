//
//  NewTaskViewController.h
//  task
//
//  Created by 黄盼青 on 14/11/6.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTaskViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *task;
@property (assign, nonatomic) id delegate;

- (IBAction)saveTask:(id)sender;
- (IBAction)close:(id)sender;
@end
