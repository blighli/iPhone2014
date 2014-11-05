//
//  Util.h
//  Calculator
//
//  Created by Mz on 14-11-4.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
+ (bool) isNumber:(unichar)c;
+ (double) readDouble:(NSString*)s atIndex:(int*)index;
+ (double) readPart:(NSString*)s atIndex:(int*)index;
+ (double) calculate:(NSString*)s;
@end
