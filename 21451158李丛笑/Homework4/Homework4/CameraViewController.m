//
//  CameraViewController.m
//  Homework4
//
//  Created by 李丛笑 on 14/12/10.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import "CameraViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>


@interface CameraViewController ()

@end

@implementation CameraViewController
int i = 0;
 NSMutableArray *results;
NSMutableArray *images;
- (void)viewDidLoad {
    [super viewDidLoad];
    UInt16 h = 6;
    UInt16 w = 6;
    for (UInt16 i = 0; i < h; i++) {
        //CGRectMake(X轴坐标,Y轴坐标,宽,高)
        for (UInt16 j = 0; j < w; j++) {
            //设置图片位置
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.imageScoller.frame.size.width * i, self.imageScoller.frame.size.height * j, self.imageScoller.frame.size.width,self.imageScoller.frame.size.height)];
            
            // 指定URL生成UIImage
            [button setTitle:@"按钮" forState:UIControlStateNormal]; //设置button的标题
            //[button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside]; //定义点击时的响应函数
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]] forState:UIControlStateNormal];
            [self.imageScoller addSubview:button];
        }
        
            }
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES  completion:NULL];
}
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
            data = UIImageJPEGRepresentation(image, 1.0);
        else
            data = UIImagePNGRepresentation(image);
        NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        [results addObject:result];
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
       
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        // for (int j = 0; results[j]!=nil; j++) {
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:[results[0] dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        //得到选择后沙盒中图片的完整路径
        NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        
        UIImageView *smallimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80+350*i, 350, 350)] ;
         i++;
        smallimage.image = image;
        //加在视图中
        [self.view addSubview:smallimage];
        //  }
       

        
            }
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);//系统默认不支持旋转功能
    //返回YES屏幕所有方向旋转都支持
    //return YES;
}

// 触摸屏幕来滚动画面还是其他的方法使得画面滚动，皆触发该函数
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"Scrolling...");
}

// 触摸屏幕并拖拽画面，再松开，最后停止时，触发该函数
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging  -  End of Scrolling.");
}

// 滚动停止时，触发该函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating  -   End of Scrolling.");
}

// 调用以下函数，来自动滚动到想要的位置，此过程中设置有动画效果，停止时，触发该函数
// UIScrollView的setContentOffset:animated:
// UIScrollView的scrollRectToVisible:animated:
// UITableView的scrollToRowAtIndexPath:atScrollPosition:animated:
// UITableView的selectRowAtIndexPath:animated:scrollPosition:
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation  -   End of Scrolling.");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)imageSave:(id)sender {
    
}

- (IBAction)addImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    
    picker.allowsEditing = YES;
    [self presentModalViewController:picker animated:YES];

    

}
@end
