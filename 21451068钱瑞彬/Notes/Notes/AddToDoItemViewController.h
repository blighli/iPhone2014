//
//  AddToDoItemViewController.h
//  ToDoList
//
//  Created by apple on 14-11-8.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddToDoItemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *text;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *done;
@property (weak, nonatomic) IBOutlet UINavigationItem *barTitle;

@property NSString* editText;
@property BOOL isNewItem;
@property NSString* toDoItem;


@end
