//
//  IconView.m
//  HVeBo
//
//  Created by HJ on 14/12/9.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "IconView.h"
#import "User.h"
#import "HttpTool.h"
#import "UserViewController.h"
#import "WBNavigationController.h"
#import "User.h"

@interface IconView ()
{
    UIImageView *_icon; // 头像图片
    UIImageView *_vertify; // 认证图标
    NSString *_placehoder; // 占位图片
}
@end

@implementation IconView

// 任何UIView的init方法内部都会调用initWithFrame:方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.用户头像图片
        _icon = [[UIImageView alloc] init];
        [self addSubview:_icon];
        
        // 2.右下角的认证图标
        _vertify = [[UIImageView alloc] init];
        [self addSubview:_vertify];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(IconAction)];
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)IconAction
{
    UserViewController *user = [[UserViewController alloc] init];
    WBNavigationController *nav = [[WBNavigationController alloc] init];
    [nav addChildViewController:user];
    user.userName = _user.screenName;
    user.user = _user;
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}
#pragma mark 同时设置头像的用户和类型
- (void)setUser:(User *)user type:(IconType)type
{
    self.type = type;
    self.user = user;
}

#pragma mark 设置模型数据
- (void)setUser:(User *)user
{
    _user = user;
    
    // 1.设置用户头像图片
    [HttpTool dowloadImage:user.profileImageUrl iamgeview:_icon placeHolder:[UIImage imageNamed:@"avatar_default.png"]];
    _icon.hidden = NO;
    // 2.设置认证图标
    NSString *verifiedIcon = nil;
    switch (user.verifiedType) {
        case kVerifiedTypeNone: // 没有认证认证
            _vertify.hidden = YES;
            break;
        case kVerifiedTypeDaren: // 微博达人
            verifiedIcon = @"avatar_grassroot.png";
            break;
        case kVerifiedTypePersonal: // 个人
            verifiedIcon = @"avatar_vip.png";
            break;
        default: // 企业认证
            verifiedIcon = @"avatar_enterprise_vip.png";
            break;
    }
    
    // 3.如果有认证，显示图标
    if (verifiedIcon) {
        _vertify.hidden = NO;
        _vertify.image = [UIImage imageNamed:verifiedIcon];
    }
}
#pragma mark 设置图标的类型
- (void)setType:(IconType)type
{
    _type = type;
    
    // 1.判断类型
    CGSize iconSize;
    switch (type) {
        case kIconTypeSmall: // 小图标
            iconSize = CGSizeMake(kIconSmallW, kIconSmallH);
            _placehoder = @"avatar_default_small.png";
            break;
            
        case kIconTypeDefault: // 中图标
            iconSize = CGSizeMake(kIconDefaultW, kIconDefaultH);
            _placehoder = @"avatar_default.png";
            break;
            
        case kIconTypeBig: // 大图标
            iconSize = CGSizeMake(kIconBigW, kIconBigH);
            _placehoder = @"avatar_default_big.png";
            break;
    }
    
    // 2.设置frame
    _icon.frame = (CGRect){CGPointZero, iconSize};
    _vertify.bounds = CGRectMake(0, 0, kVertifyW, kVertifyH);
    _vertify.center = CGPointMake(iconSize.width, iconSize.height);
    
    // 3.自己的宽高
    CGFloat width = iconSize.width + kVertifyW * 0.5;
    CGFloat height = iconSize.height + kVertifyH * 0.5;
    self.bounds = CGRectMake(0, 0, width, height);
}
+ (CGSize)iconSizeWithType:(IconType)type
{
    CGSize iconSize;
    switch (type) {
        case kIconTypeSmall: // 小图标
            iconSize = CGSizeMake(kIconSmallW, kIconSmallH);
            break;
            
        case kIconTypeDefault: // 中图标
            iconSize = CGSizeMake(kIconDefaultW, kIconDefaultH);
            break;
            
        case kIconTypeBig: // 大图标
            iconSize = CGSizeMake(kIconBigW, kIconBigH);
            break;
    }
    CGFloat width = iconSize.width + kVertifyW * 0.5;
    CGFloat height = iconSize.height + kVertifyH * 0.5;
    return CGSizeMake(width, height);
}

@end
