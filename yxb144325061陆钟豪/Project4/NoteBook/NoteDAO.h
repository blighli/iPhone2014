//
//  NoteDAO.h
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/15.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteEntity.h"

@interface NoteDAO : NSObject

-(instancetype) init;
-(void) createTable;
-(void) insertNote:(NoteEntity*) noteEntity;
-(void) deleteNoteById:(NSInteger) id;
-(void) updateNote:(NoteEntity*) noteEntity;
-(NSMutableArray*) queryNoteByOffset:(NSInteger) offset andLength:(NSInteger) length;
-(NoteEntity*) loadNoteByOffset:(NSInteger) offset;
-(NoteEntity*) loadNoteById:(NSInteger) id;
-(NSInteger) getAllCount;
-(void) dealloc;

@end
