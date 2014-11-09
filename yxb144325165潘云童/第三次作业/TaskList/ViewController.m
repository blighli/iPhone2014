//
//  ViewController.m
//  TaskList
//
//  Created by Joker on 14/11/9.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

#import "ViewController.h"


static NSMutableArray* tasks;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskField;
@property (weak, nonatomic) IBOutlet UITableView *taskTable;
- (IBAction)addTask:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *plist = [NSArray arrayWithContentsOfFile:[ViewController docPath]];
    if (plist) {
        tasks = [plist mutableCopy];
    } else {
        tasks = [[NSMutableArray alloc] init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSMutableArray*) getTasks {
    return tasks;
}

+ (NSString*) docPath {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_taskTable dequeueReusableCellWithIdentifier:@"Cell"]; if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]]; [[cell textLabel] setText:item];
    return cell ;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/*删除一行*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tasks removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        [_taskTable deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //删除对应数据的cell
    }
}

- (IBAction)addTask:(id)sender {
    NSString *text = [_taskField text];
    if ([text isEqualToString:@""]) {
        return;
    }
    [tasks addObject: text]; //将新的任务添加到模型
    NSIndexPath *path = [NSIndexPath indexPathForRow:([tasks count]-1) inSection:0];
    [_taskTable insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationRight];
    [_taskField setText:@""]; //清空输入框
    [_taskField resignFirstResponder]; //关闭软键盘
}

@end
