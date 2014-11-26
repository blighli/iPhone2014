//
//  Note.h
//  Note
//
//  Created by jiaoshoujie on 14-11-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic, assign) int tag;
@property (nonatomic ,strong) NSString *dateTime;
@property (nonatomic, strong) NSString *detail;

@end
