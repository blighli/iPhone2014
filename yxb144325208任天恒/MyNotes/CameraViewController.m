//
//  CameraViewController.m
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController
//@property (strong, nonatomic) IBOutlet UIButton *photo;
//@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@synthesize photo;
@synthesize imageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photo.layer.borderWidth = 1;
    self.imageView.layer.borderWidth= 1;
    
    /*根据路径创建数据库并创建一个表contact(id nametext addresstext phonetext)*/
    
    NSString *docsDir2;
    NSArray *dirPaths2;
    
    // Get the documents directory
    dirPaths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir2 = [dirPaths2 objectAtIndex:0];
    
    // Build the path to the database file
    databasePath2 = [[NSString alloc] initWithString: [docsDir2 stringByAppendingPathComponent: @"camera.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath:databasePath2] == NO)
    {
        NSLog(@"1111");
        const char *dbpath = [databasePath2 UTF8String];
        if (sqlite3_open(dbpath, &cameraDB)==SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CAMERA(ID INTEGER PRIMARY KEY AUTOINCREMENT, PICTURE TEXT)";
            if (sqlite3_exec(cameraDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK) {
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





- (IBAction)takePhoto:(id)sender {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    self.imageView.image = image;
    [picker dismissModalViewControllerAnimated:YES];
    
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    NSString *imageName = [NSString stringWithFormat:@"%@.png",currentTime];
    //NSString *imageName=currentTime; //给照片命名，以当前时间为名
    NSLog(@"%@",imageName);
    
    //存到沙盒中
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]];   // 保存文件
    BOOL result = [UIImagePNGRepresentation(self.imageView.image)writeToFile: filePath    atomically:YES];
    
    NSLog(@"%d",result);
    
    //存到手机的相册中
    UIGraphicsBeginImageContext(self.imageView.bounds.size);
    [self.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(temp, nil, nil, nil);
    
    //将照片名字存到数据库
    sqlite3_stmt *statement;
    
    const char *dbpath = [databasePath2 UTF8String];
    
    if (sqlite3_open(dbpath, &cameraDB)==SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO CAMERA (PICTURE) VALUES(\"%@\")",imageName];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(cameraDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement)==SQLITE_DONE) {
            NSLog(@"保存成功");
        }
        else
        {
            NSLog(@"保存失败");
        }
        sqlite3_finalize(statement);
        sqlite3_close(cameraDB);
    }
    
    
    
}

@end
