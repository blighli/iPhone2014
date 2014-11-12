//
//  JS.h
//  001
//
//  Created by CST-112 on 14-11-9.
//  Copyright (c) 2014年 CST-112. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JS : NSObject
{
    NSMutableArray * arry;
    NSMutableArray * positionleft;
}
@property  (copy) NSString* result;
@property (copy) NSMutableString* Arithmetic;
@property float sum;

-(NSString *) output;
-(float) sumPluse;
-(float) sumSub;
-(id) initWithString:(NSString *) string;
@end