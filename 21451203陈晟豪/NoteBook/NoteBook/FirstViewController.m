//
//  FirstViewController.m
//  NoteBook
//
//  Created by 陈晟豪 on 14/11/21.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <sqlite3.h>

@interface FirstViewController ()

@end


@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                   style:UIBarButtonItemStyleDone
                                                                                target:self
                                                                                action:@selector(clickCancelButton:)];
    

    navigationItem.leftBarButtonItem = leftButton;
    
    
    //创建右边按钮
    UIBarButtonItem *rightSaveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(clickSaveButton:)];
    
    navigationItem.rightBarButtonItem = rightSaveButton;
    
    //设置导航栏内容
    [navigationItem setTitle:@"写日记"];
    
    [self.firstNavigationBar pushNavigationItem:navigationItem animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
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


//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    
    self.textView.contentInset=UIEdgeInsetsMake(0, 0,keyboardRect.size.height, 0);
}

- (void)handleKeyboardDidHidden
{
    self.textView.contentInset=UIEdgeInsetsZero;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//取消按钮动作
- (IBAction)clickCancelButton:(id)sender
{
    //取消textview为第一响应者，隐藏键盘
    [self.textView resignFirstResponder];
    [self.diaryTitle resignFirstResponder];
    
    //显示操作表单
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"清空"
                                                    otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

//ActionSheet按钮响应时间
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //清空
        [self.textView setText:nil];
        [self.diaryTitle setText:nil];
    }
}

//保存按钮
- (IBAction)clickSaveButton:(id)sender
{
    //取消textview为第一响应者，隐藏键盘
    [self.textView resignFirstResponder];
    [self.diaryTitle resignFirstResponder];
    
    NSString *currentText = self.textView.text;
    NSString *currentTitle = self.diaryTitle.text;
    
    if([currentTitle isEqualToString:@""])
    {
        currentTitle = currentText;
    }
    
    //如果是空的什么也不做
    if (![currentText isEqualToString:@""])
    {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT OR REPLACE INTO FILEDS (FILED_TITLE ,FILED_DATA ,PICTURE_PATH) VALUES ('%@','%@','%@')",currentTitle,currentText,@"nil"];
        char *err;
        if (sqlite3_exec(appDelegate.database, [insertSQL UTF8String], NULL, NULL, &err) != SQLITE_OK)
        {
            NSLog(@"数据库操作数据失败,%s",err);
        }
        else
        {
            //初始化AlertView
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存成功"
                                                            message:@"日记以保存"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    
    //清空输入框
    [self.textView setText:@""];
    [self.diaryTitle setText:@""];
}

@end
