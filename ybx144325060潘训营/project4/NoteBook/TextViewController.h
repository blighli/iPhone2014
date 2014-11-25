//
//  TextViewController.h
//  NoteBook
//
//  Created by Mz on 14-11-23.
//  Copyright (c) 2014年 pxy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@class Note;
@interface TextViewController : UIViewController
@property (nonatomic) ViewController *mainView;
@property (nonatomic) Note *currentNote;
@end
