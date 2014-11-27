//
//  TextNoteData.h
//  MyNotes
//
//  Created by 焦守杰 on 14/11/15.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NoteData:NSObject
@property (strong,nonatomic)NSString *note;
@property (strong,nonatomic)NSString *time;
@property int id;
-(id)initWithNote:(NSString*)note andTime:(NSString* )time andID:(int)d;
@end
