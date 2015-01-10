//
//  noteDetailViewController.m
//  evernote
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "noteDetailViewController.h"
#import "noteViewController.h"

@interface noteDetailViewController ()

@end

@implementation noteDetailViewController
@synthesize textView;
@synthesize head;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    textView.layer.borderColor=[UIColor grayColor].CGColor;
    textView.layer.borderWidth =1.0;
    textView.layer.cornerRadius =5.0;
    
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
//    noteViewController *note=[[noteViewController alloc]init];
    [contentList addObject:head.text];
    

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *user = [NSEntityDescription
                             insertNewObjectForEntityForName:@"User"
                             inManagedObjectContext:context];
    [user setValue:head.text forKey:@"name"];
    [user setValue:textView.text forKey:@"content"];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"添加成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
   
    
       NSLog(@"dsd");
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self performSegueWithIdentifier:@"returntonote" sender:nil];
    NSLog(@"as");
}
@end
