//
//  PaintViewControlly.h
//  NOTEbook
//
//  Created by SXD on 14/12/3.
//  Copyright (c) 2014年 SXD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"

@class paintview ;
@interface PaintViewControlly : UIViewController

@property(nonatomic,strong) NSObject<PassValueDelegate> *delegate;

@end
