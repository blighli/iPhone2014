//
//  ViewController.m
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/18.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <GPUImage/GPUImage.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "ViewController.h"
#import "PhotoPickerViewController.h"
#import "PhotoBeautify.h"
#import "DesignView.h"
#import "ImageDisplayedView.h"

static const NSArray *arrFilter;

@interface ViewController ()
{
    NSInteger lastImageViewTag;
    NSInteger lastEffectTag;
    NSInteger lastFrameTag;
    NSInteger lastTextTag;
    NSMutableArray *effectsValue;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *firstNavigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UISlider *firstSlider;
@property (retain, nonatomic) ImageDisplayedView *secondImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *firstFilterScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *firstCompileScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *firstFrameScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *firstTextScrollView;
@property (retain, nonatomic) IBOutlet UINavigationItem *firstNavigationItem;
@property (retain, nonatomic) UIImageView *firstTappedLayer;
@property (weak, nonatomic) IBOutlet UITabBarItem *firstSpecialEffectsTabBarItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *firstCompileTabBarItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *firstFrameTabBarItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *firstTextTabBarItem;
@property (weak, nonatomic) IBOutlet UIImageView *firstAddImageView;
@property (weak, nonatomic) IBOutlet UITabBar *firstTabBar;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *firstVisualEffectView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *firstActivityIndicatorView;
@property (retain, nonatomic) UIButton *cancelButton;
@property (retain, nonatomic) UIButton *doneButton;
@property (retain, nonatomic) CATransition *animationPushUp;
@property (retain, nonatomic) CATransition *animationPushDown;
@property (retain, nonatomic) UIImageView *paintView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建一个导航栏集合
    self.firstNavigationItem = [[UINavigationItem alloc] initWithTitle:@"图片美化"];
    
