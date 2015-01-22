//
//  Record.h
//  EasyCount
//
//  Created by yingxl1992 on 14/12/28.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Record : NSObject
{
    NSInteger id;
    NSString *username;
    NSString *addTime;
    NSInteger money;
    NSString *des;
    NSInteger type;
    NSInteger accountType;
    NSInteger year;
    NSInteger month;
    NSInteger day;
}
@property NSInteger id;
@property NSString *username;
@property NSString *addTime;
@property NSInteger money;
@property NSString *des;
@property NSInteger type;
@property NSInteger accountType;
@property NSInteger year;
@property NSInteger month;
@property NSInteger day;

@end
