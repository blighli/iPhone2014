//
//  publicLIneModel.m
//  weiBo
//
//  Created by lixu on 15/1/3.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import "PublicLIneModel.h"

@implementation PublicLIneModel
@synthesize created_at,idstr,source,text,thumbnall_pic,bmiddle_pic,original_pic,userModel;

-(id)init{
    self=[super init];
    userModel=[[UserModel alloc] init];
    if (self) {
        
    }
    return self;
}
@end
