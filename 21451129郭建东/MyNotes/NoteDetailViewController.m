//
//  NoteDetailViewController.m
//  MyNotes
//
//  Created by cstlab on 14/11/11.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "NoteTableViewController.h"


@interface NoteDetailViewController ()<UIAlertViewDelegate>
@property UITextView *mytextView;
@end

@implementation NoteDetailViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mytextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, 310, 320)];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSString *oldtext = [array objectAtIndex:self.index];
    self.mytextView.text = oldtext;
    UIBarButtonItem *savebtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveclicked)];
    UIBarButtonItem *delbtn = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteclicked)];
    NSArray *bararray = [NSArray arrayWithObjects:delbtn,savebtn, nil];
    self.navigationItem.rightBarButtonItems = bararray;
    [self.view addSubview:self.mytextView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)saveclicked{
    NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSMutableArray *mutableArray = [tempArray mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *now = [NSDate date];
    NSString *datestring = [dateFormatter stringFromDate:now];
    NSString *textstring = [self.mytextView text];
    [mutableArray removeObjectAtIndex:self.index];
    [mutableArray insertObject:textstring atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
    NoteTableViewController *rootctrl = [[NoteTableViewController alloc]init];
    rootctrl.noteArray = mutableArray;
    
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    [mutableDateArray removeObjectAtIndex:self.index];
    [mutableDateArray insertObject:datestring atIndex:0 ];
    rootctrl.dateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    [self.mytextView resignFirstResponder];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"保存成功!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)deleteclicked{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定要删除该文件?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
        NSMutableArray *mutableArray = [tempArray mutableCopy];
        [mutableArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
        NoteTableViewController *rootctrl = [[NoteTableViewController alloc]init];
        rootctrl.noteArray = mutableArray;
        
        NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
        NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
        [mutableDateArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
        rootctrl.dateArray = mutableDateArray;
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (buttonIndex == 1) return;
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
