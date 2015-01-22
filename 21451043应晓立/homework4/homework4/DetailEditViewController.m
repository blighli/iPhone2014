//
//  DetailEditViewController.m
//  homework4
//
//  Created by yingxl1992 on 14/11/16.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "DetailEditViewController.h"

@implementation DetailEditViewController

@synthesize currentNotelist;

- (void)viewWillAppear:(BOOL)animated {
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"保存";
    temporaryBarButtonItem.target = self;
    temporaryBarButtonItem.action = @selector(saveAndBack:);
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    [_tf_title setText:currentNotelist.title];
    [_tv_content setText:currentNotelist.content];
    _imageView.image=[[UIImage alloc]initWithData:currentNotelist.image];
    
    noteDB=[[NoteDB alloc]init];
    database=[noteDB getDB];
}

- (void)saveAndBack:(id)sender {
    
    [currentNotelist setTitle:[_tf_title text]];
    [currentNotelist setContent:[_tv_content text]];
    NSString *sql=[NSString stringWithFormat:@"UPDATE NOTELIST SET Title=?,Content=?,Image=? WHERE ID=%ld",(long)currentNotelist.Id];
    [self executeSQLOper:sql withNote:currentNotelist];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)executeSQLOper:(NSString *)sql withNote:(NoteList *)list{
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database,[sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [list.title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [list.content UTF8String], -1, NULL);
        sqlite3_bind_blob(stmt, 3, [list.image bytes], (int)[list.image length], NULL);
    }
    if (sqlite3_step(stmt) != SQLITE_DONE) NSLog(@"This should be real error checking!");
    sqlite3_close(database);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *viewController=segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"editImageSegue"]==YES) {
        EditImageViewController *editImageViewController=(EditImageViewController *)viewController;
        [editImageViewController setNoteList:currentNotelist];
    }
}

@end
