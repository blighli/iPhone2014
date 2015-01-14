//
//  MainViewController.m
//  FinalProject
//
//  Created by 李丛笑 on 15/1/5.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import "MainViewController.h"
#import "SetButton.h"
#import "ViewController.h"
#import "DBHelper.h"
#import "CourseData.h"
#import "GTMBase64.h"
#import "GTMDefines.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize backgroundimageView;
int tableid=0;
NSArray *tablearray;
UIImage *mainbgimage;
CourseData *tabledata;
DBHelper *db;

- (void)viewDidLoad {
    [super viewDidLoad];
    db = [[DBHelper alloc]init];
    mainbgimage = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"theme_bg_01.png"]];
    [backgroundimageView setImage:mainbgimage];
}
-(void)viewDidAppear:(BOOL)animated{
    [self loadView];
    [db CreateTableDB];
   
    NSArray *tabledatas = [db QueryTableDB];
    for (int i = 0; i<[tabledatas count]; i++) {
        tabledata = [tabledatas objectAtIndex:i];
        [self createTableButton:[tabledata.classid intValue] Pos:i Tablename:tabledata.classname];
    }
}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
//}

- (void)createTableButton:(int)buttontag Pos:(int)pos Tablename:(NSString *)tablename{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:tablename forState: UIControlStateNormal];
    button.frame = CGRectMake(20.f+(pos%4)*100.f, +(pos/4+1)*70.f, 80.f, 60.f);;
    button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    [button setBackgroundImage:[UIImage imageWithData:[GTMBase64 decodeString:tabledata.classtime]] forState:UIControlStateNormal];
    button.clipsToBounds = YES;
    button.tag = buttontag;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(IBAction) buttonClicked:(UIButton *)sender {
     tableid =(int)sender.tag;
   [self performSegueWithIdentifier:@"toTableview" sender:self];
   
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController* view = segue.destinationViewController;
    NSString *ttag = [NSString stringWithFormat:@"%d",tableid];
    if ([segue.identifier isEqualToString:@"toTableview"]==YES) {
        ViewController *tableview =(ViewController *)view;
        [tableview setValue:ttag forKey:@"ttag"];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addTable:(id)sender {
//        for (int i=0; i<100; i++) {
//        NSString *tid = [NSString stringWithFormat:@"%d",i+1];
//        if (![tablearray containsObject:tid]) {
//            tableid = i+1;
//            break;
//        }
//    }
    [self performSegueWithIdentifier:@"toTableview" sender:self];
    
}
@end
