//
//  TextNoteViewController.h
//  AverNote
//
//  Created by Mz on 14-11-21.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface TextNoteViewController : UIViewController
@property (nonatomic) ViewController *mainView;
@property (nonatomic) NSString *text;
@end
