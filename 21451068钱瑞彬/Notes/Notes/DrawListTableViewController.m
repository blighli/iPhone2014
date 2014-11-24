//
//  DrawListTableViewController.m
//  Notes
//
//  Created by apple on 14-11-24.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import "DrawListTableViewController.h"
#import "DrawBoardViewController.h"

@interface DrawListTableViewController ()

@end

@implementation DrawListTableViewController

// 目标窗体
DrawBoardViewController* drawDest = nil;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadListData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.drawItems count];
}

// 设置每一行的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"TableViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // 配置每一行
    NSString* toDoItem = [self.drawItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem;
    
    NSString* aPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), toDoItem];
    UIImage* image = [[UIImage alloc]initWithContentsOfFile:aPath];
    cell.imageView.image = image;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// 选中某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"todolist: didSelectRowAtIndexPath");
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 选中了哪一行, 进行修改
    self.selectedItem = (int)indexPath.row;
    if (drawDest != nil) {
        drawDest.drawItem = [self.drawItems objectAtIndex:self.selectedItem];
        drawDest.barTitle.title = [NSString stringWithFormat:@"编辑涂鸦 %@", drawDest.drawItem];
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

// 设置可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 删除一项
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 涂鸦图片的路径
        NSString* file = [self.drawItems objectAtIndex: indexPath.row];
        NSString* aPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), file];
        
        NSError* error = nil;
        if([[NSFileManager defaultManager] removeItemAtPath:aPath error:&error]) {
            NSLog(@"文件移除成功");
        }
        else {
            NSLog(@"error=%@", error);
        }
        
        [self.drawItems removeObjectAtIndex:indexPath.row];
        [self.drawItems writeToFile:[self docPath] atomically:YES];
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}


//获取应用程序沙盒的Documents目录
- (NSString*) docPath {
    NSArray* pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"DrawImages.txt"];
    return path;
}



// 加载 todolist 的数据
- (void)loadListData {
    NSArray* plist = [NSArray arrayWithContentsOfFile:[self docPath]];
    
    if(plist) {
        self.drawItems = [plist mutableCopy];
    }
    else {
        self.drawItems = [[NSMutableArray alloc] init];
    }

}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    drawDest = segue.destinationViewController;
    drawDest.isNewDraw = (sender==self.addItem)? YES: NO; // 添加 or 编辑
}


- (IBAction)unwindSegue:(UIStoryboardSegue *)segue {
    DrawBoardViewController *source = [segue sourceViewController];
    
    NSString* item = source.drawItem;
    
    if (item != nil) {
        if (source.isNewDraw == YES) { // 添加
            [self.drawItems addObject:item];
        }
        
        // 保存数据, 并重新加载
        [self.drawItems writeToFile:[self docPath] atomically:YES];
        [self.tableView reloadData];
    }
}


@end
