//
//  MyModeldata.h
//  MyNotes
//
//  Created by hu on 14/11/15.
//  Copyright (c) 2014年 hu. All rights reserved.
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
