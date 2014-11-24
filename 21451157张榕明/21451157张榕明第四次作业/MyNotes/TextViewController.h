//
//  TextViewController.h
//  MyNotes
//
//  Created by 张榕明 on 14/11/22.
//  Copyright (c) 2014年 张榕明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextView *contentView;

-(IBAction)cancelkeyboard:(id)sender;

@end
