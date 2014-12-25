//
//  SendViewController.m
//  HVeBo
//
//  Created by HJ on 14/12/18.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "SendViewController.h"
#import "NSString+MJ.h"
#import "UIButton+HJ.h"
#import "UIViewExt.h"
#import "UIViewController+MMDrawerController.h"
#import "HttpTool.h"
#import "nearByViewController.h"
#import "WBNavigationController.h"
#import "RightViewController.h"
#import "AppDelegate.h"

@interface SendViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CGFloat _keyboardHight;
}
@property (nonatomic, copy)NSString *longitude;
@property (nonatomic, copy)NSString *latitude;
@property (nonatomic, strong)NSMutableArray *buttons;
@property (nonatomic, strong)UIImage *sendImage;//发送的图片
@property (nonatomic, strong)UIButton *sendImageButton;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIButton *deleteButton;
@end


@implementation SendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboaedShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发微博";
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sentAction)];
    self.navigationItem.rightBarButtonItem = right;

    
    [self _initView];
    if (_openTag == 2) {
        [self presentImagePicker];
    }
    if (_openTag == 3) {
        [self presentImagePicker];
    }
    if (_openTag == 5) {
        [self locationPresent];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.sendTextView becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.sendTextView resignFirstResponder];
}
- (void)_initView
{
    _buttons = [NSMutableArray array];
    NSArray *imageNames = [NSArray arrayWithObjects:
                           @"compose_locatebutton_background.png",
                           @"compose_camerabutton_background.png",
                           @"compose_trendbutton_background.png",
                           @"compose_mentionbutton_background.png",
                           @"compose_emoticonbutton_background.png",
                           @"compose_keyboardbutton_background.png"
                           ,
                           nil];

    for (int i = 0; i < imageNames.count; i++) {
        UIButton *button = [UIButton itemWithIcon:imageNames[i] highlightedIcon:[imageNames[i] fileAppend:@"_highlighted"] target:self action:@selector(buttonAction:)];
        button.tag = 10 + i;
        
        CGFloat w = [UIScreen mainScreen].bounds.size.width / 5;
        
        button.frame = CGRectMake(w*i+20, 28, 23, 19);
        [self.editorBar addSubview:button];
        
        if (i == 5) {
            button.hidden = YES;
            CGRect f = button.frame;
            f.origin.x -= w;
            button.frame = f;
        }
        [_buttons addObject:button];
    }
    UIImage *image = [self.placeBcakgroundView.image stretchableImageWithLeftCapWidth:30 topCapHeight:0];
    self.placeBcakgroundView.image = image;
    self.placeBcakgroundView.width = [UIScreen mainScreen].bounds.size.width;
    self.placeLabel.left = 35;
    self.placeLabel.width = [UIScreen mainScreen].bounds.size.width - 40;
}
#pragma mark - 监听键盘将要弹出
- (void)keyboaedShowNotification:(NSNotification *)notification
{
    NSValue *keyboardValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [keyboardValue CGRectValue];
    _keyboardHight = frame.size.height;
    
    self.editorBar.bottom = [UIScreen mainScreen].bounds.size.height - _keyboardHight;
    self.sendTextView.height = self.editorBar.top;
}

