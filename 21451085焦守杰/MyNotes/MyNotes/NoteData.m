//
//  TextNoteData.m
//  MyNotes
//
//  Created by 焦守杰 on 14/11/15.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteData.h"
@implementation NoteData
@synthesize note;
@synthesize time;
@synthesize id;
-(id)initWithNote:(NSString*)note andTime:(NSString* )time andID:(int)d{
    self=[super init];
    if(self!=nil){
        [self setNote:note];
        [self setTime:time];
        [self setId:d];
    }
    return self;
}


@end