//
//  MyModeldata.h
//  MyNotes
//
//  Created by lzx on 24/11/14.
//  Copyright (c) 2014年 lzx. All rights reserved.
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
