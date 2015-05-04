//
//  SecondViewController.m
//  Note
//
//  Created by Steve on 14-11-23.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()


@end


@implementation SecondViewController
#define DBNAME    @"personinfo.sqlite"
#define NAME      @"name"
#define AGE       @"age"
#define ADDRESS   @"address"
#define TABLENAME @"PERSONINFO"
-(void)Create
{
   flag=1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag=0;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"Note"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS Note (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, content TEXT)";
    [self execSql:sqlCreateTable];

    tasks = [[NSMutableArray alloc] init];
    TableView.delegate=self;
    TableView.dataSource=self;
    NSString *sqlQuery = @"SELECT * FROM Note";
    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        int i=0;
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int no=(int)sqlite3_column_int(statement, 0);
            char *name = (char*)sqlite3_column_text(statement, 1);
            NSString *nsNameStr = [[NSString alloc]initWithUTF8String:name];
            No[i++]=no;
            [tasks addObject:nsNameStr];
        }
    }
    sqlite3_close(db);
    [TableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self viewDidLoad];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    index=indexPath.row;
    NSString *taskselect=[tasks objectAtIndex:indexPath.row];
    myAlertView =[[UIAlertView alloc]initWithTitle:@"删除或修改选中项" message:taskselect delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"edit",@"delete",nil];
    [myAlertView show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"Note"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }int no=index;
    if(buttonIndex==0){
        return;
    }
    else if(buttonIndex==1)
    {
        NextView=[[NoteViewController alloc]init];
        UIStoryboard* mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NextView=[mainStoryboard instantiateViewControllerWithIdentifier:@"NoteView"];
        num=No[no];
        [self.navigationController pushViewController:NextView animated:NO];

    }
    else
    {

       
        NSString *Sql=[NSString stringWithFormat:@"DELETE FROM Note WHERE ID = '%d'",No[no]];
        [self execSql:Sql];
        [self viewDidLoad];
        NSLog(@"1111111");
    }
    sqlite3_close(db);
}


-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [TableView dequeueReusableCellWithIdentifier:@"Cell"]; if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]]; [[cell textLabel] setText:item];
    return cell ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
