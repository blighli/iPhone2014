//
//  TaskViewController.h
//  ToDoList
//
//  Created by 陆钟豪 on 14/11/8.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskViewController : UIViewController

// outlet connection
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;

// action connection
- (IBAction)completeTask:(id)sender;

// custom properties
@property (weak, nonatomic) NSString *task;
@property (weak, nonatomic) id delegate;

@end
