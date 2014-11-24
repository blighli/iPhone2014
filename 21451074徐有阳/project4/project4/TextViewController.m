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
@property (strong, nonatomic) IBOutlet UIImageView *noteImage;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.note != nil) {
        // 修改
        self.noteTitle.text = self.note.title;
        self.noteContent.text = self.note.content;
        if (self.note.imagePath) {
            self.noteImage.image = [UIImage imageWithContentsOfFile:self.note.imagePath];
        }
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
        Note *newNote = [[Note alloc]init];
        newNote.title = self.noteTitle.text;
        newNote.content = self.noteContent.text;
        newNote.imagePath = @"123";
        newNote.type = @"text";
        [newNote add];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        // 更新note
        Note *newNote = [[Note alloc]init];
        newNote.noteId = self.note.noteId;
        newNote.title = self.noteTitle.text;
        newNote.content = self.noteContent.text;
        newNote.imagePath = self.note.imagePath;
        newNote.type = @"text";
        [newNote update];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// 取消
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
