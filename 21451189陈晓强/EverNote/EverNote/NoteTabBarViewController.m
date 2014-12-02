//
//  NoteTabBarViewController.m
//  EverNote
//
//  Created by 陈晓强 on 14/11/29.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "NoteTabBarViewController.h"
#import "ViewController.h"
#import "DrawViewController.h"
#import "MySqlite.h"
#import <sqlite3.h>
@interface NoteTabBarViewController ()
@property (strong, nonatomic) NSDictionary *noteDict;
@property (strong, nonatomic) NSAttributedString *textAttributedString;
@property (nonatomic) sqlite3 *database;
@end

@implementation NoteTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _noteDict = @{NSDocumentTypeDocumentAttribute:NSRTFDTextDocumentType};
    self.navigationItem.leftItemsSupplementBackButton = NO;
    
}

- (IBAction)Save:(id)sender {
    id viewController = [self selectedViewController];
    if ([viewController isKindOfClass:[ViewController class]]) {
        ViewController *myViewController = (ViewController *)viewController;
        UITextView *textView = myViewController.textView;
        _textAttributedString = textView.attributedText;
        UITextField *textField = myViewController.textField;
        
        NSString *title = textField.text;
        NSData *data = [self convertAttributedStringToData];
        
        MySqlite *sqliteHandle = [[MySqlite alloc] init];
        [sqliteHandle openDatabase:&_database];
//        [sqliteHandle openDatabase:_database andPath:[self dataFilePath]];
//        if (sqlite3_open([[self dataFilePath] UTF8String], &_database) != SQLITE_OK) {
//            sqlite3_close(_database);
//            NSAssert(0, @"Failed to open database");
//        }
        NSString *createTableSql = @"CREATE TABLE IF NOT EXISTS NOTES "
        "(ROW INTEGER PRIMARY KEY AUTOINCREMENT, NOTE_TITLE TEXT UNIQUE, NOTE_DATA BLOB);";
        [sqliteHandle createMySqliteTableDatabase:_database andSql:createTableSql];
        NSString *update = @"INSERT OR REPLACE INTO NOTES (NOTE_TITLE, NOTE_DATA)" "VALUES (?,?);";
        sqlite3_stmt *stmt;
        [sqliteHandle insertOrUpdateMySqliteDatabase:_database andInsertSql:update
                                        andStatement:stmt
                                            andTitle:title andData:data];
        [self.navigationController popViewControllerAnimated:YES];

    }
    
    if([viewController isKindOfClass:[DrawViewController class]])
    {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


#pragma mark - ViewController data handle
- (NSData *)convertAttributedStringToData
{
    NSError *error;
    NSData *data = [_textAttributedString dataFromRange:NSMakeRange(0, [_textAttributedString length]) documentAttributes:_noteDict error:&error];
    return data;
}


#pragma mark - database handle

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"sss");
}


@end
