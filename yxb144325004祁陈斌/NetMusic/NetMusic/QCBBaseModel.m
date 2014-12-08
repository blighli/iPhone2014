//
//  QCBBaseModel.m
//  NetMusic
//
//  Created by xsdlr on 14/12/5.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "QCBBaseModel.h"

@implementation QCBBaseModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"未知属性%@",key);
}
@end
