//
//  caculate.h
//  CaculatorX
//
//  Created by CST on 14/11/8.
//  Copyright (c) 2014年 PengCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface caculate : NSObject

@property (assign, nonatomic)double opNumA;
@property (assign, nonatomic)double opNumB;
@property (assign, nonatomic)BOOL isCompleted;
-(double) compute;

@end
