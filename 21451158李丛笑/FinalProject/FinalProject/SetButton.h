//
//  SetButton.h
//  FinalProject
//
//  Created by 李丛笑 on 15/1/4.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#ifndef FinalProject_SetButton_h
#define FinalProject_SetButton_h
#import <UIKit/UIKit.h>


@interface SetButton : NSObject

-(NSArray *)getTableArray;
-(int)getButtonCount:(int)tableid;
-(NSString *)getButtonText:(int)tableid Classid:(int)classid;
-(NSString *)getButtonInfo:(int)tag Tableid:(int)tableid;

@end


#endif
