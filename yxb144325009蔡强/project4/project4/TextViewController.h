//
//  TextViewController.h
//  project4
//
//  Created by zack on 14-11-22.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) id delegate;

@end
