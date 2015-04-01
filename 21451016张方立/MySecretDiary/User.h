//
//  User.h
//  MySecretDiary
//
//  Created by icy on 14-12-19.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Diary;

@interface User : NSObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSSet *diaries;

@end

@interface User (CoreDataGeneratedAccessors)

+(NSArray *)allDiariesSortedBy:(NSString *)sortDescriptor;
+(void)deleteAll;
+(bool)deleteUser:(User *)user;

//-(bool)save;

- (void)addDiariesObject:(Diary *)value;
- (void)removeDiariesObject:(Diary *)value;
- (void)addDiaries:(NSSet *)values;
- (void)removeDiaries:(NSSet *)values;

- (NSManagedObjectContext *)managedObjectContext;

@end
