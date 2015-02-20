//
//  RightViewController.h
//  MyMusicPlayer
//
//  Created by 张榕明 on 15/01/01.
//  Copyright (c) 2015年 张榕明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXSemiTableViewController.h"


@class MusicViewController;

@interface RightViewController : DXSemiTableViewController

@property (weak,nonatomic)  MusicViewController  *myMusic;
@end
