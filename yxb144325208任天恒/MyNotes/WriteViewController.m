//
//  WriteViewController.m
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "WriteViewController.h"

@interface WriteViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textview;
@property (strong, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textview.layer.borderWidth=1; //设置textview的边框
    self.textfield.layer.borderWidth =1;
    _textview.delegate = self;
    
    
    
    /*根据路径创建数据库并创建一个表contact(id nametext addresstext phonetext)*/
    
    NSString *docsDir1;
    NSArray *dirPaths1;
    
    // Get the documents directory
    dirPaths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir1 = [dirPaths1 objectAtIndex:0];
    
    // Build the path to the database file
    databasePath1 = [[NSString alloc] initWithString: [docsDir1 stringByAppendingPathComponent: @"note.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath:databasePath1] == NO)
    {
        NSLog(@"1111");
        const char *dbpath = [databasePath1 UTF8String];
        if (sqlite3_open(dbpath, &noteDB)==SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS NOTE(ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT,INFO TEXT)";
            if (sqlite3_exec(noteDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK) {
                NSLog(@"创建表成功");
            }
        }
        else
        {
            NSLog(@"创建表失败");
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (IBAction)save:(id)sender {
    sqlite3_stmt *statement;
    
    const char *dbpath = [databasePath1 UTF8String];
    
    if (sqlite3_open(dbpath, &noteDB)==SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO NOTE (TITLE,INFO) VALUES(\"%@\",\"%@\")",self.textfield.text,self.textview.text];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(noteDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement)==SQLITE_DONE) {
            self.textview.text = @"";
            self.textfield.text =@"";
            NSLog(@"保存成功");
        }
        else
        {
            NSLog(@"保存失败");
        }
        sqlite3_finalize(statement);
        sqlite3_close(noteDB);
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"保存成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    alert.delegate = self;
    [alert show];
    
    
}

@end
