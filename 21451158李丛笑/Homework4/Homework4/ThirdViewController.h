//
//  ThirdViewController.h
//  Homework4
//
//  Created by 李丛笑 on 14/12/2.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController
{
    NSIndexPath *indexPath;
}
@property NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSString *param;

@end
