//
//  XLConposeViewController.m
//  XinLang
//
//  Created by 周舟 on 14-10-1.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLConposeViewController.h"
#import "XLTextView.h"
#import "XLAccountTool.h"
#import "XLAccount.h"
#import "XLHttpTool.h"
#import "XLComposeToolBar.h"
#import "XLComposePhotoView.h"
#import "MBProgressHUD+MJ.h"
#import "XLTitleButton.h"



@interface XLConposeViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,XLComposeToolBarDelegate,UINavigationControllerDelegate>
@property (nonatomic, weak) XLTextView *textView;
@property (nonatomic, weak) XLComposeToolBar *toolBar;
@property (nonatomic, weak) XLComposePhotoView *photoView;

@end

@implementation XLConposeViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    
    //设置导航栏
    [self setupNavBar];
    
    //设置textView
    [self setupTextView];
    
    //添加toolBar
    [self setupToolBar];
    
    //添加photoView
    [self setupPhotoView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
#pragma mark 初始化事件

- (void)setupPhotoView
{
    XLComposePhotoView *photoView = [[XLComposePhotoView alloc] init];
    CGFloat photoW = self.textView.frame.size.width;
    CGFloat photoH = self.textView.frame.size.height;
    CGFloat photoY = 80;
    photoView.frame = CGRectMake(0, photoY, photoW, photoH);
    [self.textView addSubview:photoView];
    
    self.photoView = photoView;
}

/**
 *  添加工具条
 */
- (void)setupToolBar
{
    
    XLComposeToolBar *toolBar = [[XLComposeToolBar alloc] init];
    CGFloat toolBarH = 44;
    CGFloat toolBarW = self.view.frame.size.width;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = self.view.frame.size.height - toolBarH;
    
    toolBar.frame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}

/**
 *  设置导航栏
 */
- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    //1.发送按钮
    UIBarButtonItem *sendBtn = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendClick:)];
    self.navigationItem.rightBarButtonItem = sendBtn;

    //取消按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //标题
    //self.title = @"发微博";
    XLTitleButton *btn = [[XLTitleButton alloc] init];
    
    self.navigationItem.titleView = btn;
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 0, 40);
    [btn setTitle:@"发微博" forState:UIControlStateNormal];
  
    self.navigationItem.titleView = btn;
    

    
}
/**
 *  设置textView
 */
- (void)setupTextView
{
    //1.添加textView
    XLTextView *textView = [[XLTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.keyboardType = UIKeyboardTypeDefault;
    textView.editable = YES;
    [self.view addSubview:textView];
    
    self.textView = textView;
    //2.添加文字改变监听事件监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    NSLog(@"%@", NSStringFromCGRect(self.textView.frame));
    
    //3.添加监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark 通知触发事件


/**
 *   键盘即将出现是调用
 *
 *  @param notification 通知携带的信息
 */
- (void)keyboardWillShow:(NSNotification *)notification{
    
    /*
     {name = UIKeyboardWillShowNotification; userInfo = {
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 694.5}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 441.5}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 568}, {320, 253}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 315}, {320, 253}}";
     }}
     
     */
    //1.取出键盘frame
    NSLog(@"---notification:%@",notification);
    CGRect keyboardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //2.取出键盘弹出的时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, - keyboardF.size.height);
        
    }];
}

/**
 *  键盘即将消失时调用
 *
 *  @param notification 通知携带的信息
 */
- (void)keyboardWillHide:(NSNotification *)notification{
    //1.取出键盘弹出的时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
}

- (void)textDidChange
{
    NSLog(@"textDidChange");
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark 导航栏事件
/**
 *  取消
 *
 *  @param item leftitem
 */
- (void)cancelClick:(UIBarButtonItem *)item
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送微博
 *
 *  @param item rightItem
 */
- (void)sendClick:(UIBarButtonItem *)item
{
    
    if (self.photoView.totalImages.count) {
        [self sendWithIamge];
        NSLog(@"-----sendWithIamge");
    }else{
        [self sendWithOutImage];
        NSLog(@"-----sendWithOutImage");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
 
}

- (void)sendWithIamge
{
    //1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [XLAccountTool account].access_token;
    
    //2.封装文件参数
    NSMutableArray *formDataArray = [NSMutableArray array];
    NSArray *images = [self.photoView totalImages];
    
    for (UIImage *image in images) {
        XLFormData *formData = [[XLFormData alloc] init];
        formData.data = UIImageJPEGRepresentation(image, 0.000001);
        formData.name = @"pic";
        formData.minetype = @"image/jpeg";
        formData.filename = @"";
        [formDataArray addObject:formData];
    }
    //3.发送请求
    [XLHttpTool postWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params formDataArray:formDataArray success:^(id json) {
        NSLog(@"发送成功");
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(NSError *error) {
        NSLog(@"发送失败 error:%@",error);
        [MBProgressHUD showError:@"发送失败"];
    }];
    
}


- (void)sendWithOutImage
{
    NSLog(@"sendWithOutImage");
    //只能使用  params[@"visible"] = @0; 发送
    //NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/statuses/update.json"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XLAccountTool account].access_token;
    params[@"visible"] = @0;
    params[@"status"] = self.textView.text ;
    
    [XLHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id json) {
        NSLog(@"成攻发出！");
        
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        NSLog(@"失败：%@",error);
        [MBProgressHUD showError:@"发送失败"];

    }];
}



#pragma mark 代理方法
- (void)composeToolBar:(XLComposeToolBar *)toolBar didClickButton:(XLComposeToolbarButtonType)buttonType
{
    //NSLog(@"XLComposeToolbarButtonType:%d",buttonType);
    
    if (buttonType == XLComposeToolbarButtonTypeCamera) {
        [self openCamera];
    }else if(buttonType == XLComposeToolbarButtonTypePicture){
        [self openPicture];
    }
}
/**
 *  打开照相机
 */
- (void)openCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
/**
 *  打开相册
 */
- (void)openPicture
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

/**
 *  imagepicker代理方法
 *
 *  @param picker
 *  @param info
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.销毁pick 控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    //2.取到的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photoView addImage:image];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location >= 140) {
        return NO;
    }
    return YES;
}

@end
