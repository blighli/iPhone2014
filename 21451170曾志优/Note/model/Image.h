//
//  Image.h
//  Note
//
//  Created by Mac on 14-11-24.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

@property(assign,nonatomic) NSInteger row;

@property (copy,nonatomic) NSString *topicStr;

@property (copy,nonatomic) NSData *binImage;

@end
