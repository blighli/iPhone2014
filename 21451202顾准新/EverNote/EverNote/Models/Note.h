//
//  Note.h
//  EverNote
//
//  Created by 顾准新 on 14-12-6.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property NSInteger ID;
@property NSString *noteTitle;
@property NSString *noteContents;
@property NSString *notePhotoName;
@property NSString *noteDrawName;
@property NSString *createTime;

-(instancetype)initWithNote:(Note *)note;
@end
