//
//  FirstViewController.m
//  MyNotes
//
//  Created by 樊博超 on 14-11-14.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem* tbi = [self tabBarItem];
        [tbi setTitle:@"编辑文字"];
        
        UIImage* image = [UIImage imageNamed:@"text.png"];
      
        [tbi setImage:image];
    }
//    NSBundle* appBundle = [NSBundle mainBundle];
//    self = [super initWithNibName:@"FirstViewController" bundle:appBundle];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_hehe setText:@"hahahaha"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
