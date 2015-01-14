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
#import "Data.h"
#import "DBHelper.h"
#import "GTMBase64.h"
#import "GTMDefines.h"


@interface CameraViewController ()

@end

@implementation CameraViewController
@synthesize imagecount;
@synthesize imageTitle;
@synthesize imageBox;
//int i = 0;
 //NSMutableArray *results;
NSMutableString *results;
NSMutableString *contentid;
NSMutableArray *images;
NSMutableArray *datas;

DBHelper *db;
- (void)viewDidLoad {
    [super viewDidLoad];
    results = [[NSMutableString alloc]init];
    datas = [[NSMutableArray alloc]init];
    images = [[NSMutableArray alloc]init];
    db = [[DBHelper alloc]init];
    [db CreateDB];
    datas = [db QueryDB];
    for (int i = 0; i<[datas count]; i++) {
        Data *data = [datas objectAtIndex:i];
        if ([data.contentid hasSuffix:@"0"]) {
            [datas removeObjectAtIndex:i];
            i--;
            continue;
        }
        if ([[data.contentid substringToIndex:[data.contentid length]-2] isEqualToString:imagecount]) {
            imageTitle.text = data.title;
            if([data.text length]>0){
                [results appendString:data.text];
                [results appendString:@" "];
            }
            break;
        }
    }

    

   // results = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    NSMutableArray *itembutton = [[NSMutableArray alloc]init];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"存储"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(saveContent:)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(addContent:)];
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"删除"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(deleteContent:)];
    
    [itembutton addObject:saveButton];
    [itembutton addObject:addButton];
    [itembutton addObject:deleteButton];
    
    self.navigationItem.rightBarButtonItems = itembutton;
}

-(void)saveContent:(UIBarButtonItem *)sender{
    [db CreateDB];
    contentid = [[NSMutableString alloc]init];
    [contentid appendString:imagecount];
    [contentid appendString:@" 1"];
    NSString *insertresult = [db InsertDB:contentid Title:imageTitle.text Text:results];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)addContent:(UIBarButtonItem *)sender{
    UIActionSheet* mySheet = [[UIActionSheet alloc]
                              initWithTitle:@"选择背景"
                              delegate:self
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"打开本地相册",@"打开照相机", @"转向绘图",nil];
    [mySheet showInView:self.view];
}

-(void)deleteContent:(UIBarButtonItem *)sender{
    [db CreateDB];
    contentid = [[NSMutableString alloc]init];
    [contentid appendString:imagecount];
    [contentid appendString:@" 1"];
    [db deleteData:contentid];
    datas = [db QueryDB];
    for (int i = 0; i<[datas count]; i++) {
        Data *data = [datas objectAtIndex:i];
        if([data.contentid hasSuffix:@"1"] ){
        int textid = [[data.contentid substringToIndex:[data.contentid length]-2] intValue];
        if (textid>[imagecount intValue]) {
            NSMutableString *newcontentid = [[NSMutableString alloc]init];
            NSMutableString *oldcontentid = [[NSMutableString alloc]init];
            [oldcontentid appendString:[NSString stringWithFormat:@"%d",textid]];
            [oldcontentid appendString:@" 1"];
            [newcontentid appendString:[NSString stringWithFormat:@"%d",textid-1]];
            [newcontentid appendString:@" 1"];
            [db deleteData:oldcontentid];
            [db CreateDB];
            [db InsertDB:newcontentid Title:data.title Text:data.text];
        }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex

{
    if (buttonIndex == 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentModalViewController:picker animated:YES];


    }
    if (buttonIndex == 1) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            //设置拍照后的图片可被编辑
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            [self presentModalViewController:picker animated:YES];
        }else
        {
            
            NSLog(@"模拟其中无法打开照相机,请在真机中使用");
            
        }

            }
    if (buttonIndex == 2) {
        [self performSegueWithIdentifier:@"toDraw" sender:self];
        
    }
    
    
}


-(void)viewDidAppear:(BOOL)animated
{
    
    if([results length]>0){
    images = [results componentsSeparatedByString:@" "];
    [images removeObject:@""];
    for(int i = 0;i<[images count];i++)
    {
        
    NSData *temp = [GTMBase64 decodeString:[images objectAtIndex:i]];
    
    UIImageView *smallimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80+350*i, 350, 350)] ;
    
    smallimage.image = [UIImage imageWithData:temp];
    //加在视图中
    [self.view addSubview:smallimage];
    }}

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
               NSString *result = [GTMBase64 stringByEncodingData:data];
        [results appendString:result];
        [results appendString:@" "];
        [picker dismissModalViewControllerAnimated:YES];
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
       
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
    
    

}
@end
