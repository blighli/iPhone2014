//
//  Note.m
//  project4
//
//  Created by xuyouyang on 14/11/23.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "Note.h"
#import "DB.h"
#import <sqlite3.h>

@implementation Note

+ (NSMutableArray *)getAllNotes{
    NSString *query = @"SELECT * FROM NOTES";
    sqlite3_stmt *statement;
    statement = [DB exectueQuery:query];
    NSMutableArray *notes = [[NSMutableArray alloc]init];
    while (sqlite3_step(statement) == SQLITE_ROW) {
        Note *note = [[Note alloc]init];
        note.title = [NSString stringWithUTF8String:sqlite3_column_text(statement, 0)];
        note.content = [NSString stringWithUTF8String:sqlite3_column_text(statement, 1)];
        note.imagePath = [NSString stringWithUTF8String:sqlite3_column_text(statement, 2)];
        note.type = [NSString stringWithUTF8String:sqlite3_column_text(statement, 3)];
        [notes addObject:note];
    }
    return notes;
}

+ (BOOL)addNoteWithTitle:(NSString *)title Content:(NSString *)content ImagePath:(NSString *)imagePath Type:(NSString *)type{
    return NO;
}
@end
