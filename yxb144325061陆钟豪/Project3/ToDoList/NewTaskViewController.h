//
//  NewTaskViewController.h
//  ToDoList
//
//  Created by 陆钟豪 on 14/11/8.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTaskViewController : UIViewController

// outlet connection
@property (weak, nonatomic) IBOutlet UITextField *textField;

// action connection
- (IBAction)saveTask:(id)sender;
- (IBAction)close:(id)sender;

// custom properties
@property (weak, nonatomic) id delegate;

@end
