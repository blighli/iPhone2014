//
//  BBSetViewController.h
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/9.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSetViewController : UIViewController

@property (assign,nonatomic) BOOL isSetDisplay;

-(void)showSettingPage:(UIViewController *)rc;
-(void)closeSettingPage;
@end
