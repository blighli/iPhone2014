//
//  counter.h
//  Counter
//
//  Created by  sephiroth on 14/11/3.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
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


