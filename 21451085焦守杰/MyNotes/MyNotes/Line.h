//
//  Line.h
//  MyNotes
//
//  Created by 焦守杰 on 14/11/23.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Line : NSObject{
    NSMutableArray *_pointArray;
}
@property int size;
@property int color;
@property int length;
-(id)initWithColor:(int) c andSize:(int) s;
-(void)addPoint:(CGPoint)p;
-(CGPoint)getPointAt:(int)index;
-(int)getLength;
@end