    //创建一个左边按钮
    self.firstNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                                               target:self
                                                                                               action:@selector(clickCameraButton:)];
    
    
    //创建右边按钮
    self.firstNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                                target:self
                                                                                                action:@selector(clickActionButton:)];
    
    //右边按钮不可用
    self.firstNavigationItem.rightBarButtonItem.enabled = NO;
    
    [self.firstNavigationBar pushNavigationItem:self.firstNavigationItem animated:NO];
    
    //ActivityIndicator风格
    self.firstActivityIndicatorView.backgroundColor = [UIColor darkGrayColor];
    self.firstActivityIndicatorView.alpha = 0.5f;
    
    //设置ScorllView风格
    [DesignView initScrollViewStyle:self.firstFilterScrollView];
    [DesignView initScrollViewStyle:self.firstCompileScrollView];
    [DesignView initScrollViewStyle:self.firstFrameScrollView];
    [DesignView initScrollViewStyle:self.firstTextScrollView];
    
    //为滚动条上的边框图添加点击事件
    for(UIView *subViewOnScrollView in [self.firstCompileScrollView subviews])
    {
        if([subViewOnScrollView isKindOfClass:[UIImageView class]])
        {
            //添加点击手势识别，来处理选择的边框图片
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchEffectsOnScrollView:)];
            recognizer.numberOfTouchesRequired = 1;
            recognizer.numberOfTapsRequired = 1;
            [subViewOnScrollView setUserInteractionEnabled:YES];
            [subViewOnScrollView addGestureRecognizer:recognizer];
        }
    }
    for(UIView *subViewOnScrollView in [self.firstFrameScrollView subviews])
    {
        if([subViewOnScrollView isKindOfClass:[UIImageView class]])
        {
            //添加点击手势识别，来处理选择的边框图片
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchFrameOnScrollView:)];
            recognizer.numberOfTouchesRequired = 1;
            recognizer.numberOfTapsRequired = 1;
            [subViewOnScrollView setUserInteractionEnabled:YES];
            [subViewOnScrollView addGestureRecognizer:recognizer];
        }
    }
    for(UIView *subViewOnScrollView in [self.firstTextScrollView subviews])
    {
        if([subViewOnScrollView isKindOfClass:[UIImageView class]])
        {
            //添加点击手势识别，来处理选择的边框图片
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTextOnScrollView:)];
            recognizer.numberOfTouchesRequired = 1;
            recognizer.numberOfTapsRequired = 1;
            [subViewOnScrollView setUserInteractionEnabled:YES];
            [subViewOnScrollView addGestureRecognizer:recognizer];
        }
    }
    
    //将图片按照比例显示在imageView中
    [DesignView initImageViewStyle:self.firstImageView];
    
    //设置scrollview上点击图片后出现的子视图
    self.firstTappedLayer = [DesignView initTappedLayerStyle];
    
    
    //设置TabBarItem点击后的图片与字体颜色
    [DesignView initTabBarItemSelectedStyle:self.firstSpecialEffectsTabBarItem withSelectedImage:@"SpecialEffectsSelected"];
    [DesignView initTabBarItemSelectedStyle:self.firstCompileTabBarItem withSelectedImage:@"CompileSelected"];
    [DesignView initTabBarItemSelectedStyle:self.firstFrameTabBarItem withSelectedImage:@"FrameSelected"];
    [DesignView initTabBarItemSelectedStyle:self.firstTextTabBarItem withSelectedImage:@"TextSelected"];
    
    
    //AddButton注册点击事件
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAddButton:)];
    recognizer.numberOfTouchesRequired = 1;
    recognizer.numberOfTapsRequired = 1;
    [self.firstAddImageView setUserInteractionEnabled:YES];
    [self.firstAddImageView addGestureRecognizer:recognizer];
    
    //tabbar的代理人是自己
    self.firstTabBar.delegate = self;
    
    //动作栏按钮与事件响应
    self.cancelButton = [DesignView initButtonOnvisualEffectView:self.cancelButton IndexofButton:0];
    self.doneButton = [DesignView initButtonOnvisualEffectView:self.doneButton IndexofButton:1];
    [self.cancelButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.doneButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.firstVisualEffectView addSubview:self.cancelButton];
    [self.firstVisualEffectView addSubview:self.doneButton];
    self.firstVisualEffectView.hidden = YES;
    
    //PushUp动画效果
    self.animationPushUp = [CATransition animation];
    [self.animationPushUp setDuration:0.35f];
    [self.animationPushUp setFillMode:kCAFillModeForwards];
    [self.animationPushUp setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [self.animationPushUp setType:kCATransitionPush];
    [self.animationPushUp setSubtype:kCATransitionFromTop];
    
    //PushDown动画效果
    self.animationPushDown = [CATransition animation];
    [self.animationPushDown setDuration:0.35f];
    [self.animationPushDown setFillMode:kCAFillModeForwards];
    [self.animationPushDown setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [self.animationPushDown setType:kCATransitionPush];
    [self.animationPushDown setSubtype:kCATransitionFromBottom];
    
    //初始化滤镜数组
    [PhotoBeautify initialize];
    
    //初始化tappedImageViewTag
    lastImageViewTag = 0;
    lastEffectTag = 0;
    lastFrameTag = 0;
    lastTextTag = 0;
    
    //初始化滤镜效果
    arrFilter = @[@"素描",@"卡通",@"马赛克",@"同心圆",@"线性",@"日光",@"光晕",@"漩涡",@"水晶球",@"印象",@"底片",@"浮雕",@"圆点",@"点染"];
    effectsValue = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithDouble:0], [NSNumber numberWithDouble:0], [NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:0], nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    //修改状态栏文字颜色
    return UIStatusBarStyleLightContent;
}

- (IBAction)clickCameraButton:(id)sender
{
    //点击相机按钮的
    //显示操作表单
    //显示操作表单
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"照相机",@"图片库",nil];
    
    actionSheet.tag = 201;
    [actionSheet showInView:self.view];
    actionSheet = nil;
}

