//
//  AppDelegate.h
//  Project3
//
//  Created by Cocoa on 14/11/9.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTaskViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *task;
@property (assign, nonatomic) id delegate;

- (IBAction)saveTask:(id)sender;
- (IBAction)close:(id)sender;
@end
