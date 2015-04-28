//
//  SecondViewController.m
//  translation
//
//  Created by Steve on 14-12-24.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"Dictionary"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    tasks = [[NSMutableArray alloc] init];
    tableview.delegate=self;
    tableview.dataSource=self;
    NSString *sqlQuery = @"SELECT * FROM WORD";
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        int i=0;
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int no=(int)sqlite3_column_int(statement, 0);
            char *en = (char*)sqlite3_column_text(statement, 1);
            NSString *nsen = [[NSString alloc]initWithUTF8String:en];
             No[i++]=no;
            [tasks addObject:nsen];
        }
    }
    sqlite3_close(db);
    [tableview reloadData];


    // Do any additional setup after loading the view, typically from a nib.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    index=indexPath.row;
//    NSString *taskselect=[tasks objectAtIndex:indexPath.row];
    num=No[index];
    NextView=[[WordViewController alloc]init];
    UIStoryboard* mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NextView=[mainStoryboard instantiateViewControllerWithIdentifier:@"word"];
    [self.navigationController pushViewController:NextView animated:YES];

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
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"Cell"]; if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]]; [[cell textLabel] setText:item];
    return cell ;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
