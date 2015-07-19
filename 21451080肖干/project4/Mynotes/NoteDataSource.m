//
//  NoteDataSource.m
//  Notes
//
//  Created by xiaoo_gan on 11/25/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "NoteDataSource.h"
#import "NoteData.h"

@interface NoteDataSource()
@property (strong, nonatomic) NSMutableArray *notes;
@end

@implementation NoteDataSource
@synthesize notes = _notes;

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;       
}

- (NSInteger)noteCount
{
    return self.notes.count;
}

- (NoteData *)getNoteAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.notes.count) {
        NSLog(@"NoteDataSource::getNoteAtIndex -- invalid note index");
        return nil;
    }
    
    return [self.notes objectAtIndex:index];
}

- (void)addNote:(NoteData *)note
{
    NSLog(@"添加一条记事");
    if (note == nil) {
        NSLog(@"NoteDataSource::addNote -- invalid note added");
        return;
    }
    
    if (self.notes == nil) {
        self.notes = [[NSMutableArray alloc] init];
    }
    
    [self.notes insertObject:note atIndex:0];
}

- (void)removeNoteAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.notes.count) {
        NSLog(@"NoteDataSource::removeNoteAtIndex -- invalid note index");
        return;
    }
    
    [self.notes removeObjectAtIndex:index];
}

- (void)saveToFilePath:(NSString *)filePath
{
    if (![NSKeyedArchiver archiveRootObject:self.notes toFile:filePath]) {
        NSLog(@"NoteDataSource::saveToFilePath -- save to %@ failed", filePath);
    }
}

- (void)loadFromFilePath:(NSString *)filePath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        self.notes = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:filePath]];
    } else {
        NSLog(@"NoteDataSource::loadFromFilePath -- %@ doesn't exist", filePath);
    }
}

@end
