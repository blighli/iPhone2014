//
//  AboutUseViewController.m
//  justread
//
//  Created by Van on 14/12/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "AboutUseViewController.h"
#import "Utils.h"
@interface AboutUseViewController ()

@end

@implementation AboutUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Utils *util = [[Utils alloc] init];
    // Do any additional setup after loading the view.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"night"]){
        self.view.backgroundColor = [util stringToColor:@"#343434"];
        self.aboutLabel.textColor = [UIColor whiteColor];
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
        self.aboutLabel.textColor = [UIColor blackColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
