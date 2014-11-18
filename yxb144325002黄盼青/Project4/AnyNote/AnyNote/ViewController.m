//
//  ViewController.m
//  AnyNote
//
//  Created by 黄盼青 on 14/11/17.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //按照日期排序从数据库加载数据
    _noteData=[[NSMutableArray alloc]initWithArray:[NoteData MR_findAllSortedBy:@"date" ascending:NO]];
    
    //测试插入数据
//    NoteData *myNote=[NoteData MR_createEntity];
//    myNote.type=@"画板";
//    myNote.date=[NSDate new];
//    myNote.contents=@"笔记内容";
//    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
//    [_noteData addObject:myNote];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _noteData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
    NoteData *_cellData=_noteData[indexPath.row];
    cell.type.text=_cellData.type;
    
    if([_cellData.type isEqualToString:@"笔记"]){
        cell.cellImg.image=[UIImage imageNamed:@"cell-word"];
    }
    if([_cellData.type isEqualToString:@"图片"]){
        cell.cellImg.image=[UIImage imageNamed:@"cell-picture"];
    }
    if([_cellData.type isEqualToString:@"照片"]){
        cell.cellImg.image=[UIImage imageNamed:@"cell-photo"];
    }
    if([_cellData.type isEqualToString:@"画板"]){
        cell.cellImg.image=[UIImage imageNamed:@"cell-paint"];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy年MM月dd日 HH:mm:ss"];
    cell.date.text=[dateFormatter stringFromDate:_cellData.date];
    
    
    return cell;
}

//获取图片
- (IBAction)pickPhotos:(UIBarButtonItem *)sender {
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    
    if([sender.title isEqualToString:@"图片"])
    {
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else{
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            
        }else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"很遗憾!" message:@"无法开启摄像头!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    
    picker.delegate=self;
    [self presentViewController:picker animated:YES completion:nil];
}

//Segue传递参数
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *dest=[segue.destinationViewController topViewController];
    
    //创建笔记
    if([segue.identifier isEqualToString:@"createNote"])
    {
        [dest setValue:self forKey:@"delegate"];
    }
    //修改笔记
    if([segue.identifier isEqualToString:@"editNote"]){
        [dest setValue:sender forKey:@"currentNote"];
        [dest setValue:self forKey:@"delegate"];
    }
    //查看图片
    if([segue.identifier isEqualToString:@"imageView"]){
        [dest setValue:sender forKey:@"currentNote"];
        [dest setValue:self forKey:@"delegate"];
    }
    //绘图
    if([segue.identifier isEqualToString:@"paintView"]){
        [dest setValue:self forKey:@"delegate"];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteData *note=_noteData[indexPath.row];
    if([note.type isEqualToString:@"笔记"])
        [self performSegueWithIdentifier:@"editNote" sender:indexPath];
    else
        [self performSegueWithIdentifier:@"imageView" sender:_noteData[indexPath.row]];
}

//TableCell左滑删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //左滑删除
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        NoteData *note=[_noteData objectAtIndex:indexPath.row];
        [note MR_deleteEntity];
        
        //判断如果是内容是图片的话，删除图片
        if([note.type isEqualToString:@"图片"] || [note.type isEqualToString:@"照片"]){
            
            [[NSFileManager defaultManager]removeItemAtPath:note.contents error:nil];
            
        }
        
        [_noteData removeObjectAtIndex:indexPath.row];
        [_tableView reloadData];
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    }
}

//ImagePicker选定图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *_photo=[info valueForKey:@"UIImagePickerControllerOriginalImage"];


    
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[path objectAtIndex:0];
    NSString *dataFilePath=[documentPath stringByAppendingPathComponent:[self createUUID]];
    dataFilePath=[dataFilePath stringByAppendingString:@".png"];
    
    //输出PNG文件，写入Documents内
    [UIImagePNGRepresentation(_photo) writeToFile:dataFilePath atomically:YES];
    
    NoteData *note=[NoteData MR_createEntity];
    
    if(picker.sourceType==UIImagePickerControllerSourceTypeCamera)
        note.type=@"照片";
    else
        note.type=@"图片";
    
    note.date=[NSDate date];
    note.contents=dataFilePath;
    [_noteData insertObject:note atIndex:0];
    
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [_tableView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//生成UUID
- (NSString *)createUUID
{
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
    CFRelease(uuidObject);
    return uuidStr;
}

@end
