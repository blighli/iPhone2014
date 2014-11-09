//
//  ViewController.m
//  TaskList
//
//  Created by 焦守杰 on 14/11/6.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UIApplicationDelegate,UITextFieldDelegate>
@end

@implementation ViewController
-(IBAction)pressButton:(id)sender{

    NSString *s=[self.textField text];
    NSString* res = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([res length]){
        [task addObject:res];
        [self writeToFile];
        [self.tableView reloadData];       //重新载入数据
       
        
    }
    [_textField setText:@""];
    [_textField resignFirstResponder];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource=self;
    NSString *path = [[NSBundle mainBundle] bundlePath];
    finalPath = [path stringByAppendingPathComponent:@"data.plist"];

    
    
    NSArray *plist = [NSArray arrayWithContentsOfFile:finalPath];
    if (plist) {
        task = [plist mutableCopy];
    } else {
        task = [[NSMutableArray alloc] init];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return task.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"MyTableViewCellIdentifier";
    bool nibRegister=NO;
    if(!nibRegister){
        UINib *nib=[UINib nibWithNibName:@"MyTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        nibRegister=YES;
    }
    MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    [cell setTableViewController:self];
    cell.textField.text=task[indexPath.row];
    [cell setRowNum:indexPath.row];
    return cell;
}
-(void)deleteObjectAt:(int)_index{
    [task removeObjectAtIndex:_index];
    [self writeToFile];
    [self.tableView reloadData];
}
-(void) modifyObject:(NSString*)s At:(int)index{
    [task replaceObjectAtIndex:index withObject:s];
    [self writeToFile];
    [self.tableView reloadData];
}

-(void)writeToFile{

    [task writeToFile:finalPath atomically:YES];
        
}
NSString *docPath() {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

@end
