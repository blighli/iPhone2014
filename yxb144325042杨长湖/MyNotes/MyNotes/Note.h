//
//  Note.h
//  MyNotes
//
//  Created by 杨长湖 on 14/11/23.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property int ids;
@property (strong,nonatomic)NSString *note;
@property (strong,nonatomic)NSString *time;

-(id)initWithNote:(NSString*)note andTime:(NSString* )time andID:(int)d;

@end
