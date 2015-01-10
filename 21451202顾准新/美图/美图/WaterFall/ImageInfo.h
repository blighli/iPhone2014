//
//  ImageInfo.h
//  美图
//
//  Created by 顾准新 on 14-12-23.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageInfo : NSObject

@property float width;
@property float height;
@property (nonatomic,strong)NSString *thumbURL;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *love;
@property (nonatomic,strong)NSArray *tags;

@property (assign) BOOL disabledTagging;
@property (assign) BOOL disabledCommenting;
@property (assign) BOOL disabledActivities;
@property (assign) BOOL disabledDelete;
@property (assign) BOOL disabledDeleteForTags;
@property (assign) BOOL disabledDeleteForComments;
@property (assign) BOOL disabledMiscActions;

+(instancetype)photoWithProperties:(NSDictionary *)photoInfo;
-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
