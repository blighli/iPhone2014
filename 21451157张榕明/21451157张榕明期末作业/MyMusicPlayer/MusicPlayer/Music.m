//
//  Music.m
//  MyMusicPlayer
//
//  Created by 张榕明 on 15/01/01.
//  Copyright (c) 2015年 张榕明. All rights reserved.
//

#import "Music.h"

@implementation Music
@synthesize name, type;

- (id)initWithName:(NSString *)_name andType:(NSString *)_type {
    if (self = [super init]) {
        self.name = _name;
        self.type = _type;
    }
    return self;
}

@end
