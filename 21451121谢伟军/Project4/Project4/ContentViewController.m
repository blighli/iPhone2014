//
//  ContentViewController.m
//  Project4
//
//  Created by xvxvxxx on 14/11/23.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.note == nil) {
        self.note = [[Note alloc]init];
    }
    self.notetitle.text = self.note.notetitle;
    self.content.text = self.note.content;
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyboard)];
    doneBarButton.width = ceilf(self.view.frame.size.width) / 3 - 30;
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolbar.items = [NSArray arrayWithObjects:doneBarButton, nil];
    self.notetitle.inputAccessoryView = toolbar;
    self.content.inputAccessoryView = toolbar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithNote:(Note *)note{
    self = [super init];
    if (self) {
        self.note = note;
    }
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)hideKeyboard
{
    if ([self.notetitle isFirstResponder]) {
        [self.notetitle resignFirstResponder];
    }
    if ([self.content isFirstResponder]) {
        [self.content resignFirstResponder];
    }
}

@end
