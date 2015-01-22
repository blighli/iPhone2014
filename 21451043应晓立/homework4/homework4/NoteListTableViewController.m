//
//  NoteListTableViewController.m
//  homework4
//
//  Created by yingxl1992 on 14/11/15.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "NoteListTableViewController.h"

#define DBNAME @"Notelist.sqlite"

@interface NoteListTableViewController ()

@end

@implementation NoteListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    noteDB=[[NoteDB alloc]init];
    database=[noteDB getDB];
    alldata=nil;
    [self getAllData];
    [_tableview reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //设置了删除之后，查看详情无法点击
//    [self.tableView setEditing:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    alldata=nil;
    [self getAllData];
    [_tableview reloadData];
}
//
//- (void)executeSQLOper:(NSString *)sql {
//    char *error;
//    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &error) != SQLITE_OK) {
//        sqlite3_close(database);
//        NSLog(@"数据库操作数据失败!+%s",error);
//    }
//}

//-(sqlite3_stmt *)executeSQLQuery:(NSString *)sql {
//    sqlite3_stmt *statement;
//    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
//        return statement;
//    }
//    NSLog(@"数据库获取数据失败!");
//    return nil;
//}

- (void)getAllData {
    NSString *sql=@"SELECT * FROM NOTELIST";
    sqlite3_stmt *statement=[noteDB executeSQLQuery:sql];
    NoteList *list=nil;
    alldata=nil;
    alldata=[[NSMutableArray alloc]init];
    while (sqlite3_step(statement)==SQLITE_ROW) {
        list=[[NoteList alloc]init];
        list.Id=sqlite3_column_int(statement, 0);
        list.addtime=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 1)];
        list.title=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
        list.content=[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
        
        const void *op = sqlite3_column_blob(statement,4);
        int size = sqlite3_column_bytes(statement,4);
        list.image = [[NSData alloc]initWithBytes:op length:size];

        [alldata addObject:list];
        list=nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [alldata count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noteItemCell" forIndexPath:indexPath];
    NoteList *list=[alldata objectAtIndex:indexPath.row];
    cell.textLabel.text=list.title;
    cell.detailTextLabel.text=list.addtime;
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self performSegueWithIdentifier:@"showDetailSegue" sender:self];
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteFromDB:[alldata objectAtIndex:indexPath.row]];
        [alldata removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }    
    [_tableview reloadData];
}

- (void)deleteFromDB:(NoteList *)term {
    NSString *sql=[NSString stringWithFormat: @"DELETE FROM NOTELIST WHERE ID= %ld",term.Id];
    [noteDB executeSQLOper:sql];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NoteDetailViewController *detailController = segue.destinationViewController;
    NSIndexPath *selectIndexPath = [self.tableView indexPathForSelectedRow];
    [detailController setCurrentNotelist:[alldata objectAtIndex:selectIndexPath.row]];
}

@end
