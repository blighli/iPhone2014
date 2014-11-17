//
//  DrawNoteDetailViewController.m
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/18.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "DrawNoteDetailViewController.h"

@interface DrawNoteDetailViewController ()

@end

@implementation DrawNoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.noteEntity.type == DrawNote) {
        [self.drawBoardView readFromFile: self.noteEntity.content];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)modifyDrawNote:(id)sender {
    [self.drawBoardView writeToFile:self.noteEntity.content];
}
@end
