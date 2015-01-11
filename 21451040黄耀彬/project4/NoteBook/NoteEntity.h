//
//  NoteEntity.h
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NoteEntityType) {
    WordNote,
    PicNote,
    DrawNote 
};

@interface NoteEntity : NSObject

@property NSInteger id;
@property NoteEntityType type;
@property (copy) NSString* content;

-(instancetype) initWithType:(NoteEntityType) type andContent:(NSString*) content;

@end
