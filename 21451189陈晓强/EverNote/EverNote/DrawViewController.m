//
//  DrawViewController.m
//  EverNote
//
//  Created by 陈晓强 on 14/12/3.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "DrawViewController.h"
#import "SmoothLineView.h"
#import <sqlite3.h>
#import "MySqlite.h"
@interface DrawViewController ()
@property (nonatomic) sqlite3 *database;
@property (nonatomic) UIAlertView *alert;
@property (strong, nonatomic) NSData *pictureData;
@property (nonatomic) SmoothLineView *smoothView;
@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _smoothView = [[SmoothLineView alloc] initWithFrame:self.view.bounds];
    _smoothView.curImage = _image;
    [self.view addSubview:_smoothView];
//    // Do any additional setup after loading the view.
////    self.smoothView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
//    SmoothLineView *smoothView = [[SmoothLineView alloc] initWithFrame:
//                                  self.smoothView.bounds];
//    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:_image];
//    smoothView.curImage = _image;
//    //    [smoothView addSubview:imageView];
//    [self.smoothView addSubview:smoothView];
}

- (IBAction)Done:(id)sender {
    UIImage* myImage = [self imageWithView:_smoothView];
    NSLog(@"mwitdh=%f mheight%f",myImage.size.width,myImage.size.height);
    _pictureData = UIImageJPEGRepresentation(myImage,0.5);
    //        UIImage *lastView = [UIImage imageWithData:_pictureData];
    MySqlite *sqliteHandle = [[MySqlite alloc] init];
    [sqliteHandle openDatabase:&_database];
    NSString *createTableSql = @"CREATE TABLE IF NOT EXISTS NOTES_PICTURE "
    "(ROW INTEGER PRIMARY KEY AUTOINCREMENT, NOTE_TITLE TEXT UNIQUE, NOTE_DATA BLOB);";
    [sqliteHandle createMySqliteTableDatabase:_database andSql:createTableSql];
    char *sql = "update  NOTES_PICTURE set NOTE_DATA = ? WHERE NOTE_TITLE = ?";
    sqlite3_stmt *statement;
    int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
    if (success != SQLITE_OK) {
        NSLog(@"Error: failed to update:testTable");
        sqlite3_close(_database);
    }
    NSLog(@"%@",_myTitle);
    const void *rowData = [_pictureData bytes];
    sqlite3_bind_text(statement, 2, [_myTitle UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_blob(statement, 1, rowData, (int)[_pictureData length], NULL);
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

//
//    _alert = [[UIAlertView alloc] initWithTitle:@"请输入标题" message:@"不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [_alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
//    [_alert show];
}



    //


-(UIImage*)  OriginImage:(UIImage *)image   scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark - alertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if([[alertView textFieldAtIndex:0].text isEqualToString:@""])
        {
            
        }else
        {
            _myTitle = [NSMutableString stringWithFormat:@"%@",[alertView textFieldAtIndex:0].text];
            

        }
        
    }
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
