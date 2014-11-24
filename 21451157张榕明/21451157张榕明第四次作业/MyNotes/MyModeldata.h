//
//  MyModeldata.h
//  MyNotes
//
//  Created by 张榕明 on 14/11/22.
//  Copyright (c) 2014年 张榕明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModeldata : NSObject
//数据model

@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * subtitle;
@property(nonatomic,copy)NSData * contentdata;
@property(nonatomic,copy)NSString * time;
@property(nonatomic)int type;

@end
