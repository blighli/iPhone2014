//
//  SidebarController.h
//  ProjectFinal
//
//  Created by xvxvxxx on 12/27/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDSideBarController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "ChannelsTableViewCell.h"
#import "LoginViewController.h"
#import "TestViewController.h"
@interface SidebarController : UITabBarController<CDSideBarControllerDelegate>{
    CDSideBarController *sideBar;
    ViewController *playerVC;
    ChannelsTableViewController *channelsVC;
    LoginViewController *loginVC;
    TestViewController *test;
}

@end
