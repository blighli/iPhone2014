//
//  DXSemiViewController.h
//  MyMusicPlayer
//
//  Created by 张榕明 on 15/01/01.
//  Copyright (c) 2015年 张榕明. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SemiViewControllerDirectionLeft,
    SemiViewControllerDirectionRight,
}SemiViewControllerDirection;

@interface DXSemiViewController : UIViewController

@property (nonatomic, assign) SemiViewControllerDirection direction;
@property (nonatomic, assign) CGFloat sideAnimationDuration;
@property (nonatomic, assign) CGFloat sideOffset;

@property (nonatomic, strong) UIView *contentView;


- (void)dismissSemi:(id)sender;

@end
