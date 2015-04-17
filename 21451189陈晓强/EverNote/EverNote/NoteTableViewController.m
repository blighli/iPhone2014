//
//  NoteTableViewController.m
//  EverNote
//
//  Created by 陈晓强 on 14/11/29.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "NoteTableViewController.h"
#import "ViewController.h"
#import <sqlite3.h>
#import "MySqlite.h"
@interface NoteTableViewController ()

@property (nonatomic) sqlite3 *database;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (strong, nonatomic) NSDictionary *dict;

@end


@implementation NoteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"Cancle";
    self.navigationItem.backBarButtonItem = backItem;
    _titleArray = [NSMutableArray array];
    _dataDict = [NSMutableDictionary dictionary];
    _dict = @{NSDocumentTypeDocumentAttribute:NSRTFDTextDocumentType};
    
}

- (void)searchSql
{
    [_titleArray removeAllObjects];
    [_dataDict removeAllObjects];
    MySqlite *sqliteHandle = [[MySqlite alloc] init];
    [sqliteHandle openDatabase:&_database];
    NSString *query = @"SELECT ROW,NOTE_TITLE,NOTE_DATA FROM NOTES ORDER BY ROW";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *titleData = (char *)sqlite3_column_text(statement, 1);
            int bytes = sqlite3_column_bytes(statement, 2);
            const void *rowData = (char *)sqlite3_column_blob(statement, 2);
            NSData *data = [NSData dataWithBytes:rowData length:bytes];
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:data options:_dict documentAttributes:Nil error:Nil];
            NSString *title = [[NSString alloc]initWithUTF8String:titleData];
            [_titleArray addObject:title];
            [_dataDict setValue:attributedString forKey:title];
        }
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [self searchSql];
    [self.tableView reloadData];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.titleArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = _titleArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static char *sql = "delete from notes  where NOTE_TITLE = ?";
    MySqlite *sqliteHandle = [[MySqlite alloc] init];
    [sqliteHandle openDatabase:&_database];
    sqlite3_stmt *statement;
    int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
    if (success != SQLITE_OK) {
        NSLog(@"Error: failed to delete:testTable");
        sqlite3_close(_database);
    }
    sqlite3_bind_text(statement, 1, [[_titleArray objectAtIndex:indexPath.row] UTF8String], -1, SQLITE_TRANSIENT);

    success = sqlite3_step(statement);
     sqlite3_finalize(statement);
    if (success == SQLITE_ERROR) {
        NSLog(@"Error: failed to delete the database with message.");
        //关闭数据库
        sqlite3_close(_database);
    }
    //执行成功后依然要关闭数据库
    sqlite3_close(_database);
    [_titleArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:
     UITableViewRowAnimationAutomatic];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if ([segue.destinationViewController isKindOfClass:[ViewController class]]) {
        ViewController *controller = (ViewController *)segue.destinationViewController;
        controller.myAttributedString = [_dataDict objectForKey:cell.textLabel.text];
        controller.myTitle = cell.textLabel.text;
    }
}


@end
