//
//  NoteRecord.h
//  Note
//
//  Created by Mac on 14-11-21.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteRecord : NSObject


@property (assign,nonatomic) NSInteger row;
@property (copy,nonatomic) NSString *topicStr;
@property (copy,nonatomic) NSString *contentStr;

@end
