//
//  Note.h
//  noteprotype
//
//  Created by zhou on 14/11/23.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Paint, Photo, Record;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * lastModifyTime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * note_id;
@property (nonatomic, retain) NSSet *photoContainer;
@property (nonatomic, retain) NSSet *recordContainer;
@property (nonatomic, retain) NSSet *paintContainer;
@end

@interface Note (CoreDataGeneratedAccessors)

- (void)addPhotoContainerObject:(Photo *)value;
- (void)removePhotoContainerObject:(Photo *)value;
- (void)addPhotoContainer:(NSSet *)values;
- (void)removePhotoContainer:(NSSet *)values;

- (void)addRecordContainerObject:(Record *)value;
- (void)removeRecordContainerObject:(Record *)value;
- (void)addRecordContainer:(NSSet *)values;
- (void)removeRecordContainer:(NSSet *)values;

- (void)addPaintContainerObject:(Paint *)value;
- (void)removePaintContainerObject:(Paint *)value;
- (void)addPaintContainer:(NSSet *)values;
- (void)removePaintContainer:(NSSet *)values;

@end
