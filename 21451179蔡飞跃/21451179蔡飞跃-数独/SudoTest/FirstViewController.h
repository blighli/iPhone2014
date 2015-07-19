//
//  FirstViewController.h
//  SudoTest
//
//  Created by 蔡飞跃 on 14/12/22.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "global.h"

@interface FirstViewController : UIViewController
{
    IBOutlet UIButton *bt_Begin;
    UIButton *blocker;
    UIView *topView;
}

@property(assign,nonatomic) UIView *topView;

-(IBAction)StartGame:(id)sender;

@end
