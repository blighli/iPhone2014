//
//  ViewController.m
//  Project3
//
//  Created by xvxvxxx on 14/11/9.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self readFile];
    [self.taskField setBorderStyle:UITextBorderStyleRoundedRect];
    
    
    if ([self.tasks count] == 0) {
        [self.tasks addObject:@"Walk the dogs"];
        [self.tasks addObject:@"Feed the hogs"];
        [self.tasks addObject:@"Chop the logs"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTask:(UIButton *)sender {
    NSString *text = [self.taskField text];
    if ([text isEqualToString:@""]) {
        return;
    }
    [self.tasks addObject: text];
    [self.taskTable reloadData];
    [self.taskField setText:@""];
    [self.taskField resignFirstResponder];
    
    [self.tasks writeToFile:[self docPath] atomically:YES];
}




-(NSString *)docPath {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}
-(void)readFile{
    NSArray *plist = [NSArray arrayWithContentsOfFile:[self docPath]];
    if (plist) {
        self.tasks = [plist mutableCopy];
    } else {
        self.tasks = [[NSMutableArray alloc] init];
    }
}

#pragma datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tasks count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"]; if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [self.tasks objectAtIndex: [indexPath row]]; [[cell textLabel] setText:item];
    return cell ;
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

//删除单元并更新文件
- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSUInteger row = [indexPath row];
        
        //删除数组中对应元素
        [self.tasks removeObjectAtIndex:row];
        
        //将删除后的写入文件
        [self.tasks writeToFile:[self docPath] atomically:YES];
        
        //删除tableView中对应数据的单元
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}


@end
