//
//  FirstViewController.m
//  Homework4
//
//  Created by 李丛笑 on 14/11/23.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import "FirstViewController.h"
//#import "SecondTableViewController.h"
#import "DBHelper.h"
#import "Data.h"
#import <sqlite3.h>
#define kFilename @"data.sqlite3"


@interface FirstViewController ()
@property (nonatomic, strong)SecondTableViewController *se;

@end

@implementation FirstViewController

@synthesize textbox;
@synthesize titlebox;
@synthesize thistitle;
@synthesize thistext;
@synthesize textcount;

NSMutableString *contentid;
NSMutableArray *datas;
DBHelper *db;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *itembutton = [[NSMutableArray alloc]init];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"存储"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                  action:@selector(saveContent:)];
   
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"删除"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(DeleteContent:)];
   
    [itembutton addObject:saveButton];
    [itembutton addObject:deleteButton];
    
    self.navigationItem.rightBarButtonItems = itembutton;
    
    
    db = [[DBHelper alloc]init];
    datas = [[NSMutableArray alloc]init];
    [db CreateDB];
     datas = [db QueryDB];
    for (int i = 0; i<[datas count]; i++) {
        Data *data = [datas objectAtIndex:i];
        if ([data.contentid hasSuffix:@"1"]) {
            [datas removeObjectAtIndex:i];
            i--;
            continue;
        }
        if ([[data.contentid substringToIndex:[data.contentid length]-2] isEqualToString:textcount]) {
            titlebox.text = data.title;
            textbox.text = data.text;
            break;
        }
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (SecondTableViewController *)se{
  if(!_se){
       _se = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
   }
    return _se;
    }

-(void)saveContent:(UIBarButtonItem *)sender{
    //DBHelper *db = [[DBHelper alloc]init];
    contentid = [[NSMutableString alloc]init];
    [contentid appendString:textcount];
    [contentid appendString:@" 0"];
    [db CreateDB];
    [db InsertDB:contentid Title:titlebox.text Text:textbox.text];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)DeleteContent:(UIBarButtonItem *)sender{
    [db CreateDB];
    contentid = [[NSMutableString alloc]init];
    [contentid appendString:textcount];
    [contentid appendString:@" 0"];
    [db deleteData:contentid];
    datas = [db QueryDB];
    for (int i = 0; i<[datas count]; i++) {
        Data *data = [datas objectAtIndex:i];
        if([data.contentid hasSuffix:@"0"]){
        int textid = [[data.contentid substringToIndex:[data.contentid length]-2] intValue];
        if (textid>[textcount intValue]) {
            NSMutableString *newcontentid = [[NSMutableString alloc]init];
            NSMutableString *oldcontentid = [[NSMutableString alloc]init];
            [oldcontentid appendString:[NSString stringWithFormat:@"%d",textid]];
            [oldcontentid appendString:@" 0"];
            [newcontentid appendString:[NSString stringWithFormat:@"%d",textid-1]];
            [newcontentid appendString:@" 0"];
            [db deleteData:oldcontentid];
            [db CreateDB];
            [db InsertDB:newcontentid Title:data.title Text:data.text];
        }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
