//
//  IconView.h
//  HVeBo
//
//  Created by HJ on 14/12/9.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    kIconTypeSmall,
    kIconTypeDefault,
    kIconTypeBig
} IconType;
@class User;
@interface IconView : UIView

@property (nonatomic, strong) User *user;
@property (nonatomic, assign) IconType type;

- (void)setUser:(User *)user type:(IconType)type;

+ (CGSize)iconSizeWithType:(IconType)type;

@end
