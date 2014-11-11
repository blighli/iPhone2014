//
//  TodoDao.m
//  TodoList
//
//  Created by 陈聪荣 on 14/11/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "TodoDao.h"

@implementation TodoDao

static TodoDao *sharedManager = nil;
+ (TodoDao *) sharedManager{
    if(!sharedManager){
        sharedManager = [[self alloc] init];
        [sharedManager createEditableCopyOfSavefileIfNeeded];
    };
    return sharedManager;
}

- (void) createEditableCopyOfSavefileIfNeeded{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writableFilePath = [self applicationDocumentDirectoryFile];
    
    BOOL fileExists = [fileManager fileExistsAtPath:writableFilePath];
    if(!fileExists){
        NSString *defaultFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"todoList.plist"];
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultFilePath toPath:writableFilePath error:&error];
        if(!success){
            NSAssert1(0, @"复制文件错误：‘%@’。", [error localizedDescription]);
        }
    }
}

- (NSString*)applicationDocumentDirectoryFile{
    NSString *documentDirecory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirecory stringByAppendingPathComponent:@"todoList.plist"];
    return path;
}

//-(int) create:(NSString *)model{
//    NSString *path = [self applicationDocumentDirectoryFile];
//    NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:path];
//    [array addObject:model];
//    [array writeToFile:path atomically:YES];
//    return 0;
//}
//
//- (int) removeAtIndex:(NSUInteger)index{
//    NSString *path = [self applicationDocumentDirectoryFile];
//    NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:path];
//    [array removeObjectAtIndex:index];
//    [array writeToFile:path atomically:YES];
//    return 0;
//}
//- (int) edit:(NSString*)model atIndex:(NSUInteger)index{
//    NSString *path = [self applicationDocumentDirectoryFile];
//    NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:path];
//    [array replaceObjectAtIndex:index withObject:model];
//    [array writeToFile:path atomically:YES];
//    return 0;
//}

- (int) saveAll:(NSMutableArray*) array{
    NSString *path = [self applicationDocumentDirectoryFile];
    [array writeToFile:path atomically:YES];
    return 0;
}

- (NSMutableArray*) findAll{
    NSString *path = [self applicationDocumentDirectoryFile];
    return [[NSMutableArray alloc]initWithContentsOfFile:path];
}

@end
