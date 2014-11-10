
//  ViewController.m
//  ToDoList
//
//  Created by 顾准新 on 14-11-9.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "ViewController.h"
#import "EditListViewController.h"



@interface ViewController ()<UITableViewDataSource,MainDelegate,UITableViewDelegate>

@end

@implementation ViewController

-(void)editTask:(NSString *)name withIndex:(NSInteger)row{
    //NSLog(@"%@",name);
    if(![name isEqualToString:@""]){
        if(row>[self.tasks count]){
            [self.tasks addObject:name];
        }
        else{
            if(![name isEqualToString:[self.tasks objectAtIndex:row]]){
                [self.tasks replaceObjectAtIndex:row withObject:name];
                [taskTable reloadData];
                //NSLog(@"laka");
            }
        }
        
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"TO Do List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addList)];
    
    UIBarButtonItem *backItem = self.navigationItem.backBarButtonItem;
    backItem.title = @"Cancel";
    
    self.tasks = [[NSMutableArray alloc]init];
    if([self.tasks count] == 0){
        [self.tasks addObject:@"eat"];
        [self.tasks addObject:@"play"];
        [self.tasks addObject:@"sleep"];
    }
   // NSLog(@"LOAD");
    
    taskTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    [taskTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    taskTable.dataSource = self;
    taskTable.delegate = self;
    [self.view addSubview:taskTable];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)addList{
    EditListViewController *editViewController = [[EditListViewController alloc]init];
    editViewController.row = [self.tasks count]+1;
    editViewController.delegate = self;
    [self.navigationController pushViewController:editViewController animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tasks count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [[cell textLabel] setText:[self.tasks objectAtIndex:[indexPath row]]];
    //NSLog(@"%@",cell.textLabel.text);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *text = [self.tasks objectAtIndex:[indexPath row]];
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.tasks removeObject:text];
        [taskTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    EditListViewController *editViewController = [[EditListViewController alloc]init];
    editViewController.editText = [self.tasks objectAtIndex:[indexPath row]];
    editViewController.row = [indexPath row];
   // NSLog(@"%ld",(long)editViewController.row);
    editViewController.delegate = self;
    [self.navigationController pushViewController:editViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}














@end
