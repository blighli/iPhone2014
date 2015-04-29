//
//  NoteEntity.h
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/15.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NoteEntityType) {   // 笔记类型
    WordNote,       // 纯文字笔记
    PicNote,        // 图片笔记
    DrawNote        // 涂鸦笔记
};

@interface NoteEntity : NSObject

@property NSInteger id;
@property NoteEntityType type;
@property (copy) NSString* content;

-(instancetype) initWithType:(NoteEntityType) type andContent:(NSString*) content;

@end
