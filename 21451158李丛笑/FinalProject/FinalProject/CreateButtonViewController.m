//
//  CreateButtonViewController.m
//  FinalProject
//
//  Created by 李丛笑 on 15/1/5.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import "CreateButtonViewController.h"
#import "SetButton.h"

@interface CreateButtonViewController ()

@end

@implementation CreateButtonViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UILabel *)createHomeButtonView:(int)classid{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
    if(classid == 0)
        label.text = @"+";
    else label.text = [NSString stringWithFormat:@"%d",classid];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    label.clipsToBounds = YES;
    
    return label;
}

- (NSArray *)createDemoButtonArray :(int)tableid Classid:(int)classid{
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    NSArray *texts = [stb getButtonText:tableid Classid:classid];
    
    for (NSString *title in texts) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0.f, 0.f, 50.f, 30.f);
        //button.layer.cornerRadius = button.frame.size.height / 2.f;
        button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.clipsToBounds = YES;
        i++;
        button.tag = i*10+classid;
        
        
        
        [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside ];
        
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}

- (void)test:(UIButton *)sender{
    NSLog(@"Button tapped, tag: %ld", (long)sender.tag);
    buttontag = (int)sender.tag;
    NSString *showcontent = [stb getButtonInfo:(int)sender.tag Tableid:tableid];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really reset?" message:showcontent delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    
    // optional - add more buttons:
    [alert addButtonWithTitle:@"编辑"];
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self performSegueWithIdentifier:@"toEdit" sender:self];
    }
    
}


@end
