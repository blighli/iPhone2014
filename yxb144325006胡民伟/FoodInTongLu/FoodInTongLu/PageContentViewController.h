//
//  PageContentViewController.h
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/16.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UILabel *subHeadingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *getStartedButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@property (strong, nonatomic) NSString *heading;
@property (strong, nonatomic) NSString *imageFile;
@property (strong, nonatomic) NSString *subHeading;
@property (assign, nonatomic) int index;
@end
