//
//  ImageViewController.m
//  Notes
//
//  Created by xsdlr on 14/11/17.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "ImageViewController.h"
#import "ViewController.h"
#import "Note.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ViewController *nodesListView = (ViewController *)self.delegate;
    if (self.noteIndex != nil) {
        Note* note = [nodesListView.notes objectAtIndex:[self.noteIndex integerValue]];
        if ([note.type isEqualToString: Note.IMAGE_TYPE] || [note.type isEqualToString: Note.DRAW_TYPE]) {
            UIImage* image = [[UIImage alloc]initWithContentsOfFile: note.message];
            self.imageView.image = image;
        } else {
            [[[UIAlertView alloc] initWithTitle:@"错误" message:@"非图片信息" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
