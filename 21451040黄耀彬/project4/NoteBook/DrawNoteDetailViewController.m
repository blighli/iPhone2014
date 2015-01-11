//
//  DrawNoteDetailViewController.m
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
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
}


- (IBAction)modifyDrawNote:(id)sender {
    [self.drawBoardView writeToFile:self.noteEntity.content];
}
@end
