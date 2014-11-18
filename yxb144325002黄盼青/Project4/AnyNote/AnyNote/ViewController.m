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
@end
