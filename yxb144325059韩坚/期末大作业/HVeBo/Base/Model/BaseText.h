//
//  BaseTest.h
//  HVeBo
//
//  Created by HJ on 14/12/16.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseModel.h"
@class User;

@interface BaseText : BaseModel

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) User *user;


@end
