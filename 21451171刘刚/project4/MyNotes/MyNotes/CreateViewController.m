//
//  CreateViewController.m
//  MyNotes
//
//  Created by liug on 14-11-15.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import "CreateViewController.h"
#import "sqlite3.h"
@interface CreateViewController ()
@end
@implementation CreateViewController
@synthesize notes=_notes;
@synthesize notetitle=_notetitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UIBarButtonItem *saveButton=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem=saveButton;
    [self openDB];
    [self createTableNamed:@"MyNotes" withField1:@"title" withField2:@"notes"];
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)save{
    [self insertRecordIntoTableNamed:@"MyNotes" withField1:@"title" field1Value:[_notetitle text] andField2:@"notes" field2Value:[_notes text]];
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSString *)filepath{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDir=[path objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"database.sql"];
}
-(void) openDB{
    if(sqlite3_open([[self filepath] UTF8String], &db)!=SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0,@"Database failed to open");
    }
}
-(void) createTableNamed:(NSString *)tablename
              withField1:(NSString *)field1
              withField2:(NSString *)field2{
    char *err;
    NSString *sql=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' ""TEXT PRIMARY KEY,'%@' TEXT);",tablename,field1,field2];
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"Table create failed");
    }
}
-(void) createDrawTableNamed:(NSString *)tablename
              withField1:(NSString *)path{
    char *err;
    NSString *sql=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' ""TEXT PRIMARY KEY);",tablename,path];
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"Table create failed");
    }
}

-(void) insertRecordIntoTableNamed:(NSString *)tableName
                        withField1:(NSString *)field1
                       field1Value:(NSString *)field1Value
                         andField2:(NSString *)field2
                       field2Value:(NSString *)field2Value{
    NSString *sql=[NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@' ('%@' , '%@')"
    "VALUES ('%@','%@')",tableName,field1,field2,field1Value,field2Value];
    char *err;
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"error updating table");
    }
}
-(void) insertDrawIntoTableNamed:(NSString *)tableName
                        withField1:(NSString *)field1
                       field1Value:(NSString *)field1Value{
    NSString *sql=[NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@' ('%@')"
                   "VALUES ('%@')",tableName,field1,field1Value];
    char *err;
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"error updating table");
    }
}

-(void)getAllRowsFromTable:(NSString *)tableName and:(NSMutableArray *)nsta second:(NSMutableArray *) seco{
    NSString *qsql=[NSString stringWithFormat:@"SELECT * FROM %@",tableName ];
    sqlite3_stmt *statement;
    if(sqlite3_prepare(db, [qsql UTF8String], -1, &statement, nil)==SQLITE_OK){
        while(sqlite3_step(statement)==SQLITE_ROW){
            char *field1=(char *)sqlite3_column_text(statement,0);
            NSString *field1str=[[NSString alloc]initWithUTF8String:field1];
            [nsta addObject:field1str];
            
            char *field2=(char *)sqlite3_column_text(statement,1);
            NSString *field2str=[[NSString alloc]initWithUTF8String:field2];
            [seco addObject:field2str];
        }
        sqlite3_finalize(statement);
    }
}
-(void)getAllRowsFromDraw:(NSString *)tableName and:(NSMutableArray *)nsta{
    NSString *qsql=[NSString stringWithFormat:@"SELECT * FROM %@",tableName ];
    sqlite3_stmt *statement;
    if(sqlite3_prepare(db, [qsql UTF8String], -1, &statement, nil)==SQLITE_OK){
        while(sqlite3_step(statement)==SQLITE_ROW){
            char *field1=(char *)sqlite3_column_text(statement,0);
            NSString *field1str=[[NSString alloc]initWithUTF8String:field1];
            [nsta addObject:field1str];
            
        }
        sqlite3_finalize(statement);
    }
}

-(void) deleteRecordfromTableNamed:(NSString *)tableName
                        withField1:(NSString *)field1
                       field1Value:(NSString *)field1Value{
    NSString *sql=[NSString stringWithFormat:@"DELETE  FROM %@ WHERE %@='%@'",tableName,field1,field1Value];
    char *err;
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"error deleteing table");
    }
}
-(void) deleteDrawfromTableNamed:(NSString *)tableName
                        withField1:(NSString *)field1
                       field1Value:(NSString *)field1Value{
    NSString *sql=[NSString stringWithFormat:@"DELETE  FROM %@ WHERE %@='%@'",tableName,field1,field1Value];
    char *err;
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"error deleteing table");
    }
}

@end
