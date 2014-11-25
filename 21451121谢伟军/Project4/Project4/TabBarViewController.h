//
//  TabBarViewController.h
//  Project4
//
//  Created by xvxvxxx on 14/11/23.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FMDB.h>
#import "Note.h"
#import "ContentViewController.h"
#import "PhotoViewController.h"
#import "PictureViewController.h"
#import "AppDelegate.h"

@interface TabBarViewController : UITabBarController <UITabBarControllerDelegate>
@property ContentViewController *contentVC;
@property PhotoViewController *photoVC;
@property PictureViewController *pictureVC;
@property BOOL isCreate;
@property Note *note;
@property FMDatabase *db;

@property NSString *test;
- (IBAction)saveNote:(UIBarButtonItem *)sender;
@end
