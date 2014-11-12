//
//  DisplayViewController.m
//  Project3
//
//  Created by xsdlr on 14/11/6.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "DisplayViewController.h"
#import "ViewController.h"

@interface DisplayViewController ()

@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ViewController *tasksListView = (ViewController *)self.delegate;
     self.textField.text = [tasksListView.tasks objectAtIndex:[self.taskIndex integerValue]];
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

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)complete:(id)sender {
    if ([self.textField.text length] == 0) {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"输入不能为空" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
        return;
    }
    ViewController *tasksListView = (ViewController *)self.delegate;
    [tasksListView.tasks replaceObjectAtIndex:[self.taskIndex integerValue] withObject:self.textField.text];
    [tasksListView saveFile:@"tasklist.plist"];
    [self close:sender];
}


@end
