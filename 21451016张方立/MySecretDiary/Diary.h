//
//  Diary.h
//  MySecretDiary
//
//  Created by icy on 14-12-19.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class User;


@interface Diary : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * date;

@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) User *user;

+(bool)deleteDiary:(Diary *)diary;

//-(bool)save;


@end

