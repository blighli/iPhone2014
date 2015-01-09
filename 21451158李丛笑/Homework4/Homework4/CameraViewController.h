//
//  CameraViewController.h
//  Homework4
//
//  Created by 李丛笑 on 14/12/10.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *imageTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageBox;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScoller;
@property (strong, nonatomic) NSString *imagecount;
- (IBAction)imageSave:(id)sender;
- (IBAction)addImage:(id)sender;

@end
