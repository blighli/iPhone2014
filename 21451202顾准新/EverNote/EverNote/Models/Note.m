//
//  Note.m
//  EverNote
//
//  Created by 顾准新 on 14-12-6.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "Note.h"

@implementation Note

-(instancetype)initWithNote:(Note *)note{
    self = [super init];
    if(self){
        self.ID = note.ID;
        self.noteTitle = note.noteTitle;
        self.notePhotoName = note.notePhotoName;
        self.noteDrawName = note.noteDrawName;
        self.createTime = note.createTime;
    }
    return self;
}


@end
