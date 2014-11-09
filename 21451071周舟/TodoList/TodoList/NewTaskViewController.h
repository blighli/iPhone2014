//
//  NewTaskViewController.h
//  TodoList
//
//  Created by 周舟 on 6/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTaskViewController : UIViewController
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;

@property (weak, nonatomic) IBOutlet UITextField *taskName;

@property (weak, nonatomic) IBOutlet UITextView *taskContent;


- (IBAction)tapView:(UITapGestureRecognizer *)sender;

- (IBAction)saveNewTask:(UIBarButtonItem *)sender;


@end
