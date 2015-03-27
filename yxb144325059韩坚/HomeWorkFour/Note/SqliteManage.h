//
//  SqliteManage.h
//  SQLite Persistence
//
//  Created by HJ on 14/11/14.
//  Copyright (c) 2014年 Apress. All rights reserved.
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
