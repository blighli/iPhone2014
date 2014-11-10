//
//  Model.h
//  toDoList
//
//  Created by LFR on 14/11/10.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic, strong) NSMutableArray* listArray;

+ (id)sharedInstance;
- (void)writeToFile;
- (void)loadFromFile;

@end
