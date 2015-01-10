//
//  PageModule.h
//  MySecretDiary
//
//  Created by icy on 15-1-9.
//  Copyright (c) 2015年 icy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"
@class DataViewController;

@interface PageModule : NSObject <UIPageViewControllerDataSource>



@property (strong, nonatomic)NSMutableArray *controllers;
@property (assign) id rvc;
@property (strong, nonatomic)User* user;
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfViewController:(UIViewController *)viewController;
@end
