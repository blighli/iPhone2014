//
//  TextViewController.h
//  MyNotes
//
//  Created by hu on 14/11/14.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextView *contentView;

-(IBAction)cancelkeyboard:(id)sender;

@end
