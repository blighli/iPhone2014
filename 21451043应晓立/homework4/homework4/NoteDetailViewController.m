//
//  NoteDetailViewController.m
//  homework4
//
//  Created by yingxl1992 on 14/11/16.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "NoteDetailViewController.h"

@implementation NoteDetailViewController

@synthesize currentNotelist;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_tf_title setText:currentNotelist.title];
    [_tv_content setText:currentNotelist.content];
    NSData* imageData = [[NSData alloc] initWithBytes:[currentNotelist.image bytes] length: [currentNotelist.image length]];
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    _imageView.image=image;
    
    [_tf_title setEnabled:NO];
    [_tv_content setEditable:NO];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailEditViewController *detailController = segue.destinationViewController;
    [detailController setCurrentNotelist:currentNotelist];
}


@end

