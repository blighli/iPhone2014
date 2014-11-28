//
//  cameraController.m
//  evernote
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "cameraController.h"
#import "photoCell.h"
@interface cameraController ()
{
    AppDelegate *appDelegate;
    int c;
    NSMutableArray *imgcontent;
    NSArray *fetchedobject;
}
@end
@implementation cameraController
@synthesize photoTable;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
     NSLog(@"photocontroller start");
//    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
    [self findobject];
    for (NSManagedObject *info in fetchedobject) {
        
        NSLog(@"Name: %@", [info valueForKey:@"imgname"]);
        
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [self findobject];
    [photoTable reloadData];
}

-(void)findobject
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];// 生成 context
    //查询
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Img" inManagedObjectContext:context];//生成 数据实体
    [fetchRequest setEntity:entity]; //设置数据查询的实体
    
    fetchedobject= [context executeFetchRequest:fetchRequest error:nil];

}

#pragma tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 1;
    NSLog(@"number of section");
    return [fetchedobject count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    photoCell *cell=[photoTable dequeueReusableCellWithIdentifier:@"photocell" forIndexPath:indexPath];
//    UITableViewCell *cell = [photoTable dequeueReusableCellWithIdentifier:@"photocell" forIndexPath:indexPath];
   // UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"photocell"];
//    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    cell.title.text=[NSString stringWithFormat:@"photo%ld",indexPath.row+1];
    NSString *imgname=[[fetchedobject valueForKey:@"imgname"]objectAtIndex:indexPath.row];
    //获取图片路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imgname]];
    
    // 添加 图片通过url获取
//    NSURL *url =[NSURL URLWithString:filePath];
//    NSData *imgdata=[NSData dataWithContentsOfURL:url];
    
    cell.imgview.image=[[UIImage alloc]initWithContentsOfFile:filePath];
//    cell.imgview.image=[UIImage imageNamed:[[fetchedobject valueForKey:@"imgname" ]objectAtIndex:indexPath.row]];
//    cell.textLabel.text=@"asa";
    
    NSLog(@"%f",cell.imgview.image.size.width);
    return cell;
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSString *imgname=[[fetchedobject valueForKey:@"imgname"]objectAtIndex:indexPath.row];
    //获取图片路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imgname]];
    [context deleteObject:[fetchedobject objectAtIndex:indexPath.row]];
    
        NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@,",error);
        abort();
    }
    NSLog(@"delete success");
    [self findobject];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    NSLog(@"delete file in sandbox");
    [photoTable deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationTop];
//    NSLog(@"real delete");
//    [photoTable reloadData]; //这两句不写 不会重新加载cell
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)takePhoto:(id)sender {
    c=1;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
    //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
    
}

- (IBAction)add:(id)sender {
    c=0;
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = NO;
    [self presentViewController:pickerImage animated:YES completion:nil];
   

}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   
    NSLog(@"wancheng photo");
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    NSString *imageName =[NSString stringWithFormat:@"%@",currentTime]; //用时间来命名图片的名字（实际上是url）
    NSLog(@"%@",info);
    UIImage *image = [info
                      objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // 如果是完成拍照模式
    if (c==1) {
        UIImageWriteToSavedPhotosAlbum(image, self,  nil, nil);//存到相簿
        [self saveToSandbox:image withimgname:imageName];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    else{
    //
        [self saveToSandbox:image withimgname:imageName];
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
        
    }

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)saveToSandbox:(UIImage *)image withimgname:(NSString*)imgname
{
    
    CGSize imagesize = image.size;
    imagesize.height =200;
    imagesize.width =200;
    //对图片大小进行压缩--
    image = [self imageWithImage:image scaledToSize:imagesize];
    //存到沙盒
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imgname]];   // 保存文件的名称
    
    BOOL result = [UIImagePNGRepresentation(image)writeToFile:filePath atomically:YES];
    
    
    //        NSLog(@"%hhd",result);//存储到沙盒则为1
    NSLog(@"%d",result);
    
    //把名字存到数据库
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *user = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Img"
                             inManagedObjectContext:context];
    [user setValue:imgname forKey:@"imgname"];
    
    NSError *error;
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        
    }
    NSLog(@" save img to database");

}
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


@end
