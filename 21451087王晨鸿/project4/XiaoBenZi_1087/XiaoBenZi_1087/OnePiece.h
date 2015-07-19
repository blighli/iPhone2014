//
//  OnePiece.h
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-21.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnePiece : NSObject
{
    NSInteger iD;
    NSMutableString* title;
    NSInteger type;//0:wenzi 1:zhaopian 2:shouxie
    NSMutableString* info;

}

@property NSInteger iD;
@property NSMutableString* title;
@property NSString * type;
@property NSMutableString* info;
@end
