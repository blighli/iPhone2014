//
//  ViewController.m
//  Project4
//
//  Created by xvxvxxx on 14/11/20.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//
#define tableViewCellIdetifier @"tableViewCellIdetifier"
#import "ViewController.h"

@interface ViewController (){
    NSMutableArray *noteList;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingString:@"/myDatabase.sqlite"];
    NSLog(@"%@",database_path);
    self.db = [FMDatabase databaseWithPath:database_path];
    if (![self.db open]) {
        [self.db close];
        NSLog(@"database open failed--ViewController");
        return;
    }
    NSLog(@"database open successful--ViewController");
    NSString *sql_creat = @"create table if not exists notes (id integer primary key autoincrement, notetitle text, content text, photo text, picture text, datetime text)";
    [self.db executeUpdate:sql_creat];
    [self initTableviewData];
    //        NSLog(@"1");
    }


-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [self initTableviewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableviewData{
    [noteList removeAllObjects];
    noteList = [NSMutableArray array];
    NSString *sql_list = @"select * from notes order by id desc";
    FMResultSet *resultSet = [self.db executeQuery:sql_list];
    while ([resultSet next]) {
        Note *note = [[Note alloc]init];
        note.ID = [resultSet intForColumnIndex:0];
        note.notetitle = [resultSet stringForColumnIndex:1];
        note.content = [resultSet stringForColumnIndex:2];
        note.photo = [resultSet stringForColumnIndex:3];
        note.picture = [resultSet stringForColumnIndex:4];
        note.datetime = [resultSet stringForColumnIndex:5];
        [noteList addObject:(Note*)note];

}
}


#pragma datasource& delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSInteger total = 0;
//    NSString *sql = @"select count(*) from notes";
//    FMResultSet *resultSet = [self.db executeQuery:sql];
//    if ([resultSet next]) {
//        total = [resultSet intForColumnIndex:0];
//    }
//    
//    NSLog(@"numberOfRowsInSection:%ld--ViewController",(long)total);
    return [noteList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdetifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableViewCellIdetifier];
    }
    Note *note = [noteList objectAtIndex:indexPath.row];
    cell.textLabel.text = note.notetitle;
    cell.detailTextLabel.text = note.datetime;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"add"]) {
        [segue.destinationViewController setValue:nil forKey:@"note"];
    }
    else if([segue.identifier isEqualToString:@"detail"]){
        NSIndexPath *indexpath = [self.tableView indexPathForCell:sender];
        Note *note = [noteList objectAtIndex:indexpath.row];
        [segue.destinationViewController setValue:note forKey:@"note"];
//        [segue.destinationViewController setValue:@"test" forKey:@"test"];
    }
    [segue.destinationViewController setValue:self.db forKey:@"db"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Note *note = [noteList objectAtIndex:indexPath.row];
//    [self performSegueWithIdentifier:@"detail" sender:note];
}
@end
