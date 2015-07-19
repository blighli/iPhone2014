//
//  Note.m
//  MyNotes
//
//  Created by 杨长湖 on 14/11/23.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import "Note.h"

@implementation Note
@synthesize note;
@synthesize time;
@synthesize ids;
-(id)initWithNote:(NSString*)note andTime:(NSString* )time andID:(int)d{
    self=[super init];
    if(self!=nil){
        [self setNote:note];
        [self setTime:time];
        [self setIds:d];
    }
    return self;
}

@end
