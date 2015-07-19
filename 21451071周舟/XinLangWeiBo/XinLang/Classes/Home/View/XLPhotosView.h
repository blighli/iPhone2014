//
//  XLPhotosView.h
//  XinLang
//
//  Created by 周舟 on 14-10-4.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLPhotosView : UIView

@property (nonatomic, strong) NSArray *photos;

+ (CGSize) photoViewSizeWithPhotoCount:(int)count;

@end
