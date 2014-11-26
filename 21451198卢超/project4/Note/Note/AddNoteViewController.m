//
//  AddNoteViewController.m
//  Note
//
//  Created by jiaoshoujie on 14-11-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AddNoteViewController.h"
#import "sqlite3.h"
#define kDatabaseName @"database.sqlite3"

@interface AddNoteViewController ()

@end

@implementation AddNoteViewController

@synthesize databaseFilePath;
@synthesize rightButon;

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
}

//关闭键盘
- (IBAction)backgroundTap:(id)sender {
    [_textView resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNoteAction:(id)sender {
    //UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏右按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //[alter show];
    NSString *title = [[NSString alloc] initWithCString:"完成" encoding:NSUTF8StringEncoding];
    NSLog(@"title:%@,rightButton:%@",title,rightButon.title);
    NSLog(@"textView:%@",_textView.text);
    if ([title isEqualToString:rightButon.title]&&![[[NSString alloc]initWithCString:"" encoding:NSUTF8StringEncoding]isEqualToString:_textView.text] ) {
        [self insertIntoDatabase];
        [rightButon setTitle:@"添加"];
        _textView.text = nil;
    }else{
        [rightButon setTitle:@"完成"];
    }
}

-(void)insertIntoDatabase{
    //打开数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"打开数据库失败！");
    }
    int last = [self lastTagofNotes];
    //使用约束变量插入数据
    char *update = "INSERT OR REPLACE INTO NOTES (TAG, DETAILS, THEDATETIME) VALUES (?,?,?);";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, update, -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, last+1);
        sqlite3_bind_text(stmt, 2, [_textView.text UTF8String], -1, NULL);
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

-(int)lastTagofNotes{
    //打开数据库
    sqlite3 *database;
    if (sqlite3_open([self.databaseFilePath UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"打开数据库失败！");
    }
    int lastTag = 0;
    char *update = "SELECT MAX(TAG) FROM NOTES";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, update, -1, &stmt, nil) == SQLITE_OK){
        while (sqlite3_step(stmt)==SQLITE_ROW){
            lastTag = sqlite3_column_int(stmt, 0);
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    
    return lastTag;
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
