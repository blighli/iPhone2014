//
//  ViewController.m
//  MyNote
//
//  Created by yjq on 14/11/14.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import "ViewController.h"
#import "TextViewController.h"
#import "imageViewController.h"
#import "TabBarController.h"
#import "HandDrawViewController.h"

@interface ViewController ()

@end

@implementation ViewController

TextViewController *textViewContrller;
imageViewController *imageController;


- (void)viewDidLoad {
    [super viewDidLoad];
    //定义标题
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"记事本" forState:UIControlStateNormal];
    [button sizeToFit];
    self.navigationItem.titleView=button;
    
    //将沙盒中的数据文件存入_list中
    //NSLog(@"textcontroller:%@",textViewContrller);
    textViewContrller = [[TextViewController alloc] init];
    imageController=[[imageViewController alloc] init];
    
    NSArray *plist= [NSArray arrayWithContentsOfFile:[textViewContrller textDocPath]];
    
    //[plist arrayByAddingObjectsFromArray:[NSArray arrayWithContentsOfFile:[imageController textDocPath]]];
    //[plist arrayByAddingObjectsFromArray:[NSArray arrayWithContentsOfFile:[imageController imageDocPath]]];
    NSLog(@"+++++++%@++++++",plist);
    //NSLog(@"******%@*******",[imageController textDocPath]);
    //NSLog(@"~~~~~~~%@~~~~~~",[textViewContrller textDocPath]);
    //NSLog(@"!!!!!!%@!!!!!!!",[imageController imageDocPath]);
    //[plist arrayByAddingObjectsFromArray:[NSArray arrayWithContentsOfFile:docPath()]];
    if (plist) {
        _list=[plist mutableCopy];
    } else {
        _list=[[NSMutableArray alloc]init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"listcount:%lu",(unsigned long)_list.count);
    return [_list count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier=@"MyCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    dic=[_list objectAtIndex:indexPath.row];
    NSString *key=[dic.allKeys objectAtIndex:0];
    if([key isEqualToString:@""])
    {
        //如果是文本文件的话，就取他的value值
        cell.textLabel.text=[dic objectForKey:@""];
    }
    else if([key isEqualToString:@"image"])
    {
        //是图片文件，或者手绘文件时，就取他的key值
       // NSLog(@"%@",dic.allKeys);
        cell.textLabel.text=dic[key];
    }
    else{
        cell.textLabel.text=dic[key];
    }
    //NSObject *object=[dic objectForKey:@""]
    //cell.textLabel.text =[_list objectAtIndex:indexPath.row];
   // NSLog(@"cell:%@",cell);
    return cell;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    dic=[_list objectAtIndex:indexPath.row];
    NSString *key=[dic.allKeys objectAtIndex:0];
    //NSLog(@"&&&&&&&%@$$$$$%@&&&&&&&",key,[dic valueForKey:key]);
    if ([key isEqualToString:@""]) {
        TextViewController *nextTextView=[[self storyboard]instantiateViewControllerWithIdentifier:@"TextViewController"];
        nextTextView.textString = dic[@""];
        NSLog(@"textView:%@",nextTextView.textView);
        
        //nextTextView.textView.text = [dic valueForKey:key];
        NSLog(@"本文的内容是%@",nextTextView.textView.text);
        
        [[self navigationController]pushViewController:nextTextView animated:YES];
       // NSLog(@"现在的页面时文本页面");
        //NSLog(@"---%@---",[dic valueForKey:key]);
//        imageViewController *nextView=[[imageViewController alloc]init];
//        [self.navigationController pushViewController:nextView animated:NO];
//        imageViewController *nextViewController=[[imageViewController alloc]initWithNibName:@"imageViewController" bundle:nil];
//        [self presentViewController:nextViewController animated:NO completion:^{}];
    }
    else if([key isEqualToString:@"image"]){
    //else{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        
        NSString *imagePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:dic[key]];
        imageViewController *imageView=[[self storyboard]instantiateViewControllerWithIdentifier:@"imageViewController"];
        imageView.textString=dic[key];
        imageView.image = [UIImage imageWithContentsOfFile:imagePath];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
        NSLog(@"--image%@",image);
        
        [[self navigationController]pushViewController:imageView animated:YES];
        NSLog(@"图片地址是%@",[dic valueForKey:key]);
        NSLog(@"现在的页面时图片文本");
        NSLog(@"+++%@+++",key);
    }
    else{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        
        NSString *handimagePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:dic[key]];
        HandDrawViewController *handimageView=[[self storyboard]instantiateViewControllerWithIdentifier:@"HandDrawViewController"];
        handimageView.textString=dic[key];
        handimageView.flag=YES;
        handimageView.handimage= [UIImage imageWithContentsOfFile:handimagePath];
        //UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        [[self navigationController]pushViewController:handimageView animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    dic=[_list objectAtIndex:indexPath.row];
    NSString *key=[dic.allKeys objectAtIndex:0];
    [_list removeObjectAtIndex:indexPath.row];
    [_list writeToFile:[textViewContrller textDocPath] atomically:YES];
    if ([key isEqualToString:@""]) {
        //do nothing
    }
    else{
        NSFileManager *fileManager=[NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *imagePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:dic[key]];
        [fileManager removeItemAtPath:imagePath error:nil];
    }
    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //NSLog(@"****%@*****",_list);
    [self.tableView reloadData];
}
////界面返回时的操作
//-(void)viewDidAppear:(BOOL)animated
//{
//    
////    NSLog(@"****%@*****",_list);
////    [_tableView reloadData];
//}

//NSString *docPath()
//{
//    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
//    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
//}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    
//    NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
//    NSString *content=[_list objectAtIndex:[indexPath row]];
//    id destination=segue.destinationViewController;
//    [destination setValue:content forKey:@"_changeDate"];
//    [destination setValue:indexPath forKey:@"indexPath"];
//    //[super prepareForSegue:segue sender:sender];
//}
@end
