//
//  MainScene.m
//  MyNotes
//
//  Created by 张榕明 on 14/11/22.
//  Copyright (c) 2014年 张榕明. All rights reserved.
//

#import "MainScene.h"
#import "WriteViewController.h"
#import <sqlite3.h>
#import "UIImage+DrawCaptureView.h"
#import "WriteViewController.h"
#import "DrawPlaneView.h"
#import "MyModeldata.h"
#import "RecordViewController.h"
#import "CameraViewController.h"
#import "AlarmViewController.h"
#import "TextViewController.h"
@interface MainScene ()

@end
UIViewController * tmpviewController;
NSString * title;
NSString * url;
NSData * contentData;
int type=1;

@implementation MainScene

-(NSString * )dataFilePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return [path stringByAppendingString:@"datass.sqlite"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 0;
    tmpviewController = self.selectedViewController;
    self.delegate = self;
    UIBarButtonItem * savebutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonclick:)];
    
    self.navigationItem.rightBarButtonItem = savebutton;
    self.title = @"手写";
}

-(void)saveButtonclick:(id)sender
{
    
    if (tmpviewController.tabBarItem.tag==4) {
        AlarmViewController * viewcontroller = (AlarmViewController *)tmpviewController;
        viewcontroller.alarmContentView.editable = NO;
    }
    if (tmpviewController.tabBarItem.tag ==5) {
        TextViewController * viewcontroller = (TextViewController *)tmpviewController;
        viewcontroller.contentView.editable = NO;
    }
    UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"添加标题" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertview.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UITextField * textfied = [alertView textFieldAtIndex:0];
    if (buttonIndex==0) {
        textfied.text = @"";
    }else
    {
        
        title = textfied.text;
        
        type = (int)tmpviewController.tabBarItem.tag;
        
        NSDate *date = [[NSDate alloc] init];
        NSString *dateString = [NSString stringWithFormat:@"%@",date];

        
        sqlite3 * database;
        if (sqlite3_open([[self dataFilePath] UTF8String], &database)!=SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0, @"canot open the database");
        }
    
        NSString * createSql = @"CREATE TABLE IF NOT EXISTS FIELDS(ID INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,contentData BLOB,time TEXT,type INTEGER)";
        char * errormsg;
        
        if (sqlite3_exec(database, [createSql UTF8String], NULL, NULL, &errormsg)!=SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0, @"Error creating table :%s",errormsg);
        }
        sqlite3_stmt * stmt;
        NSString * insertSql = @"INSERT INTO FIELDS(title,contentData,time,type) VALUES(?,?,?,?)";
        
        int test = sqlite3_prepare(database, [insertSql UTF8String], -1, &stmt, NULL);
        NSLog(@"the test is the %d",test);
        
        if (sqlite3_prepare_v2(database, [insertSql UTF8String], -1, &stmt,NULL)==SQLITE_OK)
        {
            NSLog(@"this is the sqlite3");
            switch (type)
            {
                case 1:
                {
                   
                    WriteViewController * viewcontroller = (WriteViewController *)tmpviewController;
                    UIImage * image =[UIImage captureimageview:viewcontroller.drawplane];
                    contentData = UIImageJPEGRepresentation(image, 1.0);
                    sqlite3_bind_text(stmt, 1, [title UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 2, [contentData bytes], (int)[contentData length], NULL);
                    sqlite3_bind_text(stmt, 3, [dateString UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 4, type);
                    
                    [viewcontroller.drawplane cleanView];
                    break;
                }
                case 2:
                {
                    RecordViewController * viewcontroller = (RecordViewController *)tmpviewController;
                    NSString * urls = [viewcontroller.urlplay absoluteString];
                    contentData = [urls dataUsingEncoding:NSUTF8StringEncoding];
                    sqlite3_bind_text(stmt, 1, [title UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 2, [contentData bytes], (int)[contentData length], NULL);
                    sqlite3_bind_text(stmt, 3, [dateString UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 4, type);
                    break;
                }
                case 3:
                {
                    CameraViewController * viewcontroller = (CameraViewController *)tmpviewController;
                    UIImage * image = viewcontroller.cameraimageview.image;
                    contentData = UIImageJPEGRepresentation(image, 1.0);
                    sqlite3_bind_text(stmt, 1, [title UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 2, [contentData bytes], (int)[contentData length], NULL);
                    sqlite3_bind_text(stmt, 3, [dateString UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 4, type);
                    break;
                }
                case 4:
                {
                    AlarmViewController * viewcontroller = (AlarmViewController *)tmpviewController;
                    NSMutableString * string = [[NSMutableString alloc] init];
                    [string appendString:title];
                    [string appendString:dateString];
                    NSDate * date = viewcontroller.alarmdatapicker.date;
                    NSString * datestr = [NSString stringWithFormat:@"%@",date];
                    NSString * contentstring = viewcontroller.alarmContentView.text;
                    contentData = [contentstring dataUsingEncoding:NSUTF8StringEncoding];
                    sqlite3_bind_text(stmt, 1, [string UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 2, [contentData bytes], (int)[contentData length], NULL);
                    sqlite3_bind_text(stmt, 3, [datestr UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 4, type);
                    viewcontroller.alarmContentView.text = @"";
                    viewcontroller.alarmContentView.editable = YES;
                    break;
                }
                case 5:
                {
                    TextViewController * viewcontroller = (TextViewController *)tmpviewController;
                    contentData = [viewcontroller.contentView.text dataUsingEncoding:NSUTF8StringEncoding];
                    sqlite3_bind_text(stmt, 1, [title UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 2, [contentData bytes], (int)[contentData length], NULL);
                    sqlite3_bind_text(stmt, 3, [dateString UTF8String], -1, NULL);
                    sqlite3_bind_int(stmt, 4, type);
                    viewcontroller.contentView.text = @"";
                    viewcontroller.contentView.editable = YES;
                }
                default:
                    break;
            }
            
            if (sqlite3_step(stmt)!=SQLITE_DONE) {
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"警告" message:@"插入操作失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertview show];
            }
            sqlite3_finalize(stmt);
            sqlite3_close(database);
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
       self.title = viewController.title;
    
    tmpviewController = viewController;
    
    

}

@end
