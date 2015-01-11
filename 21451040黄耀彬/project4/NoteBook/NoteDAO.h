//
//  NoteDAO.h
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
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
