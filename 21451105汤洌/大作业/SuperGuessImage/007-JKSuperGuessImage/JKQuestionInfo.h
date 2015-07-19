//
//  JKQuestionInfo.h
//  007-JKSuperGuessImage
//
//  Created by Chencheng on 14/11/8.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JKQuestionInfo : NSObject

@property (nonatomic, copy) NSString *answer;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *options;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)questionWithDict:(NSDictionary *)dict;

@property (nonatomic, strong, readonly) UIImage *image;

+ (NSArray *)questions;

@end
