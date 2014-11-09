//
//  NewTaskViewController.h
//  TodoList
//
//  Created by Devon on 6/11/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTaskViewController : UIViewController
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;

@property (weak, nonatomic) IBOutlet UITextField *taskName;

@property (weak, nonatomic) IBOutlet UITextField *taskContent;

- (IBAction)saveNewTask:(UIBarButtonItem *)sender;


@end
