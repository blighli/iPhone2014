//
//  HandDrawnDataSource.m
//  Mynotes
//
//  Created by xiaoo_gan on 11/28/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "HandDrawnDataSource.h"
#import "HandDrawnData.h"

@interface HandDrawnDataSource()

@property (strong, nonatomic) NSMutableArray *notes;

@end

@implementation HandDrawnDataSource
@synthesize notes = _notes;

+ (id) sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSInteger) noteCount
{
    return self.notes.count;
}

- (HandDrawnData *) getNoteAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.notes.count) {
        NSLog(@"HandDrawnDataSource:getNoteAtIndex -- invalid note index");
        return nil;
    }
    return [self.notes objectAtIndex:index];
}

- (void) addNote:(HandDrawnData *)note
{
    NSLog(@"添加一条手绘记事");
    if (note == nil) {
        NSLog(@"HandDrawnDataSource:addNote -- invalid note added");
        return;
    }
    if (self.notes == nil) {
        self.notes = [[NSMutableArray alloc] init];
    }
    [self.notes insertObject:note atIndex:0];
}

- (void) removeNoteAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.notes.count) {
        NSLog(@"HandDrawnDataSource:removeNoteAtIndex -- invalid note index");
        return;
    }
    [self.notes removeObjectAtIndex:index];
}

- (void) saveToFilePath:(NSString *)filePath
{
    if (![NSKeyedArchiver archiveRootObject:self.notes toFile:filePath]) {
        NSLog(@"HandDrawnDataSource:saveToFilePath -- save to %@ failed", filePath);
        return;
    }
}
- (void) loadFormFilePath:(NSString *)filePath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        self.notes = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:filePath]];
    } else {
        NSLog(@"HandDrawnDataSource:loadFormFilePath -- %@ doesn't exist", filePath);
    }
}
@end
