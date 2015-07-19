//
//  ContentViewController.h
//  Project4
//
//  Created by xvxvxxx on 14/11/23.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
@interface ContentViewController : UIViewController
@property Note *note;
@property (strong, nonatomic) IBOutlet UITextField *notetitle;
@property (strong, nonatomic) IBOutlet UITextView *content;
-(instancetype)initWithNote:(Note *)note;
@end
