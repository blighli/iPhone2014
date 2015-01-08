//
//  FirstViewController.m
//  Homework4
//
//  Created by 李丛笑 on 14/11/23.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import "FirstViewController.h"
//#import "SecondTableViewController.h"
#import "DB.h"
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
@synthesize thisnumber;
@synthesize thiscount;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titlebox.text = thistitle;
    textbox.text = thistext;
  //  NSLog(thistext);
    
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


- (IBAction)save:(id)sender {
    DB *db = [[DB alloc]init];
    [db CreateDB];
    if (thistitle == nil) {
        [db InsertDB:[thiscount intValue] Title:titlebox.text Text:textbox.text];
    }
    else
        [db updateData:[thisnumber intValue] Newtitle:titlebox.text Newtext:textbox.text];
 
    [self.navigationController popViewControllerAnimated:YES];
    }
//   

-(NSArray *)gettexts
{
    return texts;
}

-(NSArray *)gettitles
{
    return titles;
}

@end
