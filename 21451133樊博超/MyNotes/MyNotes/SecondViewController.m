//
//  SecondViewController.m
//  MyNotes
//
//  Created by 樊博超 on 14-11-14.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem* tbi = [self tabBarItem];
        [tbi setTitle:@"照片"];
        
        UIImage* image = [UIImage imageNamed:@"text.png"];
        
        [tbi setImage:image];
    }
    CGRect nameField = CGRectMake(10, 30, 200, 31);
    UILabel *lable = [[UILabel alloc] initWithFrame:nameField];
    lable.text = @"bu xie le";
    [self.view addSubview:lable];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