#pragma mark - 键盘上方bar
- (void)buttonAction:(UIButton *)button
{
    if (button.tag == 10) {
        [self locationPresent];
    }
    if (button.tag == 11) {
        [self selectImage];
    }
    if (button.tag == 12) {
        _sendTextView.text = [NSString stringWithFormat:@"%@##",_sendTextView.text];
        NSRange range = _sendTextView.selectedRange;
        range.location -= 1;
        _sendTextView.selectedRange = range;
    }
    if (button.tag == 13) {
        _sendTextView.text = [NSString stringWithFormat:@"%@@",_sendTextView.text];
    }
    if (button.tag == 14) {
        
    }
    
}
#pragma mark - 位置
- (void)locationPresent
{
    NearByViewController *near = [[NearByViewController alloc]init];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:near];
    [self presentViewController:nav animated:YES completion:nil];
    near.selectDownBlock = ^(NSDictionary *result){
        UIButton *locationButton = [_buttons objectAtIndex:0];
        if (result!=nil) {
            _longitude = result[@"lon"];
            _latitude = result[@"lat"];
            NSString *address = result[@"title"];
            if ([address isKindOfClass:[NSNull class]]||address.length == 0) {
                address = result[@"address"];
            }
            if ([address isKindOfClass:[NSNull class]]||address.length == 0) {
                address = result[@"poi_street_address"];
            }
            if (address.length > 0) {
                self.placeLabel.text = address;
                self.placeLabel.hidden = NO;
                locationButton.selected = YES;
            }
        }else{
            self.placeLabel.text = nil;
            self.placeLabel.hidden = YES;
            locationButton.selected = NO;
        }
        
    };
    
}
#pragma mark - 选择图片
- (void)selectImage
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"用户相册", nil];
    [actionSheet showInView:self.view];
}
#pragma mark - actionSheet 代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    
    if (buttonIndex == 0) {//拍照
        BOOL isCamera =  [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"此设备没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        _sorceType = UIImagePickerControllerSourceTypeCamera;
    }else if(buttonIndex == 1){//相册
        _sorceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }else{//取消
        return;
    }
    [self presentImagePicker];
}
- (void)presentImagePicker
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = _sorceType;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - UIImagePickerController代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _sendImage =  [info objectForKey:UIImagePickerControllerOriginalImage];
    if (_sendImageButton == nil) {
        _sendImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendImageButton.layer.cornerRadius = 5;
        _sendImageButton.layer.masksToBounds = YES;
        _sendImageButton.frame = CGRectMake(5, 23, 25, 25);
        [_sendImageButton addTarget:self action:@selector(imageAction) forControlEvents:UIControlEventTouchUpInside];
    }
    [_sendImageButton setImage:_sendImage forState:UIControlStateNormal];
    [self.editorBar addSubview:_sendImageButton];

    UIButton *button1 = [_buttons objectAtIndex:0];
    UIButton *button2 = [_buttons objectAtIndex:1];
    if (button1.frame.origin.x == 20) {
        [UIView animateWithDuration:0.5 animations:^{
            [UIView setAnimationDelay:0.5];
            button1.transform = CGAffineTransformTranslate(button1.transform, 20, 0);
            button2.transform = CGAffineTransformTranslate(button2.transform, 5, 0);
        }];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 图片点击放大事件
- (void)imageAction
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, _keyboardHight + 30,25,25)];
        _imageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImageViewAction:)];
        [_imageView addGestureRecognizer:tapGesture];
        //创建删除按钮
        _deleteButton = [UIButton itemWithIcon:@"camera_delete.png" highlightedIcon:@"camera_delete_highlighted@.png" target:self action:@selector(deleteAction)];
        _deleteButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 42, 20, 32, 32);
        _deleteButton.hidden = YES;
        _deleteButton.backgroundColor = [UIColor grayColor];
        [_imageView addSubview:_deleteButton];
    }
    if (![_imageView superview]) {
        _imageView.image = _sendImage;
        [self.sendTextView resignFirstResponder];
        [self.view.window addSubview:_imageView];
        [UIView animateWithDuration:0.4 animations:^{
            _imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        } completion:^(BOOL finsh){
            _deleteButton.hidden = NO;
        }];
        
    }
}
#pragma mark - 缩小图片
- (void)scaleImageViewAction:(UIGestureRecognizer *)tap
{
    _deleteButton.hidden = YES;
    [UIView animateWithDuration:0.4 animations:^{
        _imageView.frame = CGRectMake(5, _keyboardHight + 30,25,25);
    } completion:^(BOOL finished) {
        [_imageView removeFromSuperview];
    }];
    [_sendTextView becomeFirstResponder];
}
#pragma mark - 删除图片
- (void)deleteAction
{
    [self scaleImageViewAction:nil];
    [_sendImageButton removeFromSuperview];
    _sendImage = nil;
    UIButton *button1 = [_buttons objectAtIndex:0];
    UIButton *button2 = [_buttons objectAtIndex:1];
    [UIView animateWithDuration:0.5 animations:^{
        button1.transform = CGAffineTransformIdentity;
        button2.transform = CGAffineTransformIdentity;
    }];
}
#pragma mark - 发微博
- (void)sentAction
{
    NSString *text = self.sendTextView.text;
    if (text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"微博内容为空!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (text.length > 140) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"内容大于140字!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [super showStatuxsTip:YES title:@"发送中..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
    //[params setObject:text forKey:@"status"];
    //[params setObject:@"1" forKey:@"visible"];
    if (_latitude.length > 0 && _longitude.length > 0)
    {
        [params setObject:_longitude forKey:@"long"];
        [params setObject:_latitude forKey:@"lat"];
    }
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];

    WBImageObject *image = [WBImageObject object];
    image.imageData = UIImageJPEGRepresentation(_sendImage, 1);
    if (myDelegate.wbtoken != nil) {
        [WBHttpRequest requestForShareAStatus:text contatinsAPicture:image orPictureUrl:nil withAccessToken:myDelegate.wbtoken andOtherProperties:params queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
            if (!error) {
                [super showStatuxsTip:NO title:@"发送成功"];
            }else{
                [super showStatuxsTip:NO title:@"发送失败"];
            }
            
        }];
    }else{
        [super showStatuxsTip:NO title:@"发送失败"];
    }

//    [HttpTool wbHttpRequest:@"statuses/update.json" httpMethod:@"POST" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
//        if (!error) {
//            [super showStatuxsTip:NO title:@"发送成功"];
//            
//        }else{
//            [super showStatuxsTip:NO title:@"发送失败"];
//        }
//    }];
    
}

@end
