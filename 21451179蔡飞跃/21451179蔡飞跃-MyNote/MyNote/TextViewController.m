//
//  TextViewController.m
//  MyNote
//
//  Created by 蔡飞跃 on 14/11/15.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController
@synthesize text_title;
@synthesize text_note;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    text_title=[[UITextField alloc] init];
    text_note=[[UITextView alloc] init];
    
    //根据路径创建数据库并创建一个表
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"text.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath:databasePath] == NO)
    {
        //创建数据库
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &textDB)==SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS TEXTS(ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT, CONTENT TEXT)";
            if (sqlite3_exec(textDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
            {
                NSLog(@"创建表1失败\n");
            }
            else
            {
                NSLog(@"创建表1成功\n");
            }
        }
        else
        {
            NSLog(@"创建/打开数据库失败\n");
            //status.text = @"创建/打开数据库失败";
        }

    }

    // Do any additional setup after loading the view.
}


- (IBAction)save:(id)sender {
    sqlite3_stmt *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &textDB)==SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO TEXTS (title,content) VALUES(\"%@\",\"%@\")",text_title.text,text_note.text];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(textDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement)==SQLITE_DONE) {
            NSLog(@"已存储到数据库\n");
            text_title.text = @"";
            text_note.text = @"";
        }
        else
        {
            NSLog(@"保存失败\n");
        }
        sqlite3_finalize(statement);
        sqlite3_close(textDB);
    }
    
}


-(NSMutableArray*) getAllDatas
{
    NSMutableArray *datasArray=[[NSMutableArray alloc] init];
    const char *sql="SELECT * FROM Data";
    sqlite3_stmt *statement;
    NSLog(@"==================================");
    int sqlResult=sqlite3_prepare_v2(textDB, sql, -1, &statement, NULL);
    if (sqlResult==SQLITE_OK) {
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
        }
    }else
    {
        NSLog(@"Problem with the database:");
        NSLog(@"%d",sqlResult);
    }
    
    return datasArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)delete:(id)sender {
}


/*避免输入时键盘挡住输入区域*/

- (void)viewWillAppear:(BOOL)animated
{
    //注册通知,监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleKeyboardDidHidden)name:UIKeyboardDidHideNotification object:nil];
    [super viewWillAppear:YES];
}

//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    
    text_note.contentInset=UIEdgeInsetsMake(0, 0,keyboardRect.size.height, 0);
}

- (void)handleKeyboardDidHidden
{
    text_note.contentInset=UIEdgeInsetsZero;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



/*点击屏幕空白处时输入键盘会消失*/

- (IBAction)backgroundTap:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    //[text_title resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
