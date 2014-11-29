//
//  NoteDataSource.h
//  Notes
//
//  Created by xiaoo_gan on 11/25/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NoteData;

@interface NoteDataSource : NSObject

+ (id)sharedInstance;

- (NSInteger)noteCount;
- (NoteData *)getNoteAtIndex:(NSInteger)index;
- (void)addNote:(NoteData *)note;
- (void)removeNoteAtIndex:(NSInteger)index;

- (void)saveToFilePath:(NSString *)filePath;
- (void)loadFromFilePath:(NSString *)filePath;

@end
