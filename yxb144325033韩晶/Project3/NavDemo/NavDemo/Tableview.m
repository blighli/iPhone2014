//
//  Tableview.m
//  NavDemo
//
//  Created by NimbleSong on 14/11/17.
//  Copyright (c) 2014年 宋宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tableview.h"

@interface Tableview ()
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, retain) NSArray *dataList;

@end

@implementation Tableview

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edititem:)];
    self.navigationItem.leftBarButtonItem=leftButton;
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(additem:)];
    self.navigationItem.rightBarButtonItem=rightButton;
    
    NSArray *list=[NSArray arrayWithObjects:@"武汉",@"上海",@"北京",@"深圳",@"广州",@"重庆",@"香港",@"台海",@"天津", nil];
    self.dataList=list;
    
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableview setDataSource:self];
    [_tableview setDelegate:(id)self];
    _tableview.allowsSelection=YES;
    _tableview.allowsSelectionDuringEditing=YES;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellWithIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    NSUInteger row=[indexPath row];
    cell.textLabel.text=[self.dataList objectAtIndex:row];
    return cell;
}

-(void)additem:(id)sender{
    
}

-(void) edititem:(id)sender{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end