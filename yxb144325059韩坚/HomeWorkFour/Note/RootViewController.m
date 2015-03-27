//
//  RootViewController.m
//  Note
//
//  Created by HJ on 14/11/14.
//  Copyright (c) 2014年 cstlab.hj.NOTE. All rights reserved.
//

#import "RootViewController.h"
#import "SqliteManage.h"
#import "detailViewController.h"

@interface RootViewController()<UITableViewDataSource,UITableViewDelegate>
{
    SqliteManage *mySqliteManage;
}
@property (copy, nonatomic)  NSMutableArray *countArray;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    mySqliteManage = [SqliteManage sqliteManage];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        [mySqliteManage addImageAndPaint:@"The furthest distance in the world\nis not between life and death\nbut when I stand in front of you\nyet you don't know that\nI love you \n\n向上滑动将会看到手绘" image:[UIImage imageNamed:@"image320.png"] andPaint:[UIImage imageNamed:@"1.png"]];
    }
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self.navigationController.navigationBar setTintColor:[UIColor purpleColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _countArray = [mySqliteManage sqlCountArray];
    return _countArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootCell"];
    if (cell == nil) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rootCell"];
        }
    }
    cell.textLabel.text = [mySqliteManage readDB:[_countArray[indexPath.row] intValue]];
    //cell.imageView.image = [mySqliteManage readImage:[_countArray[indexPath.row] intValue]];
    UIImage *image = [mySqliteManage readImage:[_countArray[indexPath.row] intValue]];
    UIImage *paint = [mySqliteManage readPaint:[_countArray[indexPath.row] intValue]];
    if (image != nil) {
        cell.imageView.image = [self shrinkImage: image toSize:CGSizeMake(80, 80)];
    }else if(paint != nil){
        cell.imageView.image = [self shrinkImage:paint  toSize:CGSizeMake(45, 80)];
    }else{
        cell.imageView.image = nil;
    }
//    if (cell.imageView.image == nil) {
//        cell.imageView.image = [mySqliteManage readPaint:[_countArray[indexPath.row] intValue]];
//    }
    return  cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [mySqliteManage sqlDelete:[_countArray[indexPath.row]intValue]];
        [_countArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        //[tableView reloadData];
    }
}
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    detailViewController *detail = segue.destinationViewController;
    detail.item = [_countArray[[self.tableView indexPathForSelectedRow].row]intValue];
}
//push
- (IBAction)rootAddButton:(UIBarButtonItem *)sender {
    detailViewController *detail = [detailViewController new];
    [self.navigationController pushViewController:detail animated:YES];
    detail.item = [[_countArray lastObject] intValue]+1;
}

- (UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    CGFloat originalAspect = original.size.width / original.size.height;
    CGFloat targetAspect = size.width / size.height;
    CGRect targetRect;
    
    if (originalAspect > targetAspect) {
        // original is wider than target
        targetRect.size.width = size.width;
        targetRect.size.height = size.height * targetAspect / originalAspect;
        targetRect.origin.x = 0;
        targetRect.origin.y = (size.height - targetRect.size.height) * 0.5;
    } else if (originalAspect < targetAspect) {
        // original is narrower than target
        targetRect.size.width = size.width * originalAspect / targetAspect;
        targetRect.size.height = size.height;
        targetRect.origin.x = (size.width - targetRect.size.width) * 0.5;
        targetRect.origin.y = 0;
    } else {
        // original and target have same aspect ratio
        targetRect = CGRectMake(0, 0, size.width, size.height);
    }
    
    [original drawInRect:targetRect];
    UIImage *final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return final;
}
@end
