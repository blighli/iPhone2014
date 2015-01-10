//
//  PhotoViewController.m
//  MyNote
//
//  Created by 蔡飞跃 on 14/11/23.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController
@synthesize photo_title;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    photo_title=[[UITextField alloc] init];
    
    //根据路径创建数据库并创建一个表
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"photo.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath:databasePath] == NO)
    {
        //创建数据库
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &photoDB)==SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PHOTOES(ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT, PHOTO TEXT)";
            if (sqlite3_exec(photoDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
            {
                NSLog(@"创建表失败\n");
            }
            else
            {
               NSLog(@"创建表成功\n");
            }
        }
        else
        {
            NSLog(@"创建/打开数据库失败\n");
        }
        
    }

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)insert_photo:(id)sender {
    
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    [myActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}


//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        //[picker release];
        [self presentModalViewController:picker animated:YES];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentModalViewController:picker animated:YES];
    //[picker release];
}

//当选择一张图片后进入这里
-(NSString *)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
       UIImageView *smallimage = [[UIImageView alloc] initWithFrame:
                                     CGRectMake(50, 120, 200, 200)];
        
        smallimage.image = image;
        //加在视图中
        [self.view addSubview:smallimage];
        
    }
    return filePath;
    
}

- (IBAction)save:(id)sender {
    
    sqlite3_stmt *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &photoDB)==SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO PHOTOES (title,photo) VALUES(\"%@\",\"%@\")",photo_title.text,filePath];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(photoDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement)==SQLITE_DONE) {
            NSLog(@"已存储到数据库\n");
            photo_title.text = @"";
            filePath= @"";
        }
        else
        {
            NSLog(@"保存失败\n");
        }
        sqlite3_finalize(statement);
        sqlite3_close(photoDB);
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissModalViewControllerAnimated:YES];
}



/*-(void)sendInfo
{
    NSLog(@"图片的路径是：%@", databasePath);
    NSLog(@"您输入框中的内容是：%@", photo_title.text);
}*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
