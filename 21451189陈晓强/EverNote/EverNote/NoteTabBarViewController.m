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
@property (nonatomic) UIAlertView *alert;
@property (strong , nonatomic) NSMutableString *myTitle;
@property (strong, nonatomic) NSData *pictureData;
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
    [self insertMyDatabase:viewController];
}


#pragma mark - ViewController data handle
- (NSData *)convertAttributedStringToData
{
    NSError *error;
    NSData *data = [_textAttributedString dataFromRange:NSMakeRange(0, [_textAttributedString length]) documentAttributes:_noteDict error:&error];
    return data;
}


#pragma mark - database handle

- (void)insertMyDatabase:(id)viewController
{
    if ([viewController isKindOfClass:[ViewController class]]) {
        ViewController *myViewController = (ViewController *)viewController;
        UITextView *textView = myViewController.textView;
        _textAttributedString = textView.attributedText;
        
        UITextField *textField = myViewController.textField;
        
        NSString *title = textField.text;
        NSData *data = [self convertAttributedStringToData];
        
        MySqlite *sqliteHandle = [[MySqlite alloc] init];
        [sqliteHandle openDatabase:&_database];
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
        DrawViewController *myDrawViewController = (DrawViewController *)viewController;
        
        UIImage* myImage = [self imageWithView:myDrawViewController.view];
        NSLog(@"mwitdh=%f mheight%f",myImage.size.width,myImage.size.height);
        _pictureData = UIImageJPEGRepresentation(myImage,0.5);
//        UIImage *lastView = [UIImage imageWithData:_pictureData];
//        UIImage *lastView = [self OriginImage:[UIImage imageWithData:_pictureData] scaleToSize:CGSizeMake(320, 568)];
        
        _alert = [[UIAlertView alloc] initWithTitle:@"请输入标题" message:@"不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [_alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [_alert show];
//
        }
}

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
            MySqlite *sqliteHandle = [[MySqlite alloc] init];
            [sqliteHandle openDatabase:&_database];
            NSString *createTableSql = @"CREATE TABLE IF NOT EXISTS NOTES_PICTURE "
            "(ROW INTEGER PRIMARY KEY AUTOINCREMENT, NOTE_TITLE TEXT UNIQUE, NOTE_DATA BLOB);";
            [sqliteHandle createMySqliteTableDatabase:_database andSql:createTableSql];
            NSString *update = @"INSERT OR REPLACE INTO NOTES_PICTURE (NOTE_TITLE, NOTE_DATA)" "VALUES (?,?);";
            sqlite3_stmt *stmt;
            [sqliteHandle insertOrUpdateMySqliteDatabase:_database andInsertSql:update
                                            andStatement:stmt
                                                andTitle:_myTitle andData:_pictureData];
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}


@end
