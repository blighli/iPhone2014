//
//  DetailPicViewController.m
//  Notes
//
//  Created by 陈聪荣 on 14/12/6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "DetailPicViewController.h"
#import "Note.h"

@implementation DetailPicViewController
- (void)viewDidLoad
{
    if(_detailItem){
        UIImage *image=[[UIImage alloc]initWithContentsOfFile:[(Note*)_detailItem content]];
        self.imageView.image = image;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)returnOnclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
