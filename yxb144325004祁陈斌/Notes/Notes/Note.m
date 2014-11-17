//
//  Note.m
//  Notes
//
//  Created by xsdlr on 14/11/17.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "Note.h"

@implementation Note

@dynamic message;
@dynamic time;
@dynamic type;

+ (NSString *)TEXT_TYPE {
    return @"text";
}
+(NSString *)IMAGE_TYPE {
    return @"image";
}
+(NSString *)DRAW_TYPE {
    return @"draw";
}

@end
