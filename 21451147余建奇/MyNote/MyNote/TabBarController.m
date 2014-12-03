//
//  TabBarController.m
//  MyNote
//
//  Created by yjq on 14/11/26.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import "TabBarController.h"
#import "TextViewController.h"
#import "imageViewController.h"
#import "ViewController.h"
#import "HandDrawViewController.h"

@interface TabBarController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

-(IBAction)saveButton:(id)sender;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    if(item.tag==0){
//        NSLog(@"选中的是文字文本！");
//    }
//    else if(item.tag==1){
//        NSLog(@"选中的是图像文本");
//    }
//    else{
//        NSLog(@"选中的是手绘文本");
//    }
//}


-(IBAction)saveButton:(id)sender
{
    ViewController *viewController=[[self storyboard]instantiateViewControllerWithIdentifier:@"ViewController"];
    if (self.selectedIndex==0) {
        NSLog(@"选中的是文字文本！");
        TextViewController *textViewController = self.childViewControllers[0];
        if ([textViewController.textView.text length]==0) {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示"
                message:@"输入不能为空" delegate:nil cancelButtonTitle:@"OK"
                otherButtonTitles:nil, nil];
            [alter show];
        }
        else{
            NSMutableDictionary *info=[[NSMutableDictionary alloc]init];
            [info setObject:textViewController.textView.text forKey:@""];
            [_list addObject:info];
            //[_list addObject:textViewController.textView.text];
            [_list writeToFile:[textViewController textDocPath] atomically:YES];
            textViewController.textView.text=@"";
            [self dismissViewControllerAnimated:YES completion:nil];
            [[self navigationController]pushViewController:viewController animated:YES];
        }
        NSLog(@"---%@----",_list);
        //NSLog(@"---%@",textViewController.textView.text);
    }
    else if(self.selectedIndex==1){
        NSLog(@"选中的是图像文本");
        imageViewController *imageController=self.childViewControllers[1];
        if (imageController.imageView.image==nil) {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示"
                message:@"图片不能为空" delegate:nil cancelButtonTitle:@"OK"
                otherButtonTitles:nil, nil];
            [alter show];

        }
        else if([imageController.textField.text length]==0){
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示"
                message:@"标题不能为空" delegate:nil cancelButtonTitle:@"OK"
                otherButtonTitles:nil, nil];
            [alter show];
        }
        else{
            //[_list addObject:imageController.textField.text];
            //[_list writeToFile:[imageController textDocPath] atomically:YES];
            NSString *imageName=[NSString stringWithFormat:@"%@.png",imageController.textField.text];
            
            NSString *imagePath=[[imageController imageDocPath]stringByAppendingPathComponent:imageName];
            [UIImagePNGRepresentation(imageController.imageView.image)writeToFile:imagePath atomically:YES];
            NSMutableDictionary *info=[[NSMutableDictionary alloc]init];
            [info setObject:imageName forKey:@"image"];
            [_list addObject:info];
            [_list writeToFile:[imageController textDocPath] atomically:YES];
            imageController.imageView.image=nil;
            imageController.textField.text=nil;
            //[_list addObject:imageController.imageView.image];
            [[self navigationController]pushViewController:viewController animated:YES];
        }
    }
    else{
        NSLog(@"选中的是手绘文本");
        HandDrawViewController *handDrawViewController=self.childViewControllers[2];
        if ([handDrawViewController.textfield.text length]==0) {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示"
                message:@"标题不能为空" delegate:nil cancelButtonTitle:@"OK"
                otherButtonTitles:nil, nil];
            [alter show];
        }
        else if (handDrawViewController.drawerView.viewImage==nil){
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示"
                message:@"手绘图片不能为空" delegate:nil cancelButtonTitle:@"OK"
                otherButtonTitles:nil, nil];
            [alter show];
        }
        else{
            NSString *handimageName=[NSString stringWithFormat:@"%@.png",handDrawViewController.textfield.text];
            NSString *handimagePath=[[handDrawViewController handImageDocPath]stringByAppendingPathComponent: handimageName];
            [UIImagePNGRepresentation(handDrawViewController.drawerView.viewImage)writeToFile:handimagePath atomically:YES];
            NSMutableDictionary *info=[[NSMutableDictionary alloc]init];
            [info setObject:handimageName forKey:@"handimage"];
            [_list addObject:info];
            [_list writeToFile:[handDrawViewController textDocPath] atomically:YES];
            handDrawViewController.drawerView.viewImage=nil;
            handDrawViewController.textfield.text=nil;
            [[self navigationController]pushViewController:viewController animated:YES];
        }
    }
}

@end
