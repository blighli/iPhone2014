//
//  Sqlite.h
//  NOTEbook
//
//  Created by SXD on 14/12/3.
//  Copyright (c) 2014年 SXD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SqliteManage : NSObject

- (BOOL)creatDB;
- (BOOL) replaceDB : (int) row data:(NSString *) fieldsData;
- (BOOL) saveImage :(int) row data:(NSString *) fieldsData data:(UIImage *) image;
- (BOOL) saveImageAndPaint :(int) row data:(NSString *) fieldsData image:(UIImage *) image andPaint: (UIImage *) paint;
- (BOOL) addImageAndPaint :(NSString *) fieldsData image:(UIImage *) image andPaint: (UIImage *) paint;
- (UIImage *) readImage: ( NSInteger) witchRow;
- (UIImage *) readPaint: ( NSInteger) witchRow;
- (NSString *) readDB: ( NSInteger) witchRow;
- (NSInteger) sqlCount;
- (NSMutableArray *) sqlCountArray;
- (BOOL) sqlDelete: (NSInteger) witchRow;
+ (SqliteManage *) sqliteManage;
@end
