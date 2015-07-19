//
//  MyViewController.m
//  MyNotes
//
//  Created by 樊博超 on 14-11-21.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "MyViewController.h"
#import "NoteData.h"
@interface MyViewController ()

@end

@implementation MyViewController


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem* tbi = [self tabBarItem];
        [tbi setTitle:@"编辑文字"];
        
        UIImage* image = [UIImage imageNamed:@"text.png"];
        
        [tbi setImage:image];
    }
    db = [[Database alloc] init];

    
    CGRect nameField = CGRectMake(10, 80, 200, 31);
    textNameView = [[UITextField alloc] initWithFrame:nameField];
    [textNameView setPlaceholder:@"输入名字"];
    [textNameView setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:textNameView];
    
    
    
    
    

    CGRect fieldFrame = CGRectMake(10, 120, 350, 800);
    contentView =[[UITextView alloc] initWithFrame:fieldFrame];
    
    [contentView setText:@"写下你的笔记"];
    [contentView setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:20.00]];
    [self.view addSubview:contentView];
    
    CGRect buttonFrame = CGRectMake(228, 80, 72, 31);
    clear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clear setFrame:buttonFrame];
    [clear setTitle:@"Clear" forState:UIControlStateNormal];
    [clear addTarget:self
              action:@selector(clearText:)
                forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clear];
    
    CGRect saveFrame = CGRectMake(288, 80, 72, 31);
    save = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [save setFrame:saveFrame];
    [save setTitle:@"Save" forState:UIControlStateNormal];
    [save addTarget:self
              action:@selector(saveText:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:save];
    
    return self;
}

-(void)setItem:(NoteData *)item{
    _item = item;
    textNameView.text = _item.name;
    [db openDatabase];
    [db createTable];
    NoteData * temp = [[db queryLine:item.type withname:item.name] objectAtIndex:0];
    contentView.text = temp.content;
    [db closeDatabase];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // if (![_item.name isEqualToString:@""]) {
        textNameView.text = _item.name;
   // }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clearText:(id)sender{
    NSLog(@"clear text");
    contentView.text = @"";
    //textNameView.text = _item.name;
    return;
}

-(IBAction)saveText:(id)sender{
    NSLog(@"save text");
    [db openDatabase];
    [db createTable];
    [db insertTable:textNameView.text withtext:contentView.text];
    [db closeDatabase];
    return;
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
