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
    statement = [DB executeSelectQuery:query];
    NSMutableArray *notes = [[NSMutableArray alloc]init];
    while (sqlite3_step(statement) == SQLITE_ROW) {
        Note *note = [[Note alloc]init];
        note.noteId = [NSString stringWithUTF8String:sqlite3_column_text(statement, 0)];
        note.title = [NSString stringWithUTF8String:sqlite3_column_text(statement, 1)];
        note.content = [NSString stringWithUTF8String:sqlite3_column_text(statement, 2)];
        note.imagePath = [NSString stringWithUTF8String:sqlite3_column_text(statement, 3)];
        note.type = [NSString stringWithUTF8String:sqlite3_column_text(statement, 4)];
        [notes addObject:note];
    }
    return notes;
}

- (void)add {
    // noteId为主键，时间戳
    NSString *noteId = [NSString stringWithFormat:@"%d", (int)[[NSDate date] timeIntervalSince1970]];
    NSString *query = [NSString stringWithFormat:@"INSERT INTO NOTES  VALUES ('%@', '%@', '%@', '%@', '%@')", noteId, self.title, self.content, self.imagePath, self.type];
    [DB executeQuery:query];
}

- (void)update {
    NSString *query = [NSString stringWithFormat:@"UPDATE NOTES SET title='%@', content='%@', imagePath='%@' WHERE id='%@'", self.title, self.content, self.imagePath, self.noteId];
    [DB executeQuery:query];
}

- (void)drop {
    NSString *query = [NSString stringWithFormat:@"DELETE FROM NOTES WHERE id = '%@'", self.noteId];
    [DB executeQuery:query];
}

@end
