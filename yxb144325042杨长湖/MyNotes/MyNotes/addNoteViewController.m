//
//  addNoteViewController.m
//  MyNotes
//
//  Created by 杨长湖 on 14/11/23.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import "addNoteViewController.h"
#import "sqlite3.h"

@interface addNoteViewController ()

@end

@implementation addNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dao = [[NoteDAO alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButten:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"close");}];
}

- (IBAction)creatNote:(id)sender {
    NSString *contents = self.content.text;
    if([contents length]!=0){
        NSLog(@"插入...");
        [_dao saveToDatabase:contents];
    }
    [self dismissViewControllerAnimated:YES completion:^{NSLog(@"close");}];
    //[self dismissViewControllerAnimated:YES completion:nil];
}
@end



