//
//  MasterViewController.m
//  Note
//
//  Created by Mac on 14-11-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "NoteRecord.h"
#import "Scrawl.h"
#import "Image.h"

#import <sqlite3.h>
#import "DBHelper.h"

@interface MasterViewController () {
    NSMutableArray *data;
    NSArray *identity;

}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(NSMutableArray *)queryNoteRecords
{//查找所有文字笔记
    NSMutableArray *records;
    sqlite3 *database = [DBHelper getDatabase];
    NSString *querySQL = @"select row,topic,content from notes order by row";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [querySQL UTF8String], -1,&statement, nil)==SQLITE_OK){
        while(sqlite3_step(statement)==SQLITE_ROW){
            NoteRecord *record=[[NoteRecord alloc]init];
            record.row=sqlite3_column_int(statement,0);
            record.topicStr=[NSString stringWithFormat:@"%s", (char *)sqlite3_column_text(statement, 1)];
            record.contentStr=[NSString stringWithFormat:@"%s",  (char *)sqlite3_column_text(statement, 2)];
            if (!records) {
                records = [[NSMutableArray alloc] init];
            }
            [records insertObject:record atIndex:0];
        }
        sqlite3_finalize(statement);
    }
    [DBHelper closeDatabase:database];
    return records;
}

-(NSMutableArray *)queryScrawls
{//查找所有涂鸦
    NSMutableArray *scrawls;
    sqlite3 *database = [DBHelper getDatabase];
    NSString *querySQL = @"select row,topic,binScrawl from scrawl order by row";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [querySQL UTF8String], -1,&statement, nil)==SQLITE_OK){
        while(sqlite3_step(statement)==SQLITE_ROW){
            Scrawl *scrawl=[[Scrawl alloc]init];
            scrawl.row=sqlite3_column_int(statement,0);
            scrawl.topicStr=[NSString stringWithFormat:@"%s", (char *)sqlite3_column_text(statement, 1)];
            char *source = (char *)sqlite3_column_blob(statement, 2);
            int bytes = sqlite3_column_bytes(statement, 2);
            scrawl.binScrawl= [NSData dataWithBytes:source length:bytes];
            if (!scrawls) {
                scrawls = [[NSMutableArray alloc] init];
            }
            [scrawls insertObject:scrawl atIndex:0];
        }
        sqlite3_finalize(statement);
    }
    [DBHelper closeDatabase:database];
    return scrawls;
}


-(NSMutableArray *)queryImages
{//查找所有涂鸦
    NSMutableArray *images;
    sqlite3 *database = [DBHelper getDatabase];
    NSString *querySQL = @"select row,topic,binImage from image order by row";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [querySQL UTF8String], -1,&statement, nil)==SQLITE_OK){
        while(sqlite3_step(statement)==SQLITE_ROW){
            Image *image=[[Image alloc]init];
            image.row=sqlite3_column_int(statement,0);
            image.topicStr=[NSString stringWithFormat:@"%s", (char *)sqlite3_column_text(statement, 1)];
            char *source = (char *)sqlite3_column_blob(statement, 2);
            int bytes = sqlite3_column_bytes(statement, 2);
            image.binImage= [NSData dataWithBytes:source length:bytes];
            if (!images) {
                images = [[NSMutableArray alloc] init];
            }
            [images insertObject:image atIndex:0];
        }
        sqlite3_finalize(statement);
    }
    [DBHelper closeDatabase:database];
    return images;
}


-(void)initDataSource
{//准备表格数据
     NSMutableArray *records = [self queryNoteRecords];
     NSMutableArray *scrawls =[self queryScrawls];
     NSMutableArray *images =[self queryImages];
    if(data==nil){
        data=[[NSMutableArray alloc ]init];
    }
    NSUInteger i=0;
    if(records!=nil)
       [data insertObject:records atIndex:i++];
    if(scrawls!=nil)
       [data insertObject:scrawls atIndex:i++];
    if(images!=nil)
       [data insertObject:images atIndex:i++];
    
    identity=[NSArray arrayWithObjects:@"Cell",@"secondCell",@"imageCell",nil];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self initDataSource];
 
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [data removeAllObjects];
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *temp = data[section];
    return [temp count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *flag = identity[indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag  forIndexPath:indexPath];
    
    NoteRecord *record = data[indexPath.section][indexPath.row];
    cell.textLabel.text = record.topicStr;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"noteDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NoteRecord *record = data[indexPath.section][indexPath.row];
        [[segue destinationViewController] setDetailItem:record];
    }else if([[segue identifier] isEqualToString:@"scrawlDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Scrawl *scrawl = data[indexPath.section][indexPath.row];
        [[segue destinationViewController] setDetailItem:scrawl];
    }else if([[segue identifier] isEqualToString:@"imageDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Image *image = data[indexPath.section][indexPath.row];
        [[segue destinationViewController] setDetailItem:image];
    }
   
}

- (IBAction)deleAllRecord:(UIBarButtonItem *)sender {
    
    sqlite3 *database = [DBHelper getDatabase];
    NSString *deleteSQL = @"delete from notes";
    [DBHelper updateDatabase:deleteSQL];
    
    
    deleteSQL = @"delete from scrawl";
    [DBHelper updateDatabase:deleteSQL];

    deleteSQL = @"delete from image";
    [DBHelper updateDatabase:deleteSQL];
    
    [DBHelper closeDatabase:database];
    [data removeAllObjects];
    [self.tableView reloadData];
    
}
@end
