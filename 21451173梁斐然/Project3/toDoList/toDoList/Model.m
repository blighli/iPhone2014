//
//  Model.m
//  toDoList
//
//  Created by LFR on 14/11/10.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import "Model.h"

@interface Model ()

@property (nonatomic, copy) NSString* filePath;

@end

@implementation Model

+ (instancetype)sharedInstance {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Model alloc] init];
    });
    
    return sharedInstance;
}

- (NSString *)filePath {
    return [self filePathWith:@"lfr.plist"];
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc] init];
    };
    return _listArray;
}

- (void)writeToFile {
    [self.listArray writeToFile:self.filePath atomically:YES];
}

- (void)loadFromFile {
    if([[NSFileManager defaultManager] fileExistsAtPath:self.filePath])
        self.listArray = [NSMutableArray arrayWithContentsOfFile:self.filePath];
    else
        self.listArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lfr" ofType:@"plist"]];
}

- (NSString *)filePathWith:(NSString*)fileName {
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [Path stringByAppendingPathComponent:fileName];
}
@end
