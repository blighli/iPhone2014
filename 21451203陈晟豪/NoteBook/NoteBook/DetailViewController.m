//
//  DetailViewController.m
//  NoteBook
//
//  Created by 陈晟豪 on 14/11/25.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()
{
    AppDelegate *appDelegate;
    UITextView *textView;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    //获取行号对应的数据库数据
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM FILEDS WHERE ID=%ld",(long)[[appDelegate.numberArray objectAtIndex:appDelegate.databaseIndexPath] integerValue]];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(appDelegate.database, [query UTF8String],
                           -1, &statement, nil) == SQLITE_OK)
    {
        //遍历返回每一行
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            //获取数据
            char *titleData = (char *)sqlite3_column_text(statement, 1);
            char *diaryData = (char *)sqlite3_column_text(statement, 2);
            char *picData = (char *)sqlite3_column_text(statement, 3);

            //利用获取的数据进行设置
            NSString *titleValue = [[NSString alloc] initWithUTF8String:titleData];
            NSString *diaryValue = [[NSString alloc] initWithUTF8String:diaryData];
            NSString *picturePath = [[NSString alloc] initWithUTF8String:picData];

            if(![picturePath isEqualToString:@"nil"])
            {
                CGRect rect = [[UIScreen mainScreen] bounds];
                CGSize size = rect.size;
                
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, 171)];
                [imageView setImage:[UIImage imageWithContentsOfFile:picturePath]];
                [self.detailText addSubview:imageView];
                
                textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 175, size.width, size.height)];
                textView.text = diaryValue;
                [self.detailText addSubview:textView];
            }
            else
            {
                textView = nil;
                self.detailText.text = diaryValue;
            }
            self.title = titleValue;
        }
        sqlite3_finalize(statement);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedButtonItem:(UIBarButtonItem *)sender
{
    //IndexPath对应行号
    NSInteger row = [[appDelegate.numberArray objectAtIndex:appDelegate.databaseIndexPath] integerValue];
    NSString *updateSQL;
    
    if(textView != nil)
    {
        //修改数组内容
        [appDelegate.contentArray replaceObjectAtIndex:appDelegate.databaseIndexPath withObject:textView.text];
        
        //修改数据库
        updateSQL = [NSString stringWithFormat:@"UPDATE FILEDS SET FILED_DATA='%@' WHERE ID=%d",textView.text, row];
    }
    else
    {
        //修改数组内容
        [appDelegate.contentArray replaceObjectAtIndex:appDelegate.databaseIndexPath withObject:self.detailText.text];
        
        //修改数据库
        updateSQL = [NSString stringWithFormat:@"UPDATE FILEDS SET FILED_DATA='%@' WHERE ID=%d",self.detailText.text, row];
    }
    char *err;
    if (sqlite3_exec(appDelegate.database, [updateSQL UTF8String], NULL, NULL, &err) != SQLITE_OK)
    {
        NSLog(@"数据库操作数据失败,%s",err);
    }
    else
    {
        //初始化AlertView
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改成功"
                                                        message:@"修改记录以保存"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
@end
