//
//  JKQuestionInfo.m
//  007-JKSuperGuessImage
//
//  Created by Chencheng on 14/11/8.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import "JKQuestionInfo.h"

@implementation JKQuestionInfo

{
    UIImage *_image;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)questionWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (UIImage *)image
{
    if (!_image) {
        _image = [UIImage imageNamed:self.icon];
    }
    return _image;
}

+ (NSArray *)questions
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self questionWithDict:dict]];
    }
    
    return [arrayM copy];
}

@end
