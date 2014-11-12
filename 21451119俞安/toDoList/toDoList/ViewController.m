//
//  ViewController.m
//  toDoList
//
//  Created by apple on 14/11/8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *contentList;
    UITableViewCell *cell;
    NSInteger index;
    int clear; //
    int editable;//texfield 可编辑
    int isadd;//texfield 可添加吗
}
@end

@implementation ViewController
@synthesize table;
@synthesize addText;
@synthesize buttonChange;
@synthesize addButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    contentList=[[NSMutableArray alloc]init];
    [contentList addObject:@"fisrt one"];
    [contentList addObject:@"second one"];
    [buttonChange setTitle:@"" forState:UIControlStateNormal];
    addText.placeholder=@"轻触add或者tablerow";
    isadd=0;
    clear=0;
    addText.delegate=self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contentList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    
    cell.textLabel.text=[contentList objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [contentList removeObjectAtIndex:indexPath.row];//去掉此下标的数据，并且数据往前移。
    NSLog(@"contentlist=%@ ",contentList);
    
    [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationTop];
    addText.text=@"";
    [addText resignFirstResponder];
    [buttonChange setTitle:@"" forState:UIControlStateNormal];
    addText.placeholder=@"轻触add或者tablerow";
    clear=0;
    isadd=0;
    //自带刷新数据
}
- (IBAction)addContent:(id)sender {
    if(!isadd)
    {
        isadd=1;
        editable=1;
        addText.placeholder=@"请输入内容进行添加";
        addText.text=@"";
        [addText becomeFirstResponder];
        
        [buttonChange setTitle:@"" forState:UIControlStateNormal];
        [table reloadData];
    }
    else
    {
        if(![addText.text isEqualToString:@""])
        {
            
            
            NSLog(@"add content");
            [contentList addObject: addText.text];
            addText.text=@"";
            [addText resignFirstResponder];
            editable=0;
            isadd=0;
            addText.placeholder=@"轻触add或者tablerow";
            [table reloadData];
            
        }
    }
}

- (IBAction)updatecontent:(id)sender {
    
    if (clear) {
        if ([buttonChange.currentTitle isEqualToString:@"edit"])
        {
            [addButton setTitle:@"" forState:UIControlStateNormal];
            addText.text=[contentList objectAtIndex:index];
            editable=1;
            [addText becomeFirstResponder];
            [buttonChange setTitle:@"update" forState:UIControlStateNormal];
        }
        else{
            [contentList replaceObjectAtIndex:index withObject: addText.text];
            addText.text=@"";
            [addText resignFirstResponder];
            editable=0;
            [buttonChange setTitle:@"" forState:UIControlStateNormal];
            [addButton setTitle:@"add" forState:UIControlStateNormal];
            addText.placeholder=@"轻触add或者tablerow";
            isadd=0;
            [table reloadData];
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    clear=1;
    addText.text=@"";
    addText.placeholder=@"轻触 edit来进行修改";
    [addText resignFirstResponder];
    [buttonChange setTitle:@"edit" forState:UIControlStateNormal];
    //addText.text=[contentList objectAtIndex:indexPath.row];
    index=indexPath.row;
    editable=0;
    
    
}

//#p textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if(editable)
    {
        return YES;
    }
    else
    return NO;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [addText resignFirstResponder];
    //[buttonChange setTitle:@"" forState:UIControlStateNormal];
    // addText.text=@"tap add来进行添加";
    //isadd=0;
    editable=0;
    return YES;
}

@end
