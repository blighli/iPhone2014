//
//  publicLIneModel.h
//  weiBo
//
//  Created by lixu on 15/1/3.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface PublicLIneModel : NSObject

@property (strong,nonatomic) NSString *created_at;
@property (nonatomic)  NSInteger* plid;
@property (nonatomic,strong) NSString *idstr;
@property (nonatomic,strong) NSString *source;
@property (strong,nonatomic) NSString* text;
@property (strong,nonatomic) NSString *thumbnall_pic;
@property (strong,nonatomic) NSString *bmiddle_pic;
@property (strong,nonatomic) NSString *original_pic;
@property (strong,nonatomic) UserModel *userModel;
@end