- (IBAction)clickActionButton:(id)sender
{
    //保存图片
    
    NSArray *activityItems;
    
    activityItems = @[self.image];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [self presentViewController:activityController  animated:YES completion:nil];
    //UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
//- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
//{
//    
//    NSString *msg = nil ;
//    
//    if(error != NULL)
//    {
//        msg = @"保存图片失败" ;
//    }
//    else
//    {
//        msg = @"保存图片成功" ;
//    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                    message:msg
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//    alert = nil;
//}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //ActionSheet按钮响应
    if(actionSheet.tag == 201)
    {
        if(buttonIndex == 0)
        {
            //调取照相机
            [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
        }
        else if(buttonIndex == 1)
        {
            PhotoPickerViewController *photoPicker = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoPicker"];
            
            //将自己设为PhotoPickerViewController的委托人
            photoPicker.delegate = self;
            
            self.lastChosenMediaType = [NSString stringWithFormat:@"%@",[NSNull null]];
            
            [self presentViewController:photoPicker animated:YES completion:NULL];
        }
    }
}

- (IBAction)clickedButton:(UIButton *)button
{
    if(button.tag == 601)
    {
        //还原
        
        self.secondImageView.image = self.image;
        
        //将上次点击的滤镜选择ImageView边框置为黑色,并还原数据
        if(lastImageViewTag !=0)
        {
            [self.firstFilterScrollView viewWithTag:lastImageViewTag].layer.borderColor = [[UIColor blackColor] CGColor];
            [self.firstTappedLayer removeFromSuperview];
            lastImageViewTag = 0;
        }
        
        //去除边框
        if(lastFrameTag != 0)
        {
            UIImageView *imageView = (UIImageView *)[self.secondImageView viewWithTag:lastFrameTag];
            [imageView removeFromSuperview];
            lastFrameTag = 0;
        }
        
        //还原画布
        self.paintView.image = nil;
        lastTextTag = 0;
        
        //还原编辑效果
        lastEffectTag = 0;
        [effectsValue removeAllObjects];
        [effectsValue addObject:[NSNumber numberWithDouble:0]];
        [effectsValue addObject:[NSNumber numberWithDouble:0]];
        [effectsValue addObject:[NSNumber numberWithDouble:0.5]];
        [effectsValue addObject:[NSNumber numberWithDouble:0.5]];
        [effectsValue addObject:[NSNumber numberWithDouble:0]];
        
        //隐藏控件
        if(self.firstSlider.hidden == NO)
        {
            self.firstSlider.hidden = YES;
        }
    }
    else if (button.tag == 602)
    {
        //保存
        
        CGRect rect = CGRectMake(0,0,self.image.size.width,self.image.size.height);
        
        UIGraphicsBeginImageContext(self.image.size);
        
        //将图片，边框和涂鸦绘制在一起
        [self.secondImageView.image drawInRect:rect];
        if(self.paintView.image != nil)
        {
            [self.paintView.image drawInRect:rect];
        }
        if(lastFrameTag != 0)
        {
            UIImageView *imageView = (UIImageView *)[self.secondImageView viewWithTag:lastFrameTag];
            [imageView.image drawInRect:rect];
        }
        
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
        self.image = nil;
        self.image = resultImage;
        UIGraphicsEndImageContext();
        
        resultImage = nil;
        
        [self setPhoto:self.image];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"保存成功"
                                                       delegate:self cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        
        [alert show];
        alert = nil;
        

    }
}

#pragma mark -  SetPhotoDelegate methods

- (void)setPhoto:(UIImage *)photo
{
    //委托人实现委托方法
    
    //显示背景照片
    self.image = photo;
    self.firstImageView.image = self.image;

    //移除firstImageView上所有的subview
    for(UIView *subView in [self.firstImageView subviews])
    {
        [subView removeFromSuperview];
    }
    
    //创建毛玻璃效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame =CGRectMake(0,0, self.firstImageView.frame.size.width,self.firstImageView.frame.size.height);
    [self.firstImageView addSubview:effectview];
    effectview = nil;
    
    //显示要美化的图片(按比例缩放至imageView内）
    self.secondImageView = nil;
    self.secondImageView = [[ImageDisplayedView alloc] initWithFrameForImage:self.image inImageView:self.firstImageView];
    self.secondImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.secondImageView.backgroundColor = [UIColor clearColor];
    self.secondImageView.image = self.image;
    [self.firstImageView addSubview:self.secondImageView];
    
    //添加画布
    //初始化画布
    self.paintView = nil;
    self.paintView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.secondImageView.frame.size.width, self.secondImageView.frame.size.height)];
    self.paintView.backgroundColor = [UIColor clearColor];
    self.paintView.image = nil;
    [self.secondImageView addSubview:self.paintView];
    
    //显示scrollView上的图片
    [self setPhotoOnScrollView:self.secondImageView.image];
    
    //设置控件可用状态
    self.firstNavigationItem.rightBarButtonItem.enabled = YES;
    self.firstSpecialEffectsTabBarItem.enabled = YES;
    self.firstCompileTabBarItem.enabled = YES;
    self.firstFrameTabBarItem.enabled = YES;
    self.firstTextTabBarItem.enabled = YES;
    
    //重置数据
    lastImageViewTag = 0;
    lastEffectTag = 0;
    lastFrameTag = 0;
    lastTextTag = 0;
    [effectsValue removeAllObjects];
    [effectsValue addObject:[NSNumber numberWithDouble:0]];
    [effectsValue addObject:[NSNumber numberWithDouble:0]];
    [effectsValue addObject:[NSNumber numberWithDouble:0.5]];
    [effectsValue addObject:[NSNumber numberWithDouble:0.5]];
    [effectsValue addObject:[NSNumber numberWithDouble:0]];
    
    //隐藏控件
    self.firstSlider.hidden = YES;
    self.firstVisualEffectView.hidden = YES;
    self.firstFilterScrollView.hidden = YES;
    self.firstCompileScrollView.hidden = YES;
    self.firstFrameScrollView.hidden = YES;
    self.firstTextScrollView.hidden = YES;
}

