//
//  User.m
//  HVeBo
//
//  Created by HJ on 14/12/6.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "User.h"

@implementation User
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        _screenName = dict[@"screen_name"];
        _profileImageUrl = dict[@"profile_image_url"];
        _avatarLargeUrl = dict[@"avatar_large"];
        _descrip = dict[@"description"];
        
        _verified = [dict[@"verified"] boolValue];
        _verifiedType = [dict[@"verified_type"] intValue];
        _mbRank = [dict[@"mbrank"] intValue];
        _mbType = [dict[@"mbtype"] intValue];
    }
    return self;
}
@end
