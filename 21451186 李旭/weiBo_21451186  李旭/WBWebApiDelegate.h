//
//  WBApi.h
//  weiBo
//
//  Created by lixu on 14/12/16.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

@protocol WBWebApiDelegate <NSObject>
@optional

- (void)requestDataOnSuccess:(id)backToControllerData;

- (void)requestDataOnFail:(NSString *)error;
@end
