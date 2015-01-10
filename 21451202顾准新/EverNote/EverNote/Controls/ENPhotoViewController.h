//
//  ENPhotoViewController.h
//  EverNote
//
//  Created by 顾准新 on 14-12-6.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ENPhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *notePhoto;
@property (strong,nonatomic) NSString *photoName;
@end
