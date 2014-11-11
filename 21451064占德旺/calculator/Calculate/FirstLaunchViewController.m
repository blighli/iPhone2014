//
//  FirstLaunchViewController.m
//  Calculate
//
//  Created by Devon on 14/11/6.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import "FirstLaunchViewController.h"

@implementation FirstLaunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (IBAction)gotoMainView:(id)sender{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    [self.gotoMainViewBtn setHidden:YES];
    [UIView beginAnimations:@"open" context:nil];
    [UIView setAnimationDuration:1];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *main = [storyboard instantiateInitialViewController];
    [self presentViewController:main animated:YES completion:NULL];
    [UIView commitAnimations];
}

@end