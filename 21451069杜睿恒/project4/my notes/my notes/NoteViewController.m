//
//  NoteViewController.m
//  my notes
//
//  Created by shazhouyouren on 14/11/15.
//  Copyright (c) 2014年 shazhouyouren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteViewController.h"
@interface NoteViewController ()

@end

@implementation NoteViewController

@synthesize textView;
@synthesize noteDB;
@synthesize tvText;
@synthesize editable;
@synthesize noteid;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isModify = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    textView.text = tvText;
    //tvText = @"";
    textView.editable = editable;
}

-(void)initNewNote{
    UIBarButtonItem *btSave = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(saveNote:)];
    UIBarButtonItem *btBack = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = btBack;
    self.navigationItem.rightBarButtonItem = btSave;
    //[self showToolBar];
}

-(void)initViewNote{
    UIBarButtonItem *btEdit = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(editNote:)];
    UIBarButtonItem *btBack = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.rightBarButtonItem = btEdit;
    self.navigationItem.leftBarButtonItem = btBack;
    
}
-(void)saveNote:(id)sender{
    NSString* text = textView.text;
    NSDate * date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateStr = [dateFormatter stringFromDate:date];
    NSString *title =dateStr;
    title = [title stringByAppendingString:@" "];
    if([text length] >20){
        title = [title stringByAppendingString:[ text substringToIndex:10]];
    }
    else{
        title = [title stringByAppendingString:text];
    }
    if(!isModify && ![text isEqualToString:@""]){
        [noteDB insertNote:title withType:1 withTime:dateStr withText:text];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_RELOAD"
                                                            object:nil];
        [self.navigationController popViewControllerAnimated:true];
    }
    else if(isModify && ![text isEqualToString:tvText]){
        [noteDB updateNote:noteid withTitle:title withType:1 withTime:dateStr withText:text];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_RELOAD"
                                                            object:nil];
        [self.navigationController popViewControllerAnimated:true];
    }
}

-(void)editNote:(id)sender{
    UIBarButtonItem *btSave = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(saveNote:)];
    self.navigationItem.rightBarButtonItem = btSave;
    textView.editable = true;
    editable = true;
    isModify = true;
   // [self showToolBar];
}
-(void)back:(id)sender{
    if (tvText!=nil ) {
        if (![tvText isEqualToString:textView.text]) {
            //提示保存
            [self showAlert];
        }
        //否则返回上一页
        else{
            [self.navigationController popViewControllerAnimated:true];
        }
    }
    else{
        if (![textView.text isEqualToString:@""]) {
            //提示保存
            [self showAlert];
        }
        //否则返回上一页
        else{
            [self.navigationController popViewControllerAnimated:true];
        }
    }
}
-(void)showAlert{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"内容尚未保存，确定退出？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self.navigationController popViewControllerAnimated:true];
            break;
        default:
            break;
    }
}
-(void)pic:(id)sender{
    
}


-(void)showToolBar{
    self.navigationController.toolbarHidden=NO;
    UIBarButtonItem *btInsert = [[UIBarButtonItem alloc] initWithTitle:@"pic" style:UIBarButtonItemStylePlain target:self action:@selector(pic:)];
    self.toolbarItems = @[btInsert];
}

@end