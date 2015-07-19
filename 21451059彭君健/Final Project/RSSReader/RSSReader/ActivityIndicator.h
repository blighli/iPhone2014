//
//  ActivityIndicator.h
//  RSSReader
//
//  Created by Mz on 14-12-12.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActivityIndicator : NSObject
+ (ActivityIndicator*) sharedInstance;
- (void) start:(UIViewController*) vc;
- (void) stop;
@end
