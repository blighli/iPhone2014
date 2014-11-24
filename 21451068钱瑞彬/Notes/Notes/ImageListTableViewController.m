//
//  ImageListTableViewController.m
//  Notes
//
//  Created by apple on 14-11-24.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import "ImageListTableViewController.h"
#import "ImageViewController.h"

@interface ImageListTableViewController ()

@end

@implementation ImageListTableViewController


// 目标窗体
ImageViewController* imageDest = nil;


- (NSString*)getNowDate {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString* timeString = [NSString stringWithFormat:@"%.0f", time]; //转为字符型
    return timeString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadListData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.imageItems count];
}


// 设置每一行的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"TableViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // 配置每一行
    NSString* toDoItem = [self.imageItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem;
    
    NSString* aPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), toDoItem];
    UIImage* image = [[UIImage alloc]initWithContentsOfFile:aPath];
    cell.imageView.image = image;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


// 选中某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 选中了哪一行, 进行修改
    self.selectedItem = (int)indexPath.row;
    if (imageDest != nil) {
        imageDest.barTitle.title = [self.imageItems objectAtIndex:self.selectedItem];
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

// 设置可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 删除一项
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 涂鸦图片的路径
        NSString* file = [self.imageItems objectAtIndex: indexPath.row];
        NSString* aPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), file];
        
        NSError* error = nil;
        if([[NSFileManager defaultManager] removeItemAtPath:aPath error:&error]) {
            NSLog(@"文件移除成功");
        }
        else {
            NSLog(@"error=%@", error);
        }
        
        [self.imageItems removeObjectAtIndex:indexPath.row];
        [self.imageItems writeToFile:[self docPath] atomically:YES];
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}


//获取应用程序沙盒的Documents目录
- (NSString*) docPath {
    NSArray* pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"Images.txt"];
    return path;
}



// 加载 todolist 的数据
- (void)loadListData {
    NSArray* plist = [NSArray arrayWithContentsOfFile:[self docPath]];
    
    if(plist) {
        self.imageItems = [plist mutableCopy];
    }
    else {
        self.imageItems = [[NSMutableArray alloc] init];
    }
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    imageDest = segue.destinationViewController;
}



- (IBAction)getphoto:(id)sender {
    UIImagePickerController* picker = [[UIImagePickerController alloc]init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    }
    else {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{}];
    [self.view addSubview:picker.view];
}


//保存获取的照片
-(void)saveImage:(UIImage*)image {
    //UIImageView* imageview = [[UIImageView alloc]initWithImage:image];
    NSString* file = [NSString stringWithFormat:@"%@.png", [self getNowDate]];
    NSString* aPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), file];
    NSData* imgData = UIImageJPEGRepresentation(image, 1.0);
    [imgData writeToFile:aPath atomically:YES];
    
    [self.imageItems addObject:file];
    [self.imageItems writeToFile:[self docPath] atomically:YES];
    [self.tableView reloadData];
}


//
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:)withObject:image afterDelay:0.5];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


@end

