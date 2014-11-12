//
//  Count.h
//  Counter2
//
//  Created by  sephiroth on 14/11/6.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Count : NSObject
{
    NSMutableArray * arry;
    NSMutableArray * positionleft;
}
@property  (copy) NSString* result;
@property (copy) NSMutableString* Arithmetic;
@property float sum;
+(void) sumpluse:(float) num;
+(void) sumsub:(float) num;
+(float) sumget;
-(NSString *) output;
-(float) sumPluse;
-(float) sumSub;
-(id) initWithString:(NSString *) string;
@end
