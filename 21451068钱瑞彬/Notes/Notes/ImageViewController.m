//
//  ImageViewController.m
//  Notes
//
//  Created by apple on 14-11-24.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* aPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), self.barTitle.title];
    self.image.image = [[UIImage alloc]initWithContentsOfFile:aPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
