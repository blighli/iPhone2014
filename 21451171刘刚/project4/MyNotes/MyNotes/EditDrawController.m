//
//  EditDrawController.m
//  MyNotes
//
//  Created by liug on 14-11-24.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import "EditDrawController.h"

@interface EditDrawController ()

@end

@implementation EditDrawController
@synthesize path,image;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UIImage *iv=[[UIImage alloc]init];
    [iv initWithContentsOfFile:path];
    [image setImage:iv];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
