//
//  Counter.h
//  Counter
//
//  Created by Mac on 14-11-7.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface counter : NSObject
{
    NSMutableArray* arryForOperator;
    NSMutableArray* arryForNum;
}
@property  float result;
@property (copy) NSMutableString* Arithmetic;
-(NSString*) print;
-(id) initWithString:(NSString*) string;
@end


