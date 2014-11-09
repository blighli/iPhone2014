//
//  ViewController.h
//  Counter
//
//  Created by 陈晓强 on 14/11/6.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *display;
@end

