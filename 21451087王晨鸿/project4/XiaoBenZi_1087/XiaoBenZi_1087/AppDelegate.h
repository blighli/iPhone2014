//
//  AppDelegate.h
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-20.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnePiece.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString* databasePath;
    NSMutableArray* arrayOnePiece;
}

@property (strong, nonatomic) UIWindow *window;
@property NSInteger WhoPastit;
@property OnePiece * PastOnePiece;


@end

