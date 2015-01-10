//
//  testTransitionController.m
//  evernote
//
//  Created by apple on 14/11/22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "testTransitionController.h"
#import "noteViewController.h"

@interface testTransitionController ()

@end

@implementation testTransitionController
@synthesize textView;
@synthesize head;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"tableview");
    NSLog(@"%d",x);
    textView.layer.borderColor=[UIColor grayColor].CGColor;
    textView.layer.borderWidth =1.0;
    textView.layer.cornerRadius =5.0;
    head.text=[fetchedObjects[x] valueForKey:@"name"];
    textView.text=[fetchedObjects[x] valueForKey:@"content"];
    
    
//    self.title=@"asa";
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

- (IBAction)savenote:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
     NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [fetchedObjects[x] setValue:head.text forKey:@"name"];
    [fetchedObjects[x] setValue:textView.text forKey:@"content"];
    [contentList replaceObjectAtIndex:x withObject:head.text];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@,",error);
        abort();
    }
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    NSLog(@"updated");
    
}
@end
