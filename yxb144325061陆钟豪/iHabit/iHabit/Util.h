//
//  Util.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/22.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActionBlock : UIViewController

-(instancetype)initWith:(void (^)(id sender))block;
-(void)action:(id) sender;

@end

@interface Util : NSObject

+(id)blockActionWithBlock:(void (^)(id sender))block;

@end
