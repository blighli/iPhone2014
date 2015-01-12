//
//  PicNoteViewController.m
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
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
