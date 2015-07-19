//
//  TextEditViewController.m
//  MyNotes
//
//  Created by 焦守杰 on 14/11/14.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "TextEditViewController.h"
#import "sqlite3.h"
#define DBNAME    @"db.sqlite"
#define TIME      @"time"
#define TYPE       @"Type"
#define NOTE   @"note"
#define TABLENAME @"NoteInfo"
#define TEXTDATA  @"0"


@implementation TextEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dbu=[[DatabaseUtil alloc]init];
    [_textView becomeFirstResponder];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickSaveButton:(id)sender {
    NSString *str=[_textView text];
    NSString *s=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([s length]!=0){
        [_dbu saveToDatabase:s withType:@"0"];
 //       NSLog(@"%@",str);
     }
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

- (IBAction)clickCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}





@end
