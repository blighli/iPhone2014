//
//  NoteList.h
//  homework4
//
//  Created by yingxl1992 on 14/11/16.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteList : NSObject
{
    NSInteger Id;
    NSString *title;
    NSString *addtime;
    NSString *content;
    NSData *image;
}
@property NSInteger Id;
@property NSString *title;
@property NSString *addtime;
@property NSString *content;
@property NSData *image;

@end
