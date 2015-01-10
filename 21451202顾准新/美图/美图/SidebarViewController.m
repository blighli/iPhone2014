//
//  SidebarViewController.m
//  美图
//
//  Created by 顾准新 on 14/12/19.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "SidebarViewController.h"
#import "PhotoViewController.h"
#import "Colours.h"

@interface SidebarViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *wordDict;
}
@property (nonatomic, retain) UITableView* menuTableView;


@end

@implementation SidebarViewController

-(void)setIndex:(NSString *)index{
    _index = index;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"menulist" ofType:@"plist"];
    
    NSArray *wordArr = [NSArray arrayWithContentsOfFile:path];
    wordDict = [wordArr objectAtIndex:[_index intValue]];
    
    self.menuTableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_index]];

        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = _tag;
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 174, kSidebarWidth, 1)];
        line.backgroundColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
        
        [view addSubview:imageView];
        [view addSubview:label];
        [view addSubview:line];
        view;
    });

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 列表
    self.menuTableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    [self.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    self.menuTableView.backgroundColor = [UIColor clearColor];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    
    [self.contentView addSubview:self.menuTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [wordDict count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.menuTableView.frame.size.height-184)/[wordDict count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sidebarMenuCellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sidebarMenuCellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sidebarMenuCellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    cell.textLabel.textColor = [UIColor robinEggColor];
    cell.textLabel.text = [wordDict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PhotoViewController *controller = nil;
    id next = [self nextResponder];
    while(![next isKindOfClass:[PhotoViewController class]])//这里跳不出来。。。
    {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[PhotoViewController class]])
    {
        controller = (PhotoViewController *)next;
    }
    
    controller.index2 = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    controller.tag2 = [wordDict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    [self showHideSidebar];
    [self.delegate changeState];
    
    
}

@end
