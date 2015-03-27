//
//  BaseModel.h
//  HVeBo
//
//  Created by HJ on 14/12/18.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property (nonatomic, assign)long long ID;
@property (nonatomic, copy) NSString *createdAt;

- (id)initWithDict: (NSDictionary *)dict;
@end
