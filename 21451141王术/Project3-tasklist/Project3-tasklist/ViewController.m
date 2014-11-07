//
//  ViewController.m
//  Project3-tasklist
//
//  Created by  ws on 14/11/6.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskField;
@property (weak, nonatomic) IBOutlet UIButton *insertButton;

@property (weak, nonatomic) IBOutlet UITableView *taskTable;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
     [_taskTable reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *plist=[NSArray arrayWithContentsOfFile:docPath()];
    if(plist){
        _tasks=[plist mutableCopy];
    }
    else{
        _tasks=[[NSMutableArray alloc]init];
    }
    if ([_tasks count] == 0) {
        [_tasks addObject:@"你可以添加任务"];
        [_tasks addObject:@"你可以删除这个任务"];
        [_tasks addObject:@"你可以修改这个任务"];
    }
    UITableView *tableView = (id)[self.view viewWithTag:1];
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = 20;
    [tableView setContentInset:contentInset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
NSString *docPath() {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}
- (IBAction)addTask:(id)sender {
    NSString *text = [_taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:@""]) {
        return; //如果是空的什么也不做
    }
    [_tasks addObject: text]; //将新的任务添加到模型
    [_taskTable reloadData]; //表格视图重新载入数据
    [_taskField setText:@""]; //清空输入框
    [_taskField resignFirstResponder]; //关闭软键盘
    [_tasks writeToFile:docPath() atomically:YES];

}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [_tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [_tasks objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tasks removeObjectAtIndex:indexPath.row];
    [_taskTable reloadData];
    [_tasks writeToFile:docPath() atomically:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.taskTable indexPathForCell:sender];
    NSString *item = [_tasks objectAtIndex: [indexPath row]];
    id destination=segue.destinationViewController;
    [destination setValue:item forKey:@"_exchangeString"];
    [destination setValue:indexPath forKey:@"indexPath"];
   
}
@end
