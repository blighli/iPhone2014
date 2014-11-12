//
//  Test.h
//  iPhone
//
//  Created by 王路尧 on 14/11/8.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject
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
