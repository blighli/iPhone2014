//
//  DockController.h
//  HVeBo
//
//  Created by HJ on 14/12/14.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Dock;

@interface DockController : UIViewController
{
    Dock *_dock;
    
}
@property (nonatomic, readonly) UIViewController *selectController;
@end
