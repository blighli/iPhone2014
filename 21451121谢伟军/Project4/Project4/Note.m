//
//  Note.m
//  Project4
//
//  Created by xvxvxxx on 14/11/23.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "Note.h"

@implementation Note
-(instancetype)initWithNote:(Note *)note{
    self = [super init];
    if (self) {
        self.ID = note.ID;
        self.notetitle = [NSString stringWithString:note.notetitle];
        self.content = [NSString stringWithString:note.content];
        self.photo = [NSString stringWithString:note.photo];
        self.picture = [NSString stringWithString:note.picture];
        self.datetime = [NSString stringWithString:note.datetime];
    }
    return self;
}
@end
