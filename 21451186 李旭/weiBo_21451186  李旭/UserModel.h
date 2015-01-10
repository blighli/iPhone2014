//
//  userModel.h
//  weiBo
//
//  Created by lixu on 15/1/3.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *location;
@property (strong,nonatomic)NSString *udescription;
@property(strong,nonatomic) NSString *profile_image_url;
@property(strong,nonatomic) NSString *gender;

@end
