//
//  MainViewController.h
//  MySecretDiary
//
//  Created by icy on 15-1-8.
//  Copyright (c) 2015年 icy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookViewController.h"
#import "SliderPageControl.h"
#import "User.h"
@class RootContainerViewController;

@interface MainViewController : UIViewController  <UIScrollViewDelegate, BookViewControllerDelegate, SliderPageControlDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate>{
    bool pageControlUsed;


}
@property (strong, nonatomic) UIScrollView *bookScrollView;
@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) NSMutableArray *books;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) RootContainerViewController *parent;
@property (strong, nonatomic) SliderPageControl *sliderPageControl;

/* MainViewController Funtions */
-(id)initWithManagedObjectContext:(NSManagedObjectContext *)cntxt;
-(void)resizeScrollView;

/*Slider Page Control Helper Functions*/
-(void)slideToCurrentPage:(bool)animated;
-(void)changeToPage:(int)page animated:(BOOL)animated;
-(void)setupSlider;
-(void)loadScrollViewWithPage:(NSInteger)page;
-(void)reloadBooks;

@end
