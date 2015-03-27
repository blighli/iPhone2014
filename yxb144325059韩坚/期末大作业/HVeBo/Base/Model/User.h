//
//  User.h
//  HVeBo
//
//  Created by HJ on 14/12/6.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseModel.h"

typedef enum {
    kVerifiedTypeNone = - 1, // 没有认证
    kVerifiedTypePersonal = 0, // 个人认证
    kVerifiedTypeOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    kVerifiedTypeOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    kVerifiedTypeOrgWebsite = 5, // 网站官方：猫扑
    kVerifiedTypeDaren = 220 // 微博达人
} VerifiedType;

typedef enum {
    kMBTypeNone = 0, // 没有
    kMBTypeNormal, // 普通
    kMBTypeYear // 年费
} MBType;

@interface User : BaseModel

@property (nonatomic, copy) NSString *screenName;//用户昵称
@property (nonatomic, copy) NSString *profileImageUrl;//用户头像地址（中图），50×50像素
@property (nonatomic, copy) NSString *avatarLargeUrl; //180*180
@property (nonatomic, copy) NSString *coverImagePhone;//封面图片

@property (nonatomic, copy) NSString *descrip;//描述
@property (nonatomic, copy) NSString *domain;//个性域名
@property (nonatomic, copy) NSString *statusesCount;//微博数
@property (nonatomic, copy) NSString *friendsCount; //关注数
@property (nonatomic, copy) NSString *followersCount; //粉丝数

@property (nonatomic, assign) BOOL verified;//是否是微博认证用户，即加V用户，true：是，false：否
@property (nonatomic, assign) int verifiedType;//认证类型
@property (nonatomic, assign) int mbRank;//会员等级
@property (nonatomic, assign) int mbType;//会员类型


- (id) initWithDict:(NSDictionary *)dict;
@end
