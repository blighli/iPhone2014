//
//  AboutUseViewController.h
//  justread
//
//  Created by Van on 14/12/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUseViewController : UIViewController
- (UIColor *) stringToColor:(NSString *)str;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@end
