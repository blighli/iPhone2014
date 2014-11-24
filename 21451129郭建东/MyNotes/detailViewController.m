//
//  detailViewController.m
//  MyNotes
//
//  Created by cstlab on 14/11/21.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "detailViewController.h"
#import <sqlite3.h>
@interface detailViewController ()

@end


@implementation detailViewController

-(NSString*)dataFilePath
{
    
    NSString *DocuMentDir;
    NSArray  *DirPath;
    
    DirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    DocuMentDir = [DirPath objectAtIndex:0];
    NSLog(@"DocuMentDir-------:%@",DocuMentDir);
    
    return [DocuMentDir stringByAppendingPathComponent:@"Memos.sqlite"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * items =[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonSystemItemSave target:self action:@selector(ButtonSave)];
    self.navigationItem.rightBarButtonItem = items;
    // Do any additional setup after loading the view from its nib.
}
-(void)ButtonSave
{
    sqlite3 *MemoDB;
    if (sqlite3_open([[self dataFilePath]UTF8String], &MemoDB)!=SQLITE_OK) {
        NSLog(@"Failed to Create The Memo Database !");
        sqlite3_close(MemoDB);
        
    }else
    {
        NSLog(@"Success to Create Memo Database !");
    }
    char *ErrorMessage;
    NSString * create = @"CREATE TABLE IF NOT EXISTS MemoTextss (ID INTEGER PRIMARY KEY AUTOINCREMENT,Title TEXT, Messages TEXT);";
    if (sqlite3_exec(MemoDB,[create UTF8String],NULL,NULL,&ErrorMessage)== SQLITE_OK) {
        NSLog(@"Success to Create The table Memo !");
    }else
    {
        NSLog(@"Failed to Create The table Memo !");
        sqlite3_close(MemoDB);
    }
    if ([self.titletextfield.text length]==0||[self.messagetextview.text length]==0) {
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"warining" message:@"content is empty" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    NSString *sql_insert = @"INSERT OR REPLACE INTO MemoTextss(Title,Messages) VALUES(?,?); ";
    sqlite3_stmt * statment;
    if (sqlite3_prepare_v2(MemoDB, [sql_insert UTF8String], -1, &statment, nil)==SQLITE_OK) {
        sqlite3_bind_text(statment, 1, [self.titletextfield.text UTF8String], -1, NULL);
        sqlite3_bind_text(statment, 2, [self.messagetextview.text UTF8String], -1, NULL);
    }
    if (sqlite3_step(statment)!=SQLITE_DONE) {
        NSLog(@"插入错误");
    }else
    {
        sqlite3_finalize(statment);
        
    }
    sqlite3_close(MemoDB);
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

@end
