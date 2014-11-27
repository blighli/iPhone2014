//
//  Line.m
//  MyNotes
//
//  Created by 焦守杰 on 14/11/23.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "Line.h"

@implementation Line

-(id)initWithColor:(int) c andSize:(int) s{
    self=[super init];
    if(self){
        self.size=s;
        self.color=c;
        _pointArray=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)addPoint:(CGPoint)p{
    NSString *sPoint = NSStringFromCGPoint(p);
    [_pointArray addObject:sPoint];
}
-(int) getLength{
    return _pointArray.count;
}
-(CGPoint)getPointAt:(int)index{
    NSString *p=[_pointArray objectAtIndex:index];
    return CGPointFromString(p);
}
@end
