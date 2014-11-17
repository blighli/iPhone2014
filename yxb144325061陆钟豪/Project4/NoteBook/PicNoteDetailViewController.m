//
//  PicNoteViewController.m
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/16.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "PicNoteDetailViewController.h"

@interface PicNoteDetailViewController ()

@end

@implementation PicNoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.noteEntity.type == PicNote) {
        UIImage *image=[[UIImage alloc]initWithContentsOfFile:self.noteEntity.content];
        self.noteImageView.image = image;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
