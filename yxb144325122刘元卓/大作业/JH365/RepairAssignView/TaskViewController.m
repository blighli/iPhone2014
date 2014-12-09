#import "TaskViewController.h"

@implementation TaskViewController

@synthesize unFinishViewController,finishViewController,allViewController;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.unFinishViewController = nil;
}
- (void)dealloc
{
    self.unFinishViewController = nil;
    [super dealloc];
}

#pragma mark - IBAction
- (IBAction)btnUnFinishClicked:(id)sender
{
    // 加载unFinishViewController窗口
    [unFinishViewController release];
    unFinishViewController = [[UnFinishViewController alloc] init];
    // 使生成的每一个行数据都能点击进入
    [self.navigationController pushViewController:unFinishViewController animated:YES];
}
- (IBAction)btnFinishClicked:(id)sender
{
    // 加载FinishViewController窗口
    [finishViewController release];
    finishViewController = [[FinishViewController alloc] init];
    // 使生成的每一个行数据都能点击进入
    [self.navigationController pushViewController:finishViewController animated:YES];
}
- (IBAction)btnAllClicked:(id)sender
{
    // 加载AllViewController窗口
    [allViewController release];
    allViewController = [[AllViewController alloc] init];
    // 使生成的每一个行数据都能点击进入
    [self.navigationController pushViewController:allViewController animated:YES];
}

@end
