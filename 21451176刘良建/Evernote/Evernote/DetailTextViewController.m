//
//  DetailTextViewController.m
//  Evernote
//
//  Created by JANESTAR on 14-11-16.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//
#import "AppDelegate.h"
#import "DetailTextViewController.h"
#import "TextViewController.h"



@interface DetailTextViewController()

@end

@implementation DetailTextViewController{
    AppDelegate* appDelegate;
    NSManagedObjectContext* appContext;
    //TextViewController* tvc;
    
}
   

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    self.textView.textColor=[UIColor blackColor];
    self.textView.font=[UIFont fontWithName:@"Arial" size:18.0];
    self.textView.delegate=self;
    self.textView.backgroundColor=[UIColor whiteColor];
   // self.textView.text=@"fasdf fasdfdsf fsdfsfla kfsdklfasfdsaf";
    self.textView.returnKeyType=UIReturnKeyDefault;
    self.textView.keyboardType=UIKeyboardTypeDefault;
    self.textView.scrollEnabled=YES;
    self.textView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    UIBarButtonItem * done=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(savetext)];
    self.navigationItem.rightBarButtonItem=done;
        [self.view addSubview:self.textView];
    if(self.flag){
   // tvc=[self.navigationController.viewControllers objectAtIndex:0];
    
        self.textView.text=[self.txt content];
        self.flag=NO;
    // Do any additional setup after loading the view.
    }
    
    
   
}

-(void)savetext{
    appDelegate=[[UIApplication sharedApplication]delegate];
    appContext=[appDelegate managedObjectContext];
    if(!self.mark){
    NSManagedObject* textinfo=[NSEntityDescription insertNewObjectForEntityForName:@"Text" inManagedObjectContext:appContext];
    NSString* txt=self.textView.text;
    NSLog(@"hello world %@",txt);
    [textinfo setValue:txt forKey:@"content"];
    NSError* error;
    [appContext save:&error];
    if(error!=nil){
        NSLog(@"%@",error);
    }
    }else{
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Text" inManagedObjectContext:appContext];
        [request setEntity:entity];
        [request setReturnsObjectsAsFaults:NO];
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"self =%@",[self txt] ];
        [request setPredicate:predicate];
        NSArray *dataArray = [appContext executeFetchRequest:request error:nil];
        NSLog(@"count is %lu",(unsigned long)[dataArray count]);
        if ([dataArray count] > 0) {
            Text* text= [dataArray objectAtIndex:0];
            text.content=[self.textView text];
            NSError* error;
            [appContext save:&error];
            if (error!=nil) {
                 NSLog(@"%@",error);
            }else{
                NSLog(@"编辑成功");
            }
        }
        
        
      
    
    
    
    
    }
    //TextViewController * tvc=[self.navigationController.viewControllers objectAtIndex:0];
    [self.navigationController popViewControllerAnimated:YES ];
    //[self.navigationController popToViewController:tvc animated:YES];
   // [tvc.myTableView reloadData];
    //printf("endend\n");
     //[self.navigationController popToRootViewControllerAnimated:YES];
    
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
