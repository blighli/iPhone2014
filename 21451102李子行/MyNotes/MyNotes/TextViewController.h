//
//  TextViewController.h
//  MyNotes
//
//  Created by lzx on 24/11/14.
//  Copyright (c) 2014年 lzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextView *contentView;

-(IBAction)cancelkeyboard:(id)sender;

@end
