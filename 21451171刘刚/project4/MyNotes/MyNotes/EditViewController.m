//
//  EditViewController.m
//  MyNotes
//
//  Created by liug on 14-11-22.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import "EditViewController.h"
#import "CreateViewController.h"
@interface EditViewController ()

@end

@implementation EditViewController
@synthesize notetitle,notes,ttile,tnotes;
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
    UIBarButtonItem *saveButton=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem=saveButton;
    notetitle.text=ttile;
    notes.text=tnotes;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)save{
    CreateViewController *cvc=[[CreateViewController alloc]init];
    [cvc openDB];
    [cvc deleteRecordfromTableNamed:@"MyNotes" withField1:@"title" field1Value:ttile];
    [cvc insertRecordIntoTableNamed:@"MyNotes" withField1:@"title" field1Value:[notetitle text] andField2:@"notes" field2Value:[notes text]];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
