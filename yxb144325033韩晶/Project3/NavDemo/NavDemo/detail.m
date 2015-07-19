//
//  detail.m
//  notes
//
//  Created by hanxue on 14/11/17.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "detail.h"


@implementation Detailview

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"detail";
    CGRect textFrame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-200);
    textview=[[UITextView alloc] initWithFrame:textFrame];
    textview.delegate=self;
    textview.text=[NSString stringWithFormat:@"%ld",(long)_identify];
    textview.backgroundColor=[UIColor blackColor];
    textview.textColor=[UIColor whiteColor];
    textview.font=[UIFont fontWithName:@"Arial" size:18.0];
    textview.scrollEnabled=YES;
    [self.view addSubview:textview];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraBtn:)];
    
    
    NSMutableArray *buttons=[[NSMutableArray alloc]initWithCapacity:2];
    [buttons addObject:rightButton];
    [self.navigationItem setRightBarButtonItems:buttons animated:YES];
    
    imageBtn0=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGRect imageFrame0=CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width/4, self.view.frame.size.width/4);
    imageBtn0.hidden=YES;
    [imageBtn0 setTag:1];
    [imageBtn0 setFrame:imageFrame0];
    [imageBtn0 setBackgroundColor:[UIColor blueColor]];
    [imageBtn0 setTitle:@"" forState:UIControlStateNormal];
    [imageBtn0 addTarget:self action:@selector(imageBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageBtn0];
    
    imageBtn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGRect imageFrame1=CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height-200, self.view.frame.size.width/4, self.view.frame.size.width/4);
    imageBtn1.hidden=YES;
    [imageBtn1 setTag:2];
    [imageBtn1 setFrame:imageFrame1];
    [imageBtn1 setBackgroundColor:[UIColor redColor]];
    [imageBtn1 setTitle:@"" forState:UIControlStateNormal];
    [imageBtn1 addTarget:self action:@selector(imageBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageBtn1];
    
    imageBtn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGRect imageFrame2=CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-200, self.view.frame.size.width/4, self.view.frame.size.width/4);
    imageBtn2.hidden=YES;
    [imageBtn2 setTag:3];
    [imageBtn2 setFrame:imageFrame2];
    [imageBtn2 setBackgroundColor:[UIColor greenColor]];
    [imageBtn2 setTitle:@"" forState:UIControlStateNormal];
    [imageBtn2 addTarget:self action:@selector(imageBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageBtn2];
    
    imageBtn3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGRect imageFrame3=CGRectMake(3*self.view.frame.size.width/4, self.view.frame.size.height-200, self.view.frame.size.width/4, self.view.frame.size.width/4);
    imageBtn3.hidden=YES;
    [imageBtn3 setTag:4];
    [imageBtn3 setFrame:imageFrame3];
    [imageBtn3 setBackgroundColor:[UIColor orangeColor]];
    [imageBtn3 setTitle:@"" forState:UIControlStateNormal];
    [imageBtn3 addTarget:self action:@selector(imageBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageBtn3];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)imageBtn:(id)sender{
    NSLog(@"%ld",(long)[sender tag]);
    switch ([sender tag]) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
}

-(void)cameraBtn:(id)sender{
//    if (imageBtn0.hidden) {
//        imageBtn0.hidden=NO;
//    }else if(imageBtn1.hidden){
//        imageBtn1.hidden=NO;
//    }else if(imageBtn2.hidden){
//        imageBtn2.hidden=NO;
//    }else if(imageBtn3.hidden){
//        imageBtn3.hidden=NO;
//    }else{
//        
//    }
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Library",@"Camera", nil];
    [sheet showFromRect:self.view.bounds inView:self.view animated:YES];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%li",(long)buttonIndex);
}

@end