- (void)setPhotoOnScrollView:(UIImage *)photo
{
    //把所有的显示效果图添加到scrollView里面
    
    //移除firstFilterScrollView上所有的subview
    for(UIView *subView in [self.firstFilterScrollView subviews])
    {
        [subView removeFromSuperview];
    }
    
    //给scrollView创建薄膜里效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame =CGRectMake(0, 0, 1200, 90);
    self.firstFilterScrollView.backgroundColor = [UIColor clearColor];
    [self.firstFilterScrollView addSubview:effectview];
    effectview = nil;
    
    //缩小图片
    UIImage *scaledPhoto = [PhotoBeautify scaleImage:photo];
    
    //计算x坐标
    float x = 10;
    for(int i=0;i<arrFilter.count;i++)
    {
        x = 69*i+10;
        
        //添加名字标签
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 55, 50, 20)];
        [label setText:[arrFilter objectAtIndex:i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:12.0f]];
        [label setTextColor:[UIColor blackColor]];
        
        //添加滤镜效果图片
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 5, 50, 50)];
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        bgImageView.clipsToBounds = YES;
        
        //设置圆形半径和边框、颜色
        bgImageView.layer.masksToBounds = YES;
        bgImageView.layer.cornerRadius = 25;
        bgImageView.layer.borderWidth = 1;
        bgImageView.layer.borderColor = [[UIColor blackColor] CGColor];
        
        //为每个滤镜图片设置tag
        int tag = i+100;
        [bgImageView setTag:tag];
        
        //添加点击手势识别，来处理选择的滤镜图片
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchPhotoOnScrollView:)];
        recognizer.numberOfTouchesRequired = 1;
        recognizer.numberOfTapsRequired = 1;
        [bgImageView setUserInteractionEnabled:YES];
        [bgImageView addGestureRecognizer:recognizer];
        
        //将渲染后的图片添加至scrollview中
        [self.firstFilterScrollView addSubview:label];
        [self.firstFilterScrollView addSubview:bgImageView];
        if(i == 0)
        {
            if(self.firstTappedLayer.superview != nil)
            {
                [self.firstTappedLayer removeFromSuperview];
            }
        }

        bgImageView.image = [PhotoBeautify setFilter:scaledPhoto atIndex:tag];
        
        label = nil;
        bgImageView = nil;
        recognizer = nil;

    }
         
    //设置滚动视图的实际大小 , 决定你是否可以水平或垂直方向拉动
    self.firstFilterScrollView.contentSize = CGSizeMake(x+60, 80);
}

