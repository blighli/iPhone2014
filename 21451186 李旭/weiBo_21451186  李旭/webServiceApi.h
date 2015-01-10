//
//  publicTimeLineApi.h
//  weiBo
//
//  Created by lixu on 14/12/6.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WBWebApiDelegate.h"
#define kAppKey        @"4001696098"
#define kRederectUri   @"https://api.weibo.com/oauth2/default.html"
#define kAppSecret     @"b619afc323f22ed7852e4cd057831f93"

@interface webServiceApi : NSObject

-(NSArray *) requestForPublicTimeLinePageCount:(NSInteger) pageCount;
-(NSArray *) requestForFriendTimeLineLoadPage:(NSInteger) page andPageCount:(NSInteger)pageCount;
-(NSArray *) requestForMineTimeLineLoadPage:(NSInteger) page andPageCount:(NSInteger) pageCount;
-(NSArray *) requestForHerTimeLineWithScreenName:(NSString * ) name andPage:(NSInteger) page andPageCount:(NSInteger) pageCount;
-(void) updateMyNews:(NSString *) string;

@property (assign,nonatomic) id< WBWebApiDelegate > webApiDegate;
@property (strong,nonatomic) NSString *code;
@property (strong,nonatomic) NSString *token;
@property (strong,nonatomic) NSString *userID;


@end
