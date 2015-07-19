//
//  TextViewController.m
//  project4
//
//  Created by zack on 14-11-22.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import "TextViewController.h"
#import "ViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)save:(id)sender {
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:((ViewController*)_delegate).context];
    note.content = _textView.text;
    note.type = @"文本";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
    NSDate* nowDate = [NSDate new];
    note.time = [dateFormatter stringFromDate: nowDate];
    NSError *error = nil;
    if ([((ViewController*)_delegate).context save:&error]) {
        [((ViewController*)_delegate).notesArray addObject:note];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"保存成功");
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"保存失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
        NSLog(@"error:%@,%@",error,[error userInfo]);
    }
}
@end
