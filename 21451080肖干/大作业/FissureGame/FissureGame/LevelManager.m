//
//  LevelManager.m
//  FissureGame
//
//  Created by xiaoo_gan on 12/21/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "LevelManager.h"

@implementation LevelManager
SINGLETON_IMPL(LevelManager);

- (id) init {
    if (self = [super init]) {
        //读取关卡属性json文件
        PersistentDictionary *source = [PersistentDictionary dictionaryWithName:@"level_info"];
        sourceDictionary = source.dictionary;
        levelDictionary = sourceDictionary[@"levels"];  //关卡属性
        levelOrder = sourceDictionary[@"level_order"];  //关卡顺序
    }
    return self;
}
//根据关卡名称获取关卡id
- (int) levelNumForId:(NSString *)levelId {
    int levelIndex = 0;
    for (NSString *Id in levelOrder) {
        if ([levelId isEqualToString:Id]) {
            return levelIndex;
        }
        levelIndex ++;
    }
    return -1;
}

// 根据关卡名称获得关卡地图字典
- (NSDictionary *) levelDictionaryForId:(NSString *)levelId {
    return levelDictionary[levelId];
}
//根据关卡ID获取关卡名称
- (NSString *) levelIdAtPosition:(int)position {
    return levelOrder[position];
}
//关卡个数
- (int) levelCount {
    return (SInt32)[levelOrder count];
}
//根据关卡id，查询是否可用
- (BOOL) isAvailable:(NSString *)levelId {
    PersistentDictionary *avail = [PersistentDictionary dictionaryWithName:@"levels_avail"];
    return [avail.dictionary[levelId] boolValue];
}
//设置关卡可用
- (void) setAvailable:(NSString *)levelId {
    
    PersistentDictionary *avail = [PersistentDictionary dictionaryWithName:@"levels_avail"];
    avail.dictionary[levelId] = @(YES);
    [avail saveToFile];
    
}
//该关卡是否完通过
- (BOOL) isComplete:(NSString *)levelId {
    PersistentDictionary *comp = [PersistentDictionary dictionaryWithName:@"levels_complete"];
    return [comp.dictionary[levelId] boolValue];
}

//设置改关卡已经通过
- (void) setComplete:(NSString *)levelId {
    PersistentDictionary *comp = [PersistentDictionary dictionaryWithName:@"levels_complete"];
    comp.dictionary[levelId] = @(YES);
    [comp saveToFile];
}

//当前关卡名称
- (NSString *) currentLevelId {
    PersistentDictionary *curr = [PersistentDictionary dictionaryWithName:@"current_level"];
    
    if (!curr.dictionary[@"currentId"]) {   //，初安装，当前关卡为nil
        return @"level-1";                  //初始化为关卡一
    }
    return curr.dictionary[@"currentId"];   
}

//设置当前关卡
- (void) setCurrentLevelId:(NSString *)currentLevelId {
    PersistentDictionary *comp = [PersistentDictionary dictionaryWithName:@"levels_complete"];
    comp.dictionary[@"currentId"] = currentLevelId;
    [comp saveToFile];
}

@end