- (IBAction)touchPhotoOnScrollView:(UITapGestureRecognizer *)sender
{
    //scrollview上滤镜选择
    
    if(sender.view.tag != lastImageViewTag)
    {
        //将上次点击的滤镜选择ImageView边框置为黑色
        [self.firstFilterScrollView viewWithTag:lastImageViewTag].layer.borderColor = [[UIColor blackColor] CGColor];
        
        [self.firstTappedLayer removeFromSuperview];
        [sender.view addSubview:self.firstTappedLayer];
        
        //将选择后的边框置为橘色
        sender.view.layer.borderColor = [[UIColor orangeColor] CGColor];
        
        
        //显示ActivityIndicator并且开始旋转
        self.firstActivityIndicatorView.hidden = NO;
        [self.firstActivityIndicatorView startAnimating];
        
        //线程处理
        [NSThread detachNewThreadSelector:@selector(processImage:)
                                 toTarget:self
                               withObject:[NSNumber numberWithInteger:sender.view.tag]];

        lastImageViewTag = sender.view.tag;
        lastEffectTag = 0;
        [effectsValue removeAllObjects];
        [effectsValue addObject:[NSNumber numberWithDouble:0]];
        [effectsValue addObject:[NSNumber numberWithDouble:0]];
        [effectsValue addObject:[NSNumber numberWithDouble:0.5]];
        [effectsValue addObject:[NSNumber numberWithDouble:0.5]];
        [effectsValue addObject:[NSNumber numberWithDouble:0]];
    }
}

- (void)processImage:(NSNumber *)tag
{
    //处理图像
    self.secondImageView.image = [PhotoBeautify setFilter:self.image atIndex:[tag integerValue]];
    
    //停止旋转并隐藏ActivityIndicator
    [self.firstActivityIndicatorView stopAnimating];
}

- (IBAction)touchEffectsOnScrollView:(UITapGestureRecognizer *)sender
{
    if(self.firstSlider.hidden == YES)
    {
        self.firstSlider.hidden = NO;
    }
    
    lastEffectTag = sender.view.tag;
    [self.firstSlider setValue:[[effectsValue objectAtIndex:lastEffectTag - 120] doubleValue]];

}

- (IBAction)touchFrameOnScrollView:(UITapGestureRecognizer *)sender
{
    //边框选择
    
    if(lastFrameTag != 0)
    {
        UIImageView *imageView = (UIImageView *)[self.secondImageView viewWithTag:lastFrameTag];
        [imageView removeFromSuperview];
        lastFrameTag = 0;
    }
    
    //130是无边框
    if(sender.view.tag != 130)
    {
        
        //根据图片的imageview来确定位置和大小
    
        UIImageView *tappedView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.secondImageView.frame.size.width, self.secondImageView.frame.size.height)];
        
        tappedView.image = [UIImage imageNamed:[NSString stringWithFormat:@"frame%ld",sender.view.tag-(long)130]];
        tappedView.tag = sender.view.tag +111;
        lastFrameTag = tappedView.tag;
        [self.secondImageView addSubview:tappedView];
        tappedView = nil;
    }
}
- (IBAction)touchTextOnScrollView:(UITapGestureRecognizer *)sender
{
    lastTextTag = sender.view.tag;
}

