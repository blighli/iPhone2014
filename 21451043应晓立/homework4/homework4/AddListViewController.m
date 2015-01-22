//
//  AddListViewController.m
//  homework4
//
//  Created by yingxl1992 on 14/11/20.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "AddListViewController.h"


@implementation AddListViewController
@synthesize pic;
@synthesize noteList;

- (void)viewDidLoad {
    if (noteList!=nil) {
        _tf_title.text=noteList.title;
        _tv_content.text=noteList.content;
        _imageView.image=[UIImage imageWithData:noteList.image];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] init];
    saveBarButtonItem.title = @"保存";
    saveBarButtonItem.target = self;
    saveBarButtonItem.action = @selector(saveNote);
    
    UIBarButtonItem *photoBarButtonItem = [[UIBarButtonItem alloc] init];
    photoBarButtonItem.title = @"拍照";
    photoBarButtonItem.target = self;
    photoBarButtonItem.action = @selector(addPhoto);
    
    UIBarButtonItem *picBarButtonItem = [[UIBarButtonItem alloc] init];
    picBarButtonItem.title = @"手绘";
    picBarButtonItem.target = self;
    picBarButtonItem.action = @selector(addPic);
    
    self.navigationItem.leftBarButtonItem=saveBarButtonItem;
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:photoBarButtonItem,picBarButtonItem,nil];
    
    if (noteList!=nil) {
        _tf_title.text=noteList.title;
        _tv_content.text=noteList.content;
        _imageView.image=[UIImage imageWithData:noteList.image];
    }
}

- (void)addPhoto {
    [self performSegueWithIdentifier:@"photoSegue" sender:self];
}

- (void)addPic {
    [self performSegueWithIdentifier:@"picSegue" sender:self];
}

- (void)saveNote {
    NoteList *list=noteList;
    list.title=[_tf_title text];
    list.content=[_tv_content text];
    list.image=UIImagePNGRepresentation(_imageView.image);
    list.addtime=[NSString stringWithFormat:@"%@",[NSDate date]];
    
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO NOTELIST(addtime,title,content,image) VALUES(?,?,?,?)"];
    [self executeSQLOper:sql withNote:list];

    
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"添加成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    [alertView show];
    
    [_tf_title setText:@""];
    [_tv_content setText:@""];
    _imageView.image=nil;
    noteList=nil;
}

- (void)executeSQLOper:(NSString *)sql withNote:(NoteList *)list{
    if (database==nil) {
        NoteDB *noteDB=[[NoteDB alloc]init];
        database=[noteDB getDB];
    }
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database,[sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [list.addtime UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [list.title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [list.content UTF8String], -1, NULL);
        sqlite3_bind_blob(stmt, 4, [list.image bytes], (int)[list.image length], NULL);
    }
    if (sqlite3_step(stmt) != SQLITE_DONE) NSLog(@"This should be real error checking!");
    sqlite3_close(database);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (noteList==nil) {
        noteList=[[NoteList alloc]init];
    }
    noteList.title=_tf_title.text;
    noteList.content=_tv_content.text;
    
    UIViewController *viewController=segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"picSegue"]==YES) {
        PicViewController *picViewController=(PicViewController *)viewController;
        picViewController.noteList=noteList;
    }
    else if([segue.identifier isEqualToString:@"photoSegue"]==YES){
        PhotoViewController *photoViewController=(PhotoViewController *)viewController;
        photoViewController.noteList=noteList;
    }
}

@end


