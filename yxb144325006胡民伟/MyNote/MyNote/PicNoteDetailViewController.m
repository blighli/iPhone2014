//
//  MainViewController.m
//  MyNote
//
//  Created by Cocoa on 14/11/20.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "PicNoteDetailViewController.h"
#import "Note.h"

@interface PicNoteDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *noteImageView;
@property (strong, nonatomic) Note *note;
@end

@implementation PicNoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([self.note.type  isEqual: @"照片"] || [self.note.type  isEqual: @"手绘"]) {
        NSLog(self.note.content);
        UIImage *image=[[UIImage alloc]initWithContentsOfFile:self.note.content];
        self.noteImageView.image = image;
    }
}

@end
