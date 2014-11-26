//
//  PictureViewController.m
//  NoteBook
//
//  Created by 陈晟豪 on 14/11/26.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import "PictureViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <sqlite3.h>

@interface PictureViewController ()
@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *lastChosenMediaType;
NSString *docPath(void);
@end

@implementation PictureViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(clickCancelButton:)];
    
    
    navigationItem.leftBarButtonItem = leftButton;
    
    //创建第一个右边按钮
    UIBarButtonItem *rightCameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                                       target:self
                                                                                       action:@selector(clickCameraButton:)];
    
    //创建第二个右边按钮
    UIBarButtonItem *rightSaveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(clickSaveButton:)];
    
    NSArray *buttonArray = @[rightSaveButton,rightCameraButton];
    navigationItem.rightBarButtonItems = buttonArray;
    
    //设置导航栏内容
    [navigationItem setTitle:@"写日记"];
    
    [self.pictureNavigationBar pushNavigationItem:navigationItem animated:NO];
    
    self.pictureView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.pictureView.layer.borderWidth = 1.0f;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //注册通知,监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardDidShowNotification
                                              object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidHidden)
                                                name:UIKeyboardDidHideNotification
                                              object:nil];
    [super viewWillAppear:YES];
}

//视图每次被显示时调用
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateDisplay];
}

//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    
    self.pictureTextView.contentInset=UIEdgeInsetsMake(0, 0,keyboardRect.size.height, 0);
}

- (void)handleKeyboardDidHidden
{
    self.pictureTextView.contentInset=UIEdgeInsetsZero;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//取消按钮动作
- (IBAction)clickCancelButton:(id)sender
{
    //取消textview为第一响应者，隐藏键盘
    [self.pictureTextView resignFirstResponder];
    [self.pictureTitle resignFirstResponder];
    
    //显示操作表单
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"清空"
                                                    otherButtonTitles:nil];
    actionSheet.tag = 201;
    [actionSheet showInView:self.view];
}


//相片按钮
- (IBAction)clickCameraButton:(id)sender
{
    //取消textview为第一响应者，隐藏键盘
    [self.pictureTextView resignFirstResponder];
    [self.pictureTitle resignFirstResponder];
    
    //显示操作表单
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"照相机",@"图片库",nil];
    actionSheet.tag = 202;
    [actionSheet showInView:self.view];
}

//ActionSheet按钮响应时间
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 201)
    {
        if (buttonIndex == 0)
        {
            //清空
            [self.pictureTextView setText:nil];
            [self.pictureTitle setText:nil];
            [self.pictureView setImage:nil];
            self.image = nil;
        }
    }
    else if(actionSheet.tag == 202)
    {
        if(buttonIndex == 0)
        {
            //图片库
            [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
        }
        else if(buttonIndex == 1)
        {
            //照相机
            [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    }
}

- (void)updateDisplay
{
    //上次选择的是图像还是视频
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage])
    {
        self.pictureView.image = self.image;
        self.pictureView.hidden = NO;
    }
}

//创建并配置一个图像选取器.sourceType来确定应该显示照相机还是媒体库
- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController
                           availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController
         isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0) {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

#pragma mark - Image Picker Controller delegate methods

//获取选择的图片
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.lastChosenMediaType = info[UIImagePickerControllerMediaType];
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage]) {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        self.image = chosenImage;
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//保存按钮
- (IBAction)clickSaveButton:(id)sender
{
    //取消textview为第一响应者，隐藏键盘
    [self.pictureTextView resignFirstResponder];
    [self.pictureTitle resignFirstResponder];
    
    if(self.image != nil)
    {
        NSString *currentText = self.pictureTextView.text;
        NSString *currentTitle = self.pictureTitle.text;
        
        if([currentTitle isEqualToString:@""])
        {
            currentTitle = currentText;
        }
        
        //如果是空的什么也不做
        if (![currentText isEqualToString:@""])
        {
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            
            //给图片按时间命名
            NSDate* date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMddHHMMSS"];
            NSString* str = [formatter stringFromDate:date];
            
            //沙盒路径，存图片
            NSString *picturePath = [docPath() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",str]];
            
            NSString *insertSQL = [NSString stringWithFormat:@"INSERT OR REPLACE INTO FILEDS (FILED_TITLE ,FILED_DATA ,PICTURE_PATH) VALUES ('%@','%@','%@')",currentTitle,currentText,picturePath];
            char *err;
            if (sqlite3_exec(appDelegate.database, [insertSQL UTF8String], NULL, NULL, &err) != SQLITE_OK)
            {
                NSLog(@"数据库操作数据失败,%s",err);
            }
            else
            {
                //存入图片
                [UIImagePNGRepresentation(self.image)writeToFile:picturePath atomically:YES];
                
                //初始化AlertView
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存成功"
                                                                message:@"日记以保存"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            //清空输入框
            [self.pictureTextView setText:@""];
            [self.pictureTitle setText:@""];
            [self.pictureView setImage:nil];
            self.image = nil;
        }
        else
        {
            //初始化AlertView
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"标题或内容不能为空"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        //初始化AlertView
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"图片未添加"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

//获取沙盒文件路径
NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [pathList objectAtIndex:0];
    return documentsDirectory;
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
