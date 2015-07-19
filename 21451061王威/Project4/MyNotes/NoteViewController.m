//
//  NoteViewController.m
//  MyNotes
//
//  Created by 王威 on 14/11/15.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "NoteViewController.h"
#import "DBUtilis.h"
#import "AlertUtilis.h"

@interface NoteViewController ()

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addContent:(id)sender{
    DBUtilis *db = [[DBUtilis alloc] init];
    [db insertText:self.content.text OrImage:nil WithTitle:self.titleField.text ofType:@"text"];
    [AlertUtilis alertWithTitle:@"添加笔记"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)tabBackground:(id)sender{
    [self.titleField resignFirstResponder];
    [self.content resignFirstResponder];
}
@end
