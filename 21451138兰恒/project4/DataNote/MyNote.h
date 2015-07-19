//
//  MyNote.h
//  DataNote
//
//  Created by lh on 14-11-27.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ImageData;

@interface MyNote : NSManagedObject

@property (nonatomic, retain) NSString * note_Text;
@property (nonatomic, retain) NSString * note_title;
@property (nonatomic, retain) NSString * note_date;
@property (nonatomic, retain) NSSet *noteAndImage;
@end

@interface MyNote (CoreDataGeneratedAccessors)

- (void)addNoteAndImageObject:(ImageData *)value;
- (void)removeNoteAndImageObject:(ImageData *)value;
- (void)addNoteAndImage:(NSSet *)values;
- (void)removeNoteAndImage:(NSSet *)values;

@end
