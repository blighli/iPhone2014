//
//  RSSListViewController.h
//  RSSReader
//
//  Created by Mz on 14-12-13.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FeedItem;
@interface RSSListViewController : UIViewController
- (BOOL)hasNext;
- (BOOL)hasPrev;
- (void)selectNext;
- (void)selectPrev;
- (FeedItem*)currentItem;
@end
