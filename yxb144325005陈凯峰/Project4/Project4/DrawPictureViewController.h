//
//  DrawPictureViewController.h
//  Project4
//
//  Created by jingcheng407 on 14-11-23.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewController.h"

@interface DrawPictureViewController : UIViewController
- (IBAction)SaveButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *SaveButton;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (weak, nonatomic) MainTableViewController* param;
@property (weak, nonatomic) NSNumber* num;
@end
