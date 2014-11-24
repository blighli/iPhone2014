//
//  guoViewController.m
//  MyNotes
//
//  Created by cstlab on 14/11/21.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "guoViewController.h"
#import "detailViewController.h"
#import <sqlite3.h>
#import "Modeldata.h"
#import "CellDetailViewController.h"
@interface guoViewController ()

@end
//NSArray * contentarray;
NSMutableArray *contentarray;
@implementation guoViewController
-(NSString*)dataFilePath
{
    
    NSString *DocuMentDir;
    NSArray  *DirPath;
    
    DirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    DocuMentDir = [DirPath objectAtIndex:0];
   // NSLog(@"DocuMentDir-------:%@",DocuMentDir);
    
    return [DocuMentDir stringByAppendingPathComponent:@"Memos.sqlite"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"备忘录";

    NSMutableArray * array = [[NSMutableArray alloc] init];
    sqlite3 *MemoDB;
    if (sqlite3_open([[self dataFilePath]UTF8String], &MemoDB)!=SQLITE_OK) {
        NSLog(@"Failed to Create The Memo Database !");
        sqlite3_close(MemoDB);
        
    }else
    {
       // NSLog(@"Success to Create Memo Database !");
    }
    NSString * sql_select = @"SELECT Title,Messages FROM MemoTexts;";
    sqlite3_stmt * statment ;
    if (sqlite3_prepare_v2(MemoDB, [sql_select UTF8String], -1, &statment, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statment)==SQLITE_ROW) {
            char * title = (char *)sqlite3_column_text(statment, 0);
            char * message =(char *)sqlite3_column_text(statment, 1);
            if (title!=NULL) {
                Modeldata * data = [[Modeldata alloc] init];
                data.title= [NSString stringWithFormat:@"%s",title];
                data.messsages = [NSString stringWithFormat:@"%s",message];
                [array addObject:data];
            }
        }
        sqlite3_finalize(statment);
    }
    sqlite3_close(MemoDB);
    contentarray = array;
    UIBarButtonItem * items = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickbutton:)];
    self.navigationItem.rightBarButtonItem = items;

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)clickbutton:(UIButton *)sender {
    detailViewController * controller = [[detailViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contentarray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indefinder = @"indefinders";
    UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:indefinder];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indefinder];
    }
    Modeldata *data = contentarray[indexPath.row];
    cell.textLabel.text = data.title;
    return cell;
}

-(void)viewDidAppear:(BOOL)animated
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    sqlite3 *MemoDB;
    if (sqlite3_open([[self dataFilePath]UTF8String], &MemoDB)!=SQLITE_OK) {
        NSLog(@"Failed to Create The Memo Database !");
        sqlite3_close(MemoDB);
        
    }else
    {
       // NSLog(@"Success to Create Memo Database !");
    }
    NSString * sql_select = @"SELECT ID,Title,Messages FROM MemoTextss;";
    sqlite3_stmt * statment ;
    if (sqlite3_prepare_v2(MemoDB, [sql_select UTF8String], -1, &statment, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statment)==SQLITE_ROW) {
            int id = sqlite3_column_int(statment, 0);
            char * title = (char *)sqlite3_column_text(statment, 1);
            char * message =(char *)sqlite3_column_text(statment, 2);
            if (title!=NULL) {
                Modeldata * data = [[Modeldata alloc] init];
                data.id = id;
                data.title= [NSString stringWithFormat:@"%s",title];
                data.messsages = [NSString stringWithFormat:@"%s",message];
                [array addObject:data];
            }
        }
        sqlite3_finalize(statment);
    }
    sqlite3_close(MemoDB);
    contentarray = array;
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellDetailViewController * cellcontroller = [[CellDetailViewController alloc] init];
    cellcontroller.data = contentarray[indexPath.row];
    [self.navigationController pushViewController:cellcontroller animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        Modeldata *data = contentarray[indexPath.row];
        [contentarray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"the row is %lu",indexPath.row);
        sqlite3 *MemoDB;
        if (sqlite3_open([[self dataFilePath]UTF8String], &MemoDB)!=SQLITE_OK) {
            NSLog(@"Failed to Create The Memo Database !");
            sqlite3_close(MemoDB);
            
        }else
        {
            // NSLog(@"Success to Create Memo Database !");
        }
        sqlite3_stmt * statament;
        NSString * sql_delete = @"DELETE FROM MemoTextss WHERE ID=?";
        if (sqlite3_prepare_v2(MemoDB, [sql_delete UTF8String], -1, &statament, nil)==SQLITE_OK) {
            sqlite3_bind_int(statament, 1, data.id);
        }
        if (sqlite3_step(statament)!=SQLITE_DONE) {
            NSLog(@"删除失败");
        }else
        {
            NSMutableArray * array = [[NSMutableArray alloc] init];
            sqlite3_finalize(statament);
            NSString * sql_select = @"SELECT ID,Title,Messages FROM MemoTextss;";
            sqlite3_stmt * stats ;
            if (sqlite3_prepare_v2(MemoDB, [sql_select UTF8String], -1, &stats, nil)==SQLITE_OK)
            {
                while (sqlite3_step(stats)==SQLITE_ROW) {
                    int id = sqlite3_column_int(stats, 0);
                    char * title = (char *)sqlite3_column_text(stats, 1);
                    char * message =(char *)sqlite3_column_text(stats, 2);
                    if (title!=NULL) {
                        Modeldata * data = [[Modeldata alloc] init];
                        data.id = id;
                        data.title= [NSString stringWithFormat:@"%s",title];
                        data.messsages = [NSString stringWithFormat:@"%s",message];
                        [array addObject:data];
                    }
                }
                sqlite3_finalize(stats);
            }
            sqlite3_close(MemoDB);
            contentarray = array;
            array =nil;
            [self.tableView reloadData];
        }
        sqlite3_close(MemoDB);
    }
}

@end
