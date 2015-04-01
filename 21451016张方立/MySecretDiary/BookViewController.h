//
//  BookViewController.h
//  MySecretDiary
//
//  Created by icy on 14-12-22.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class User,BookFrontView, BookBackView,BookViewController;


@protocol BookViewControllerDelegate <NSObject>
-(void)nameBookFinishedWithName:(NSString *)oppName by:(BookViewController *)book;
-(void)deleteThisBook:(BookViewController *)book;
-(void)didSelectBook:(BookViewController *)book;
@end




@interface BookViewController : UIViewController <UITextFieldDelegate>
{}


@property (strong, nonatomic)User *user;
@property (strong, nonatomic)BookFrontView *frontView;
@property (strong, nonatomic)BookBackView *backView;
@property (readonly, nonatomic) BOOL frontViewIsVisible;
@property (assign)id delegate;



-(id)initWithUser:(User *)user;
-(void)configButtonSelected:(id)sender;
-(void)backButtonSelected:(id)sender;
-(void)deleteButtonSelected:(id)sender;
-(void)addNewButtonSelected;
-(void)changeNamePressed;

-(void)flipCurrentView;
-(void)refreshFrontView;



@end
