//
//  Note.h
//  Project4
//
//  Created by xvxvxxx on 14/11/23.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject
@property NSInteger ID;
@property NSString *notetitle;
@property NSString *content;
@property NSString *photo;
@property NSString *picture;
@property NSString *datetime;
-(instancetype)initWithNote:(Note *)note;
@end
//NSString *sql = @"create table if not exists notes (id integer primary key autoincrement, title text, content text, photo text, picture text, datetime text)";