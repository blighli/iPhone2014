//
//  AddViewController.m
//  MyNotes
//
//  Created by cstlab on 14/11/11.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "AddViewController.h"
#import "NoteTableViewController.h"

@interface AddViewController ()
@property UITextView *mytextview;
@end

@implementation AddViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // [self.mytextview =[[UITextView alloc]initWithFrame:CGRectMake(10, 0, 310, 320)];
    self.mytextview = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, 310, 320)];
     [self.view addSubview:self.mytextview];
     [self.mytextview becomeFirstResponder];
     UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveClick)];
     self.navigationItem.rightBarButtonItem = saveItem;
    // Do any additional setup after loading the view.
}
-(void)saveClick
{
    NSMutableArray *initNoteArray = [[NSMutableArray alloc]init];
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"note"] ==nil)
    {
        [[NSUserDefaults standardUserDefaults]setObject:initNoteArray forKey:@"note"];
    }
    NSArray *tempNoteArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"note"];
    NSMutableArray *mutableNoteArray = [tempNoteArray mutableCopy];
    NSString *textstring = [self.mytextview text];
    [mutableNoteArray insertObject:textstring atIndex:0];
    NoteTableViewController *noteCtrl = [[NoteTableViewController alloc]init];
    noteCtrl.noteArray = mutableNoteArray;
    [[NSUserDefaults standardUserDefaults]setObject:mutableNoteArray forKey:@"note"];
    
    
    //时间记录
    NSMutableArray *initDateArray = [[NSMutableArray alloc]init];
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"date"]==nil)
    {
        [[NSUserDefaults standardUserDefaults]setObject:initDateArray forKey:@"date"];
        
    }
    
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"date"];
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *now = [NSDate date];
    NSString *datestring = [dateFormatter stringFromDate:now];
    [mutableDateArray insertObject:datestring atIndex:0];
    noteCtrl.dateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults]setObject:mutableDateArray forKey:@"date"];
    
    
    [self.mytextview resignFirstResponder];
    UIAlertView *alartView = [[UIAlertView alloc]initWithTitle:nil message:@"保存完成!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alartView show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
