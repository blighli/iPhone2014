//
//  CreateDrawViewController.m
//  MyNotes
//
//  Created by liug on 14-11-16.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import "CreateDrawViewController.h"
#import "CreateViewController.h"
#import "DrawView.h"
#import "sqlite3.h"

@interface CreateDrawViewController ()
@property  DrawView *dv;
@end

@implementation CreateDrawViewController

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
    
    self.dv=[[DrawView alloc]initWithFrame:self.view.bounds];
    self.dv.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.dv];
    [super viewDidLoad];    
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)save{
    CreateViewController *cvc=[[CreateViewController alloc]init];
    [cvc openDB];
    NSString* imageDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyyMMddHHmmss"];
    //NSLog(@"image Dir Path: %@", imageDirPath);
    
    NSString *imageFilePath = [imageDirPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate: [NSDate date]], @"png"];
    [self.dv getImageFromView:imageFilePath];
    
    [cvc insertDrawIntoTableNamed:@"MyDraws" withField1:@"path" field1Value:imageFilePath];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
