//
//  drawTableViewController.m
//  evernote
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "drawTableViewController.h"
#import "AppDelegate.h"

@interface drawTableViewController ()
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *fetchedobject;
    NSString *sendname;
}

@end
@implementation drawTableViewController
@synthesize drawtable;



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context=[appDelegate managedObjectContext];
    [self findobject];
}

-(void)findobject
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Drawing" inManagedObjectContext:context];//生成 数据实体
    [fetchRequest setEntity:entity]; //设置数据查询的实体
    
    fetchedobject= [context executeFetchRequest:fetchRequest error:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self findobject];
    [drawtable reloadData];
    NSLog(@"reload draw");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma tabledelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"draw table=%ld",[fetchedobject count]);
    return [fetchedobject count];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *thumbAPath = [NSString stringWithFormat:@"%@/Documents/thumbnail",NSHomeDirectory()];
    NSString *imgname=[[fetchedobject valueForKey:@"imgfile"]objectAtIndex:indexPath.row];
    NSString *imgpath=[thumbAPath stringByAppendingPathComponent:imgname];
    
    NSString *thumbBPath = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    NSString *imgBpath=[thumbBPath stringByAppendingPathComponent:imgname];
    
    [context deleteObject:[fetchedobject objectAtIndex:indexPath.row]];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@,",error);
        abort();
    }

    [[NSFileManager defaultManager]removeItemAtPath:imgpath error:nil];
    [[NSFileManager defaultManager]removeItemAtPath:imgBpath error:nil];
    NSLog(@"delete draw");
    [self findobject];
    [drawtable deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]  withRowAnimation:UITableViewRowAnimationTop];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
     NSString *thumbAPath = [NSString stringWithFormat:@"%@/Documents/thumbnail",NSHomeDirectory()];
    NSString *imgname=[[fetchedobject valueForKey:@"imgfile"]objectAtIndex:indexPath.row];
    NSString *imgpath=[thumbAPath stringByAppendingPathComponent:imgname];
    NSLog(@"%@",imgpath);
    cell.imageView.image=[[UIImage alloc]initWithContentsOfFile:imgpath];
    cell.textLabel.text=imgname;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imgname=[[fetchedobject valueForKey:@"imgfile"]objectAtIndex:indexPath.row];
    sendname=imgname;
    [self performSegueWithIdentifier:@"pushdraw" sender:nil];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
{
    if ([segue.identifier isEqual:@"pushdraw"]) {
        
        
        id page2=segue.destinationViewController;
    
        [page2 setValue:sendname forKey:@"sendPictureName"];

    }
    else{
        
        NSLog(@"%@",segue.identifier);
            id page2=segue.destinationViewController;
    
    [page2 setValue:nil forKey:@"sendPictureName"];
    }
    NSLog(@"prepare");
}

@end
