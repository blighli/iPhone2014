//
//  PaintViewControlly.h
//  Note
//
//  Created by HJ on 14/11/17.
//  Copyright (c) 2014年 cstlab.hj.NOTE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"

@class paintview ;
@interface PaintViewControlly : UIViewController

@property(nonatomic,strong) NSObject<PassValueDelegate> *delegate;

@end
