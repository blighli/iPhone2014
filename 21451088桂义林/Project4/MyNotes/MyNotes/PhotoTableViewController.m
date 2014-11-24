//
//  PhotoTableViewController.m
//  MyNotes
//
//  Created by YilinGui on 14-11-22.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import "PhotoTableViewController.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Note.h"
#import "EditPhotoViewController.h"

@interface PhotoTableViewController ()

@end

@implementation PhotoTableViewController

- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航栏标题
    self.navigationItem.title = @"Photo Notes";
    
    // 为导航栏添加一个右侧的Button Item
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(AddPhotoNotes)];
    self.navigationItem.rightBarButtonItem = item;
    
    // 初始化TableView
    photoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 360, self.view.frame.size.height - 44) style:UITableViewStylePlain];
    
    [self.view addSubview:photoTableView];
    [photoTableView setDataSource:self];    // 为UITableView设置数据源
    [photoTableView setDelegate:self];
    
    // 从数据库中读取所有type属性为"photo"的记录
    photoNotes = [[NSMutableArray alloc] initWithArray:[Note MR_findByAttribute:@"type" withValue:@"photo"]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 从数据库中读取所有type属性为"photo"的记录
    photoNotes = [[NSMutableArray alloc] initWithArray:[Note MR_findByAttribute:@"type" withValue:@"photo"]];
    [photoTableView reloadData];  // 重新加载TableView上的数据
}

// 设置TableView的section数量，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 设置TableView每个section的row数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [photoNotes count];
}

// 设置TableView上每个row上的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";  // cell的重用标识
    
    // 从队列中取出对应重用标识的cell对象
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 如果没有对应的cell对象，初始化
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    Note *note = photoNotes[indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    // 设置cell上的文字
    cell.textLabel.text = note.title;
    
    // 设置cell上的图片
    NSString* imageDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imageFilePath = [imageDirPath stringByAppendingString:note.message];
    cell.imageView.image = [UIImage imageWithContentsOfFile:imageFilePath];
    
    return cell;
}

// 选中TableView中的某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"section = %ld, row = %ld", indexPath.section, indexPath.row);
    EditPhotoViewController *editPhotoVC = [[EditPhotoViewController alloc] init];
    Note *note = [photoNotes objectAtIndex:[indexPath row]];
    [editPhotoVC passNote:note];
    [self.navigationController pushViewController:editPhotoVC animated:YES];
}

// 删除TableView中的一行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *note = [photoNotes objectAtIndex:indexPath.row];
        
        // 删除对应的图片文件
        NSString* imageDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *imageFilePath = [imageDirPath stringByAppendingString:note.message];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSError *err;
        [fileMgr removeItemAtPath:imageFilePath error:&err];
        
        [note MR_deleteEntity];  // 从数据库中删除数据
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        // 从数据库中读取所有type属性为"photo"的记录
        photoNotes = [[NSMutableArray alloc] initWithArray:[Note MR_findByAttribute:@"type" withValue:@"photo"]];
        [photoTableView reloadData];  // 重新加载TableView上的数据
    }
}

// 事件响应函数 -- 添加照片笔记
- (void)AddPhotoNotes {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"不支持拍照" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [self fixOrientation:image];  // 解决方向问题
    NSString* imageDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyyMMddHHmmss"];
    //NSLog(@"image Dir Path: %@", imageDirPath);
    
    Note *note = [Note MR_createEntity];
    //note.title = self.textField.text;
    note.date = [NSDate date];
    NSString *imageFilePath = [imageDirPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate: note.date], @"png"];
    //[self.doodleView saveToPNGFile:imageFilePath];
    //NSLog(@"%@", imageFilePath);
    [UIImagePNGRepresentation(image) writeToFile:imageFilePath atomically:YES];
    note.message = [NSString stringWithFormat:@"/%@.%@", [dateFormatter stringFromDate: note.date], @"png"];  // 图片的相对路径(这里就是文件名)
    note.title = [note.message substringFromIndex:1];
    note.type = @"photo";
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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

@end
