//
//  Shouxie.m
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-23.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChakanZhaopian.h"
#import "ChakanWenzi.h"
#import "ChakanShouxie.h"
#import "Constants.h"
#import <sqlite3.h>
#import "MySqlite3DbHelper.h"

#import "Shouxie.h"
@implementation Shouxie





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"]
        ;
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    
    OnePiece * current = [arrayOnePiece objectAtIndex:[indexPath row]];
    //设置单元格内容
    [[cell textLabel]setText:[current valueForKey:@"title"]];
    
    return cell ;
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger i =[arrayOnePiece count];
    return i;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [talbeView setDelegate:self];
    [talbeView setDataSource:self];
    
    NSLog(@"view load");
    arrayOnePiece = [[NSMutableArray alloc] init ];
    //读取XiaoBenZi.db中contents表的内容
    [self querySql:@"select id,title,type,info from contents where type =\"2\"" database:@"XiaoBenZi_1087.db"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    arrayOnePiece = [[NSMutableArray alloc] init ];
    //读取XiaoBenZi.db中contents表的内容
    [self querySql:@"select id,title,type,info from contents where type =\"2\"" database:@"XiaoBenZi_1087.db"];
    [talbeView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selection");
    //ChakanWenzi * controller=[ [ChakanWenzi alloc ]init ];
    //ChakanWenzi * controller = [[ChakanWenzi alloc]init];
    
    //从storyboard中找到界面
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle] ];
    
    //判断条目的类型，是文字还是照片还是手写
    //当前条目
    OnePiece * current = [arrayOnePiece objectAtIndex:[indexPath row]];
    //判断当前条目的type是0还是1还是2
    //设置小标题
    NSString* temp = [current valueForKey:@"type"];
    if( [temp isEqualToString:@"0"]==YES )//文字
    {
        //找到view
        ChakanWenzi *vC= [ story instantiateViewControllerWithIdentifier:@"ChakanWenzi"];
        //传递值whopastit:1表示是查看
        [Constants setWhoPastit:0];
        //传递值：当前条目的OnePiece
        [Constants setPastOnePiece:current];
        
        //进入下一页
        [[self navigationController] pushViewController:vC animated:YES];
    }
    else if( [temp isEqualToString:@"1"]==YES )//照片
    {
        //找到view
        ChakanZhaopian *vC= [ story instantiateViewControllerWithIdentifier:@"ChakanZhaopian"];
        //传递值whopastit:0表示是查看
        [Constants setWhoPastit:0];
        //传递值：当前条目的OnePiece
        [Constants setPastOnePiece:current];
        
        //进入下一页
        [[self navigationController] pushViewController:vC animated:YES];
    }
    else//手写
    {
        //找到view
        ChakanShouxie *vC= [ story instantiateViewControllerWithIdentifier:@"ChakanShouxie"];
        //传递值whopastit:0表示是查看
        [Constants setWhoPastit:0];
        //传递值：当前条目的OnePiece
        [Constants setPastOnePiece:current];
        
        //进入下一页
        [[self navigationController] pushViewController:vC animated:YES];
    }
    
    
    
    
    
    
}


-(BOOL)querySql:(NSString *)sql database:(NSString *)databaseName
{
    sqlite3 * contactDB;
    sqlite3_stmt *statement;
    @try {
        NSString * databasePath = [MySqlite3DbHelper dbPathforDbName:databaseName];
        const char *dbpath = [databasePath UTF8String];
        
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            NSString *querySQL = sql;//[NSString stringWithFormat:@"SELECT address,phone from contacts where name=\"%@\"",name.text];
            const char *query_stmt = [querySQL UTF8String];
            NSLog(@"sql:%s",query_stmt);
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, nil) == SQLITE_OK)
            {
                NSLog(@"ok");
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    OnePiece * one = [[OnePiece alloc] init];
                    
                    //获取id，title，type，info
                    NSString* temp =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    [one setValue:temp forKey:@"iD"];
                    
                    temp =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    [one setValue:temp forKey:@"title"];
                    temp =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    [one setValue:temp forKey:@"type"];
                    temp =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                    [one setValue:temp forKey:@"info"];
                    
                    [arrayOnePiece addObject:one];
                }
                
                sqlite3_finalize(statement);
            }
            
            sqlite3_close(contactDB);
        }
        
        return YES;
    }
    @catch( NSException* ex)
    {
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
        return NO;
    }
}

@end
