//
//  PaintView.m
//  NavDemo
//
//  Created by NimbleSong on 14/11/17.
//  Copyright (c) 2014年 宋宁. All rights reserved.
//

#import "PaintView.h"
#import "Paint.h"

@interface PaintViewController ()

@end

@implementation PaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Hand Write";
    // Do any additional setup after loading the view.
//    pt=[[paintview alloc] initWithFrame:self.view.frame];
    pt=[[paintview alloc] initWithFrame:self.view.frame];
    pt.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:pt];
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelBtn:)];
    self.navigationItem.rightBarButtonItem=rightButton;
    
    CGRect saveFrame=CGRectMake(130, 600, 60, 31);
    UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveBtn setFrame:saveFrame];
    [saveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveBtn];
    
    CGRect clearFrame=CGRectMake(190, 600, 60, 31);
    UIButton *clearBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearBtn setFrame:clearFrame];
    [clearBtn setTitle:@"Clear" forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearBtn:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:clearBtn];
    
}

-(void)cancelBtn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveBtn:(id)sender{
    [pt save:YES];
    UIImageView *testimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    testimage.backgroundColor=[UIColor redColor];
    if ([pt imagenow]) {
        [testimage setImage:[pt imagenow]];
        [self.view addSubview:testimage];
        NSLog(@"11111111");
    }
    
}

-(void)clearBtn:(id)sender{
    [pt clear:YES];
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
