//
//  ShowNoteViewController.m
//  Note
//
//  Created by jiaoshoujie on 14-11-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ShowNoteViewController.h"
#import "sqlite3.h"

#define kDatabaseName @"database.sqlite3"

@interface ShowNoteViewController ()

@end

@implementation ShowNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //获取数据库文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.databaseFilePath = [documentsDirectory stringByAppendingPathComponent:kDatabaseName];
    [self showNoteDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showNoteDetails{
    self.noteTextView.text = self.note.detail;
    self.noteNavItem.title = self.note.detail;
    self.noteDateLabel.text = self.note.dateTime;
}


- (IBAction)updateNotesAction:(id)sender {
    [self updateNote];
}

//关闭键盘
- (IBAction)backgroundTap:(id)sender {
    [_noteTextView resignFirstResponder];
}

- (void)updateNote{
    //打开数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"打开数据库失败！");
    }
    //使用约束变量插入数据
    char *update = "INSERT OR REPLACE INTO NOTES (TAG, DETAILS, THEDATETIME) VALUES (?,?,?);";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, update, -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, self.note.tag);
        sqlite3_bind_text(stmt, 2, [_noteTextView.text UTF8String], -1, NULL);
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];
        NSString* str = [formatter stringFromDate:date];
        NSLog(@"现在时间是：%@",str);
        sqlite3_bind_text(stmt, 3, [str UTF8String], -1, NULL);
    }
    char *errorMsg = NULL;
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        NSAssert(0, @"更新数据库表FIELDS出错：%s",errorMsg);
    }
    sqlite3_finalize(stmt);
    //关闭数据库
    sqlite3_close(database);
}

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
