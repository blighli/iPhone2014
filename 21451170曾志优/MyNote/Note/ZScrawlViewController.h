//
//  ZScrawlViewController.h
//  Note
//
//  Created by Mac on 14-11-23.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQuartzView.h"


@interface ZScrawlViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *topic;

@property (weak, nonatomic) IBOutlet ZQuartzView *myCrawl;

@property(nonatomic,strong) UIImageView *imageView;

@property (copy, nonatomic)  NSString *paramTopic;

@property (copy, nonatomic)   NSData *binScrawl;

- (IBAction)saveButtonPressed:(UIButton *)sender;

@end
