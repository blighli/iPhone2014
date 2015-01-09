//
//  PhotoDelegate.h
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/22.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol UIPhotoDelegate <NSObject>
@optional

- (void)setPhoto:(UIImage *)photo;

@end

@interface PhotoDelegate : NSObject

@end
