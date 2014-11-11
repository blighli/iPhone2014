//
//  NewTaskViewController.m
//  ToDoList
//
//  Created by 陆钟豪 on 14/11/8.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "NewTaskViewController.h"
#import "ViewController.h"

@interface NewTaskViewController ()

@end

@implementation NewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveTask:(id)sender {
    if ([self.textField.text length] == 0)
        return;
    ViewController *tasksListView =
    (ViewController *)self.delegate;
    [tasksListView.tasks addObject:self.textField.text];
    [tasksListView saveTaskList];
    [self close:sender];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
