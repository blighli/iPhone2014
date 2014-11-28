//
//  passImageValueDelegate.h
//  EverNote
//
//  Created by lh on 14-11-26.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
@class NSString;
@class NSArray;

@protocol passImageValueDelegate <NSObject>

@optional
-(void)passValue:(UIImage *)value;
@optional
-(void)passAllValue:(NSString *)title WithContent:(NSString *)content;
@end
