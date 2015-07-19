//
//  MasterViewController.m
//  MyNotes
//
//  Created by lzx on 24/11/14.
//  Copyright (c) 2014年 lzx. All rights reserved.//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MyTableViewCell.h"
#import "MainScene.h"
#import "MyModeldata.h"
#import <sqlite3.h>
@interface MasterViewController ()

@property NSMutableArray *objects;
@end
NSMutableArray * array;
NSIndexPath * tmpindexpath;
@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(NSString * )dataFilePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return [path stringByAppendingString:@"datass.sqlite"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     array = [[NSMutableArray alloc] init];
    self.tableView.rowHeight = 70;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    // 读取数据库获得数据源
    //创建数据库
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    //创建表格
    NSString * createSql =  @"CREATE TABLE IF NOT EXISTS FIELDS(ID INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,contentData BLOB,time TEXT,type INTEGER)";
    char * errormsg;
    
    if (sqlite3_exec(database, [createSql UTF8String], NULL, NULL, &errormsg)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table :%s",errormsg);
    }

    NSString *querySql = @"SELECT title,contentData,time,type from FIELDS";
    sqlite3_stmt * statement = nil;
    if (sqlite3_prepare_v2(database, [querySql UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statement)==SQLITE_ROW)
        {
            MyModeldata * modeldata = [[MyModeldata alloc] init];
            modeldata.title = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 0)];
            int lens = sqlite3_column_bytes(statement, 1);
            modeldata.contentdata = [NSData dataWithBytes:sqlite3_column_blob(statement, 1) length:lens];
            
            modeldata.time = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
            modeldata.type = sqlite3_column_int(statement, 3);
            if (modeldata.type!=4)
            {
                NSMutableString * mutablestring = [[NSMutableString alloc] init];
                [mutablestring appendString:modeldata.title];
                [mutablestring appendString:@" "];
                [mutablestring appendString:modeldata.time];
                modeldata.title = mutablestring;
            }
            switch (modeldata.type)
            {
                case 1:
                    modeldata.subtitle = @"类型：手绘";
                    break;
                case 2:
                    modeldata.subtitle = @"类型：录音";
                    break;
                case 3:
                    modeldata.subtitle = @"类型：拍照";
                    break;
                case 4:
                    modeldata.subtitle = @"类型：提醒";
                    break;
                case  5:
                    modeldata.subtitle = @"类型：文字";
                    break;
                default:
                    break;
            }
            [array addObject:modeldata];
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    //通过storyboard加载mainscene视图
    UIStoryboard * board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainScene * mainscene = [board instantiateViewControllerWithIdentifier:@"mainsceneController"];
    
    [self.navigationController pushViewController:mainscene animated:YES];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//       NSDate *object = self.objects[indexPath.row];
        MyModeldata * data = array[indexPath.row];
        [[segue destinationViewController] setValue:data forKey:@"modeldata"];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * indefinder = @"Cell";
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indefinder forIndexPath:indexPath];
    if (cell ==nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indefinder];
    }
    MyModeldata * modeldata = array[indexPath.row];
    
    cell.cellTitle.text =modeldata.title;
    cell.cellSubTitle.text = modeldata.subtitle;
    UIImage * image;
    switch (modeldata.type) {
        case 1:
            image = [UIImage imageNamed:@"write"];
            break;
        case 2:
            image = [UIImage imageNamed:@"record"];
            break;
        case 3:
            image = [UIImage imageNamed:@"camera"];
            break;
        case 4:
            image = [UIImage imageNamed:@"alarm"];
            break;
        case 5:
            image = [UIImage imageNamed:@"text"];
            break;
        default:
            break;
    }
    if (modeldata.type==1) {
        image = [UIImage imageWithData:modeldata.contentdata];
    }
    cell.cellImage.image = image;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}



-(void)viewDidAppear:(BOOL)animated
{
    NSMutableArray * tmparray = [[NSMutableArray alloc] init];
    //创建数据库
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    //创建表格
    NSString * createSql = @"CREATE TABLE IF NOT EXISTS FIELDS(ID INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,contentData BLOB,time TEXT,type INTEGER)";
    char * errormsg;
    
    if (sqlite3_exec(database, [createSql UTF8String], NULL, NULL, &errormsg)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table :%s",errormsg);
    }
    
    
    NSString *querySql = @"SELECT title,contentData,time,type from FIELDS";
    sqlite3_stmt * statement = nil;
    if (sqlite3_prepare_v2(database, [querySql UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statement)==SQLITE_ROW)
        {
            MyModeldata * modeldata = [[MyModeldata alloc] init];
            modeldata.title = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 0)];
            int lens = sqlite3_column_bytes(statement, 1);
            modeldata.contentdata = [NSData dataWithBytes:sqlite3_column_blob(statement, 1) length:lens];
            
            modeldata.time = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
            modeldata.type = sqlite3_column_int(statement, 3);
            if (modeldata.type!=4)
            {
                NSMutableString * mutablestring = [[NSMutableString alloc] init];
                [mutablestring appendString:modeldata.title];
                [mutablestring appendString:@" "];
                [mutablestring appendString:modeldata.time];
                modeldata.title = mutablestring;
            }
            switch (modeldata.type)
            {
                case 1:
                    modeldata.subtitle = @"手绘";
                    break;
                case 2:
                    modeldata.subtitle = @"录音";
                    break;
                case 3:
                    modeldata.subtitle = @"拍照";
                    break;
                case 4:
                    modeldata.subtitle = @"提醒";
                    break;
                case  5:
                    modeldata.subtitle = @"文字";
                    break;
                default:
                    break;
            }
            [tmparray addObject:modeldata];
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    array = tmparray;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //用来处理选中的行获得要传递的数值
    tmpindexpath = indexPath;
    
}

@end
