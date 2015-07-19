//
//  DrawPicViewController.m
//  MyNotes
//
//  Created by 焦守杰 on 14/11/23.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "DrawPicViewController.h"

@interface DrawPicViewController ()
- (IBAction)clickAddButton:(id)sender;

@end

@implementation DrawPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    showData=[[NSMutableArray alloc]init];
    _dbu=[[DatabaseUtil alloc]init];
    [self loadData];
    thumbPath = [NSString stringWithFormat:@"%@/Documents/thumbnail/",NSHomeDirectory()];
    picPath=[NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //  NSLog(@"%d",showData.count);
    return showData.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSArray *sections = [SvTableViewDataModal sections];
    //   SvSectionModal *sectionModal = [sections objectAtIndex:indexPath.section];
    NoteData *data=showData[indexPath.row];
  //  UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"MyCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.editingAccessoryType=UITableViewCellEditingStyleDelete;
    cell.showsReorderControl = YES;
    
    
    NSString *p=[NSString stringWithFormat:@"%@%@",thumbPath,[data note]];
    UIImage *image=[[UIImage alloc]initWithContentsOfFile:p];
    cell.imageView.image=image;
    cell.textLabel.text=[data note];
    cell.detailTextLabel.text=[data time];
    //    NSLog(@"-=-=-=-=-=-=-=-=-=--");
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //     NSLog(@"DELETE  %d",indexPath.row);
        NoteData *td=showData[indexPath.row];
        NSLog(@"%d ",td.id );
  //      [self ]
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *p=[NSString stringWithFormat:@"%@%@",thumbPath,[td note]];
        NSString *p1=[NSString stringWithFormat:@"%@%@",picPath,[td note]];
        NSError *error;
        [fileMgr removeItemAtPath:p error:&error];
        [fileMgr removeItemAtPath:p1 error:&error];
        [showData removeObject:td];
        [tableView reloadData];
        [_dbu deleteNoteWithId:td.id];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushToModifyPic"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *sendPictureName = [[showData objectAtIndex:[indexPath row]] note];
        BoardViewController *destViewController = segue.destinationViewController;
        destViewController.name=sendPictureName;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}
-(void)loadData{
    showData=[_dbu  NoteDataWithType:@"1"];
}

- (IBAction)clickAddButton:(id)sender {
    [self performSegueWithIdentifier:@"pushToDrawBoard" sender:self];
}
@end