- (void)touchAddButton:(UITapGestureRecognizer *)sender
{
    PhotoPickerViewController *photoPicker = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoPicker"];
    
    //将自己设为PhotoPickerViewController的委托人
    photoPicker.delegate = self;
    
    self.lastChosenMediaType = [NSString stringWithFormat:@"%@",[NSNull null]];
    
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

#pragma  mark -- UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)Item
{
    //移除动画效果
    [self.firstFilterScrollView.layer removeAllAnimations];
    [self.firstCompileScrollView.layer removeAllAnimations];
    [self.firstFrameScrollView.layer removeAllAnimations];
    [self.firstTextScrollView.layer removeAllAnimations];
    [self.firstVisualEffectView.layer removeAllAnimations];
    
    if(self.firstSlider.hidden == NO)
    {
        self.firstSlider.hidden =YES;
    }
    
    //委托事件，点击tabBarItem时调用
    if(Item.tag == 301)
    {
        if(self.firstFilterScrollView.hidden == YES)
        {
            self.firstFilterScrollView.hidden = NO;
            self.firstCompileScrollView.hidden = YES;
            self.firstFrameScrollView.hidden = YES;
            self.firstTextScrollView.hidden = YES;
            
            if(self.firstVisualEffectView.hidden == YES)
            {
                self.firstVisualEffectView.hidden = NO;
                [self.firstVisualEffectView.layer addAnimation:self.animationPushDown forKey:nil];
            }
            
            //加入动画
            [self.firstFilterScrollView.layer addAnimation:self.animationPushUp forKey:nil];
            
        }
        else
        {
            self.firstFilterScrollView.hidden = YES;
            self.firstVisualEffectView.hidden = YES;
            
            //加入动画
            [self.firstFilterScrollView.layer addAnimation:self.animationPushDown forKey:nil];
            [self.firstVisualEffectView.layer addAnimation:self.animationPushUp forKey:nil];
        }
    }
    else if (Item.tag == 302)
    {
        if(self.firstCompileScrollView.hidden == YES)
        {
            self.firstFilterScrollView.hidden = YES;
            self.firstCompileScrollView.hidden = NO;
            self.firstFrameScrollView.hidden = YES;
            self.firstTextScrollView.hidden = YES;
            
            if(self.firstVisualEffectView.hidden == YES)
            {
                self.firstVisualEffectView.hidden = NO;
                [self.firstVisualEffectView.layer addAnimation:self.animationPushDown forKey:nil];
            }
            
            //加入动画
            [self.firstCompileScrollView.layer addAnimation:self.animationPushUp forKey:nil];
        }
        else
        {
            self.firstCompileScrollView.hidden = YES;
            self.firstVisualEffectView.hidden = YES;
            
            //加入动画
            [self.firstCompileScrollView.layer addAnimation:self.animationPushDown forKey:nil];
            [self.firstVisualEffectView.layer addAnimation:self.animationPushUp forKey:nil];
        }
    }
    else if (Item.tag == 304)
    {
        if(self.firstFrameScrollView.hidden == YES)
        {
            self.firstFilterScrollView.hidden = YES;
            self.firstCompileScrollView.hidden = YES;
            self.firstFrameScrollView.hidden = NO;
            self.firstTextScrollView.hidden = YES;
            
            if(self.firstVisualEffectView.hidden == YES)
            {
                self.firstVisualEffectView.hidden = NO;
                [self.firstVisualEffectView.layer addAnimation:self.animationPushDown forKey:nil];
            }
            
            //加入动画
            [self.firstFrameScrollView.layer addAnimation:self.animationPushUp forKey:nil];
        }
        else
        {
            self.firstFrameScrollView.hidden = YES;
            self.firstVisualEffectView.hidden = YES;
            
            //加入动画
            [self.firstFrameScrollView.layer addAnimation:self.animationPushDown forKey:nil];
            [self.firstVisualEffectView.layer addAnimation:self.animationPushUp forKey:nil];
        }
    }
    else if (Item.tag == 305)
    {
        if(self.firstTextScrollView.hidden == YES)
        {
            self.firstFilterScrollView.hidden = YES;
            self.firstCompileScrollView.hidden = YES;
            self.firstFrameScrollView.hidden = YES;
            self.firstTextScrollView.hidden = NO;
            
            if(self.firstVisualEffectView.hidden == YES)
            {
                self.firstVisualEffectView.hidden = NO;
                [self.firstVisualEffectView.layer addAnimation:self.animationPushDown forKey:nil];
            }
            
            //加入动画
            [self.firstTextScrollView.layer addAnimation:self.animationPushUp forKey:nil];
        }
        else
        {
            self.firstTextScrollView.hidden = YES;
            self.firstVisualEffectView.hidden = YES;
            
            //加入动画
            [self.firstTextScrollView.layer addAnimation:self.animationPushDown forKey:nil];
            [self.firstVisualEffectView.layer addAnimation:self.animationPushUp forKey:nil];
        }
    }
}

#pragma  mark -- Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //开始触摸
    if(self.firstTextScrollView.hidden == NO)
    {
        UITouch *touch = [touches anyObject];
        if([touch tapCount] == 2)
        {
            self.paintView.image = nil;
            return;
        }

        UIGraphicsBeginImageContext(self.paintView.frame.size);
        [self.paintView.image drawInRect:CGRectMake(0, 0, self.paintView.frame.size.width, self.paintView.frame.size.height)];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //滑动触摸
    if(self.firstTextScrollView.hidden == NO)
    {
        UITouch *touch = [touches anyObject];
        CGPoint currentLocation = [touch locationInView:self.secondImageView];
        CGPoint pastLocation = [touch previousLocationInView:self.secondImageView];
        
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
        switch (lastTextTag)
        {
            case 140:
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
                break;
            case 141:
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.5, 0.5, 0.5, 1.0);
                break;
            case 142:
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 1.0, 0.0, 1.0);
                break;
            case 143:
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
                break;
            case 144:
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 1.0, 1.0);
                break;
            case 145:
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.6, 0.4, 0.2, 1.0);
                break;
            case 146:
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.5, 0.0, 1.0);
                break;
            case 147:
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.5, 0.0, 0.5, 1.0);
                break;
            case 148:
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);
                break;
            default:
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 0.0);
                break;
        }
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), pastLocation.x, pastLocation.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentLocation.x, currentLocation.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.paintView.image = UIGraphicsGetImageFromCurrentImageContext();
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //结束触摸
    if(self.firstTextScrollView.hidden == NO)
    {
        UIGraphicsEndImageContext();
    }
}

