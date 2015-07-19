

//
//  Constants.h
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-22.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import<UIKit/UIKit.h>
#import"OnePiece.h"

static OnePiece* pastOnePiece;
static NSInteger whoPastit;//0查看 1新建
@interface Constants : NSObject
+(OnePiece*)getPastOnePiece;
+(NSInteger)getWhoPastit;
+(void)setPastOnePiece:(OnePiece*)onePiece;
+(void)setWhoPastit:(NSInteger)who;
@end

