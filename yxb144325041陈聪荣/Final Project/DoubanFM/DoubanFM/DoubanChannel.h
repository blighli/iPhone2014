//
//  DouabanChannel.h
//  DoubanFM
//
//  Created by 陈聪荣 on 14/12/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoubanChannel : NSObject

//{"name":"华语","seq_id":0,"abbr_en":"","channel_id":"1","name_en":""}
@property(strong , nonatomic) NSString* name;
@property(strong , nonatomic) NSString* name_en;
@property(strong , nonatomic) NSString* abbr_en;
@property(nonatomic) NSInteger seq_id;
@property(nonatomic) NSInteger channel_id;

- (instancetype)initWithName:(NSString*) name andChannelId:(NSInteger)channel_id;
@end
