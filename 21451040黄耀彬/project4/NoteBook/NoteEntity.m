//
//  NoteEntity.m
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import "NoteEntity.h"

@implementation NoteEntity

-(instancetype) initWithType:(NoteEntityType) type andContent:(NSString*) content {
    self = [super init];
    self.type = type;
    self.content = content;
    return self;
}

@end
