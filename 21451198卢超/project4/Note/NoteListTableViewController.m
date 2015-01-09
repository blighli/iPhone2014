//
//  NoteListTableViewController.m
//  Note
//
//  Created by jiaoshoujie on 14-11-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "NoteListTableViewController.h"
#import "sqlite3.h"
#import "Note.h"
#import "ShowNoteViewController.h"

#define kDatabaseName @"database.sqlite3"

@interface NoteListTableViewController ()

@end

@implementation NoteListTableViewController

@synthesize databaseFilePath;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showNotes];
    NSLog(@"count:%d",[self countofNotes]);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [self showNotes];
}

-(int)countofNotes{
    //打开数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"打开数据库失败！");
    }
    int count = 0;
    char *update = "SELECT COUNT(*) FROM NOTES";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, update, -1, &stmt, nil) == SQLITE_OK){
        while (sqlite3_step(stmt)==SQLITE_ROW){
            count = sqlite3_column_int(stmt, 0);
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    
    return count;
}

-(void)showNotes{
    //获取数据库文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.databaseFilePath = [documentsDirectory stringByAppendingPathComponent:kDatabaseName];
    
    //打开或创建数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"打开数据库失败");
    }
    //创建数据库表
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS NOTES (TAG INTEGER PRIMARY KEY,DETAILS TEXT,THEDATETIME TETX);";
    char *errorMsg;
    if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"创建数据库变错误：%s", errorMsg);
    }
    
    notes = [NSMutableArray arrayWithCapacity:20];
    
    //执行查询
    NSString *query = @"SELECT TAG, DETAILS, THEDATETIME FROM NOTES ORDER BY TAG DESC";
    sqlite3_stmt *statement;
    if (sqlite3_prepare(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        //依次读取数据库表格NOTES中每行的内容，并显示在对应的TextField
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //获取数据
            int tag = sqlite3_column_int(statement, 0);
            char *details = (char *)sqlite3_column_text(statement, 1);
            char *thedatetime = (char *)sqlite3_column_text(statement, 2);
            Note *note = [[Note alloc]init];
            note.tag = tag;
            note.detail = [[NSString alloc]initWithCString:details encoding:NSUTF8StringEncoding];
            note.dateTime = [[NSString alloc]initWithCString:thedatetime encoding:NSUTF8StringEncoding];
            NSLog(@"tag:%d,detail:%@,datetime:%@",tag,note.detail,note.dateTime);
            [notes addObject:note];
            //根据tag获得TextField
            //UITextField *textField = (UITextField *)[self.view viewWithTag:tag];
            // 设置文本
            //textField.text = [[NSString alloc] initWithUTF8String:rowData];
        }
        sqlite3_finalize(statement);
    }
    //关闭数据库
    sqlite3_close(database);
    //刷新一下tableView
    [_notesTableView reloadData];
}

- (Note *)selectNotebyTag:(int)tag{
    //打开数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"打开数据库失败！");
    }
    Note *note = [[Note alloc] init];
    char *sql = "SELECT TAG,DETAILS,THEDATETIME FORM NOTES WHERE TAG = ?;";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            sqlite3_bind_int(stmt, 1, tag);
            int tag = sqlite3_column_int(stmt, 0);
            char *details = (char*)sqlite3_column_text(stmt, 1);
            char *dateTime = (char*)sqlite3_column_text(stmt, 2);
            note.tag = tag;
            note.detail = [[NSString alloc]initWithCString:details encoding:NSUTF8StringEncoding];
            note.dateTime = [[NSString alloc]initWithCString:dateTime encoding:NSUTF8StringEncoding];
        }
    }
    sqlite3_close(database);
    return note;
}

- (void)deleteNoteByTag:(int)tag{
    //打开数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"打开数据库失败！");
    }
    sqlite3_stmt *stmt;
    char *sql = "DELETE FROM NOTES where tag = ?";
    if (sqlite3_prepare_v2(database, sql, -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, tag);
        if (sqlite3_step(stmt) == SQLITE_ERROR) {
            NSLog(@"Error: failed to delete the database with message.");
            //关闭数据库
            sqlite3_close(database);
        }
    }
    sqlite3_close(database);
    [_notesTableView reloadData];
}

//通过Segue传递TableView中的数据
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showNoteDetailsSegue"]) {
        NSIndexPath *indexPath = [self.notesTableView indexPathForSelectedRow];
        ShowNoteViewController *showNoteViewController = segue.destinationViewController;
        showNoteViewController.note = [notes objectAtIndex:indexPath.row];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [notes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell"];
    Note *note = [notes objectAtIndex:indexPath.row];
    cell.textLabel.text = [[NSString alloc]initWithString:note.detail];
    cell.detailTextLabel.text = note.dateTime;
    // Configure the cell...
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        Note *note = [notes objectAtIndex:indexPath.row];
        [self deleteNoteByTag:note.tag];
        [notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
