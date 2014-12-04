//
//  ViewController.m
//  EverNote
//
//  Created by 陈晓强 on 14/11/28.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "ViewController.h"
#import "IQKeyboardManager.h"
#import "MySqlite.h"
#import <sqlite3.h>
@interface ViewController ()

@property (strong, nonatomic) NSAttributedString *textAttributedString;
@property (nonatomic) sqlite3 *database;
@property (strong, nonatomic) NSDictionary *noteDict;
@property (nonatomic) BOOL wasKeyboardManagerEnabled;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setKeyboard];
    _textAttributedString = [[NSAttributedString alloc] init];
    _textView.delegate = self;
    _textView.attributedText = _myAttributedString;
    _noteDict = @{NSDocumentTypeDocumentAttribute:NSRTFDTextDocumentType};
//    _otherTextView.attributedText = _myAttributedString;
    _textField.delegate = self;
    _textField.text = _myTitle;
    NSLog(@"%@",_myTitle);
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
}
#pragma mark - ViewController data handle
- (NSData *)convertAttributedStringToData
{
    NSError *error;
    NSData *data = [_textAttributedString dataFromRange:NSMakeRange(0, [_textAttributedString length]) documentAttributes:_noteDict error:&error];
    NSString *string =  _textAttributedString.string;
    return data;
}


- (IBAction)Done:(id)sender {


    _textAttributedString = _textView.attributedText;
    NSString *title = _textField.text;
    NSData *data = [self convertAttributedStringToData];
    MySqlite *sqliteHandle = [[MySqlite alloc] init];
    [sqliteHandle openDatabase:&_database];
//    NSString *createTableSql = @"CREATE TABLE IF NOT EXISTS NOTES "
//    "(ROW INTEGER PRIMARY KEY AUTOINCREMENT, NOTE_TITLE TEXT UNIQUE, NOTE_DATA BLOB);";
//    [sqliteHandle createMySqliteTableDatabase:_database andSql:createTableSql];
    sqlite3_stmt *statement;    char *sql = "update  NOTES set NOTE_DATA = ? WHERE NOTE_TITLE = ?";

    int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
    if (success != SQLITE_OK) {
        NSLog(@"Error: failed to update:testTable");
        sqlite3_close(_database);
    }
    const void *rowData = [data bytes];
    sqlite3_bind_text(statement, 2, [_myTitle UTF8String], -1, SQLITE_TRANSIENT);
//    sqlite3_bind_text(statement, 2, [title UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_blob(statement, 1, rowData, (int)[data length], NULL);
    success = sqlite3_step(statement);
    //释放statement
    sqlite3_finalize(statement);
    
    //如果执行失败
    if (success == SQLITE_ERROR) {
        NSLog(@"Error: failed to update the database with message.");
        //关闭数据库
        sqlite3_close(_database);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

#pragma mark - keyboard action

- (void) setKeyboard
{

    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * button =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhoto)];
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                                                  target:self action:@selector(resignKeyboard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:button,button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    [_textView setInputAccessoryView:topView];
    [_textField setInputAccessoryView:topView];
}

- (void)takePhoto
{
   
}
- (void) resignKeyboard
{
    NSLog(@"come in");
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];

}

- (IBAction)backgroundTap:(id)sender{
}





@end
