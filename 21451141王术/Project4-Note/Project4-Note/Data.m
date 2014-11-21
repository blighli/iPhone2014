//
//  Data.m
//  Project4-Note
//
//  Created by  ws on 11/21/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import "Data.h"


@implementation Data

@dynamic type;
@dynamic attribute;
@dynamic time;
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
