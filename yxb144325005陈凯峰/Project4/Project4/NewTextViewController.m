//
//  NewTextViewController.m
//  Project4
//
//  Created by jingcheng407 on 14-11-23.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import "NewTextViewController.h"
#import "MyNote.h"
#import "AppDelegate.h"

@interface NewTextViewController ()

@end

@implementation NewTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_num!=nil) {
        self.MyTextView.text=((MyNote*)[_param.TableViewListArray objectAtIndex:[_num integerValue]]).text;
        _SaveButton.enabled=FALSE;
    }else{
        
    }
    // Do any additional setup after loading the view.
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

- (IBAction)SaveButton:(id)sender {
    AppDelegate* myAppDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate] ;//获取委托
    
    MyNote *myNote = [NSEntityDescription insertNewObjectForEntityForName:@"MyNote" inManagedObjectContext:[myAppDelegate managedObjectContext]];
    myNote.text = _MyTextView.text;
    NSDateFormatter* nsdateformat=[[NSDateFormatter alloc] init];
    [nsdateformat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    myNote.time = [nsdateformat stringFromDate: [NSDate new]];
    myNote.type=@"text";
    NSError *error = nil;
    BOOL isSave =   [[myAppDelegate managedObjectContext] save:&error];
    if (!isSave) {
        NSLog(@"error:%@,%@",error,[error userInfo]);
    }
    else{
        NSLog(@"保存成功");
        [_param.TableViewListArray addObject:myNote];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
