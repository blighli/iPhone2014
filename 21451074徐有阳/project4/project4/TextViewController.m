//
//  TextViewController.m
//  project4
//
//  Created by xuyouyang on 14/11/23.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()
@property (weak, nonatomic) IBOutlet UITextField *noteTitle;
@property (weak, nonatomic) IBOutlet UITextView *noteContent;
@property (weak, nonatomic) IBOutlet UIButton *noteImagePath;
@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.note != nil) {
        // 修改
        self.noteTitle.text = self.note.title;
        self.noteContent.text = self.note.content;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 保存
- (IBAction)add:(id)sender {
    if (self.note == nil) {
        // 添加新的note
        [Note addNoteWithTitle:self.noteContent.text Content:self.noteContent.text ImagePath:@"123" Type:@"text"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        // 更新note
        
    }
}

// 取消
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
