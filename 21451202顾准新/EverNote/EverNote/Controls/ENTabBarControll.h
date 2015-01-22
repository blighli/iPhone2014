//
//  ENTabBarControll.h
//  EverNote
//
//  Created by 顾准新 on 14-12-6.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnNoteVewController.h"
#import "ENPhotoViewController.h"
#import "ENDrawViewController.h"
#import "Note.h"

@interface ENTabBarControll : UITabBarController
@property (strong,nonatomic) Note *note;

@end
