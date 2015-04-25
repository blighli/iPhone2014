//
//  PaintViewControlly.m
//  NOTEbook
//
//  Created by SXD on 14/12/3.
//  Copyright (c) 2014年 SXD. All rights reserved.
//

#import "PaintViewControlly.h"
#import "Paint.h"
#import "SqliteManage.h"
#import "detailViewController.h"


@interface PaintViewControlly ()
{
    SqliteManage *mySqliteManage;
    paintview *myPaintView;
}
@end

@implementation PaintViewControlly
- (void) viewDidLoad
{
    [super viewDidLoad];
    mySqliteManage = [SqliteManage sqliteManage];
    
    myPaintView = [[paintview alloc] initWithFrame:self.view.frame];
    myPaintView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myPaintView];
    
    UIBarButtonItem *clear = [[UIBarButtonItem alloc]initWithTitle:@"Clear" style:UIBarButtonItemStyleDone target:self action:@selector(clearAction:)];
    self.navigationItem.rightBarButtonItem = clear;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction:)];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void) clearAction: (id)sender
{
    [myPaintView clear:YES];
}
- (void) saveAction: (id)demder
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *paintImage = [myPaintView screenShot];
    [self.delegate passValue:paintImage];
    [self.navigationController popViewControllerAnimated:YES];
}
@end


