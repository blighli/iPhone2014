//
//  MyPoint.m
//  whereAmI
//
//  Created by lh on 14-12-29.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import "MyPoint.h"

@implementation MyPoint
-(id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)t{
    self = [super init];
    if(self){
        _coordinate = c;
        _title = t;
    }
    return self;
}

@end
