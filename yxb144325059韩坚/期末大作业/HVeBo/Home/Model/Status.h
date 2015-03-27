//
//  Status.h
//  HVeBo
//
//  Created by HJ on 14/12/6.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseText.h"

@interface Status : BaseText

@property (nonatomic, strong) NSArray *picUrls; //微博配图
@property (nonatomic, strong) Status *retweetedStatus; //被转发微博

@property (nonatomic, assign) int repostsCount;//转发数
@property (nonatomic, assign) int commentCount;	//	评论数
@property (nonatomic, assign) int attitudesCount;	//表态数.赞
@property (nonatomic, copy) NSString *source; //微博来源



@end
