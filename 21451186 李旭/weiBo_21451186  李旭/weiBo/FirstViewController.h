//
//  FirstViewController.h
//  weiBo
//
//  Created by lixu on 15/1/9.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUNSlideSwitchView.h"
#import "PublicViewController.h"
#import "FriendViewController.h"
#import "MineViewController.h"
#import "HerViewController.h"

@interface FirstViewController : UIViewController<SUNSlideSwitchViewDelegate>
@property (strong, nonatomic) IBOutlet SUNSlideSwitchView *slideSwitchView;
@property (strong,nonatomic) PublicViewController *publicView;
@property (strong,nonatomic) FriendViewController *friendView;
@property (strong,nonatomic) MineViewController *mineView;
@property (strong,nonatomic) HerViewController *herView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@end
