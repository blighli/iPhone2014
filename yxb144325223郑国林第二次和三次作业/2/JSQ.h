//
//  JSQ.h
//  001
//
//  Created by CST-112 on 14-11-6.
//  Copyright (c) 2014年 CST-112. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JSQ : NSObject
{
    NSMutableArray* arryForOperator;
    NSMutableArray* arryForNum;
}
@property  float result;
@property (copy) NSMutableString* Arithmetic;
-(NSString*) print;
-(id) initWithString:(NSString*) string;
@end