- (IBAction)changeEffectsValue:(id)sender
{
    //slider移动事件
    
    //将上次点击的滤镜选择ImageView边框置为黑色
    [self.firstFilterScrollView viewWithTag:lastImageViewTag].layer.borderColor = [[UIColor blackColor] CGColor];
    
    [self.firstTappedLayer removeFromSuperview];
    
     UISlider *slider = (UISlider *)sender;
    
    [effectsValue removeObjectAtIndex:lastEffectTag - 120];
    [effectsValue insertObject:[NSNumber numberWithDouble:[slider value]] atIndex:lastEffectTag - 120];
    
    self.firstActivityIndicatorView.hidden = NO;
    [self.firstActivityIndicatorView startAnimating];
    self.firstSlider.enabled = NO;
    lastImageViewTag = 0;
    
    //线程处理
    [NSThread detachNewThreadSelector:@selector(processEffexts)
                             toTarget:self
                           withObject:nil];
    
   
}

- (void)processEffexts
{
    self.secondImageView.image = self.image;
    
    for(int i=0; i<5; i++)
    {
        self.secondImageView.image = [PhotoBeautify setEffect:self.secondImageView.image atIndex:i+120 byValue:[[effectsValue objectAtIndex:i] doubleValue]];
    }
    
    [self.firstActivityIndicatorView stopAnimating];
    self.firstSlider.enabled = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //视图每次被显示时调用
    
    //上次选择的是图像
    
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage])
    {
        [super viewDidAppear:animated];
        [self updateDisplay];
    }
}

- (void)updateDisplay
{
    [self setPhoto:self.image];
}

- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    //创建并配置一个图像选取器.sourceType来确定应该显示照相机还是媒体库
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    //指定源类型前，检查图片源是否可用
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0)
    {
        //创建图片选择器
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        //指定源类型
        picker.sourceType = sourceType;
        
        
        if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
        {
            picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage,nil];
        }
        else
        {
            picker.mediaTypes = mediaTypes;
        }
        
        //实现委托
        picker.delegate = self;
        
        //图片不可编辑
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.lastChosenMediaType = info[UIImagePickerControllerMediaType];
    
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage])
    {
        //获取整张图片
        UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
        self.image = [PhotoBeautify shrinkImage:chosenImage toSize:self.firstImageView.frame.size];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
