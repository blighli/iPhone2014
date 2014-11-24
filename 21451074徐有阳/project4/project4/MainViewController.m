//
//  MainViewController.m
//  project4
//
//  Created by xuyouyang on 14/11/23.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "MainViewController.h"
#import "TextViewController.h"
#import "DB.h"
#import "Note.h"
#import "Camera.h"

@interface MainViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) NSMutableArray *notes;
@end

@implementation MainViewController
{
    Camera *camera;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    camera = [[Camera alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    self.notes = [Note getAllNotes];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"note" forIndexPath:indexPath];
    cell.textLabel.text = ((Note *)[self.notes objectAtIndex:indexPath.row]).title;
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *note = [self.notes objectAtIndex:indexPath.row];
        [self.notes removeObjectAtIndex:indexPath.row];
        [note drop];
        [self.tableView reloadData];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addText"]) {
        NSLog(@"add");
        TextViewController *textVC = [segue destinationViewController];
        textVC.note = nil;
    }
    if ([segue.identifier isEqualToString:@"editText"]) {
        NSLog(@"edit");
        NSInteger index = [self.tableView indexPathForCell:(UITableViewCell *)sender].row;
        TextViewController *textVC = [segue destinationViewController];
        textVC.note = [self.notes objectAtIndex:index];
    }
}

- (IBAction)editNote:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO];
    } else {
        [self.tableView setEditing:YES];
    }
}

- (IBAction)addNote:(id)sender {
    UIActionSheet *addNoetActionSheet = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"文字", @"照片", @"绘图", nil];
    [addNoetActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            NSLog(@"文字");
            [self performSegueWithIdentifier:@"addText" sender:self];
            break;
        case 1:
            NSLog(@"照相");
            // 调用相机
            [camera takePhoto:self];
            break;
        case 2:
            NSLog(@"绘图");
            [self performSegueWithIdentifier:@"draw" sender:self];
            break;
    }
}
@end
