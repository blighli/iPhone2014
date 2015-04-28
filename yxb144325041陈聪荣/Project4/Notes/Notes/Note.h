//
//  Note.h
//  Notes
//
//  Created by 陈聪荣 on 14/12/1.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

//保存的时间戳，修改后会更新
@property(nonatomic, strong) NSDate* date;
//文本内容
@property(nonatomic, strong) NSString* content;
//保存的绘图或者摄像头照片1
@property(nonatomic, strong) NSData* img;
//类型 1：文本2：照片3：绘图
@property(nonatomic) int type;

@end
