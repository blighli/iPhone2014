//
//  RootBookViewController.h
//  MySecretDiary
//
//  Created by icy on 15-1-9.
//  Copyright (c) 2015年 icy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "BookViewController.h"
#import "RKPageViewController.h"
@interface RootBookViewController :UIViewController <UITextViewDelegate,UIPageViewControllerDelegate>

@property (assign) id delegate;
@property (weak, nonatomic) IBOutlet UITextView *diaryContent;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (assign) BookViewController *topBook;
@property (strong,nonatomic)User *user;
@property (strong,nonatomic)Diary *diary;
@property (strong, nonatomic) RKPageViewController *pageViewController;

/* UIPageViewController helper functions */
-(void)flipToPage:(int)page animated:(bool)animated forward:(bool)forward;
-(void)openBook;
-(void)closeBook;
//- (NSManagedObjectContext *)managedObjectContext;


@end
