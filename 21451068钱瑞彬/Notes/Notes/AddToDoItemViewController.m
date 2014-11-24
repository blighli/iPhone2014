//
//  AddToDoItemViewController.m
//  ToDoList
//
//  Created by apple on 14-11-8.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import "AddToDoItemViewController.h"

#import "ToDoListTableViewController.h"

@interface AddToDoItemViewController ()

@end

@implementation AddToDoItemViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isNewItem == NO) {
        self.text.text = self.editText;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


// 传递数据
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //ToDoListTableViewController* dest = segue.destinationViewController;
    //NSLog(@"add: prepareForSegue: %d", dest.selectedItem);
    
    if (sender != self.done) return;
    if (self.text.text.length > 0) {
        self.toDoItem = [[NSString alloc] init];
        self.toDoItem = self.text.text;
    }
}


@end

