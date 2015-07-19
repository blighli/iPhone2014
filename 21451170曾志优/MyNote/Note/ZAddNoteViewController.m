//
//  ZAddNoteViewController.m
//  Note
//
//  Created by Mac on 14-11-21.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZAddNoteViewController.h"
#import "MasterViewController.h"


#import <sqlite3.h>
#import "NoteRecord.h"

#import "DBHelper.h"
@interface ZAddNoteViewController ()
- (void)configureView;
@end

@implementation ZAddNoteViewController


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_topic isExclusiveTouch]) {
        [_topic resignFirstResponder];
    }
    if (![_content isExclusiveTouch]) {
        [_content resignFirstResponder];
    }
}

 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView
{
    self.topic.text=self.paramTopic;
    self.content.text = self.paramContent;

}
- (void)setDetailItem:(id)record
{
    NoteRecord *noteRecord =(NoteRecord *)record;
    self.paramTopic=noteRecord.topicStr;
    self.paramContent = noteRecord.contentStr;
    [self configureView ];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/






- (IBAction)saveButtonPressed:(UIButton *)sender {
    
    NSString *topicStr=_topic.text;
    NSString *contentStr=_content.text;
    
    sqlite3 *database = [DBHelper getDatabase];
    NSString *insertSQL = @"insert into notes(topic,content) values(?,?)";
    sqlite3_stmt *statement;
    char *errorMsg;
    
    if(sqlite3_prepare_v2(database, [insertSQL UTF8String], -1,&statement, nil)==SQLITE_OK){
        sqlite3_bind_text(statement,1,[topicStr UTF8String],-1,NULL);
        sqlite3_bind_text(statement,2,[contentStr UTF8String],-1,NULL);
    }
    if(sqlite3_step(statement)!=SQLITE_DONE){
        NSAssert(0,@"Error inserting table : %s",errorMsg);
    }
    sqlite3_finalize(statement);
    [DBHelper closeDatabase:database];

    
}
@end
