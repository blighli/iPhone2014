//
//  PageViewController.h
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/16.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIPageViewController <UIPageViewControllerDataSource>


- (void) forward:(int)index;

@end
