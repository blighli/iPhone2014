//
//  LevelManager.h
//  FissureGame
//
//  Created by xiaoo_gan on 12/21/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelManager : NSObject {
    NSDictionary *sourceDictionary;
    NSDictionary *levelDictionary;
    NSArray      *levelOrder;
}
@property (nonatomic, strong) NSString *currentLevelId;

SINGLETON_INTR(LevelManager);

- (NSString *) levelIdAtPosition: (int) position;
- (int) levelCount;
- (NSDictionary *) levelDictionaryForId: (NSString *) levelId;
- (int) levelNumForId: (NSString *) levelId;
- (BOOL) isAvailable: (NSString *) levelId;
- (void) setAvailable: (NSString *) levelId;
- (BOOL) isComplete: (NSString *) levelId;
- (void) setComplete: (NSString *) levelId;

@end
