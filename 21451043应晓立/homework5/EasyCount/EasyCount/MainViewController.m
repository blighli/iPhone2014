//
//  MainViewController.m
//  EasyCount
//
//  Created by yingxl1992 on 14/12/14.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize username;
@synthesize data;

//设置左右侧滑动菜单栏
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
}

- (void)initView {
    pics=[[NSArray alloc]initWithObjects:@"breakfast",@"lunch",@"dinner",@"drinking",@"candy",@"bus",@"shopping",@"enter",@"user",@"cloth", nil];
    titles=[[NSArray alloc]initWithObjects:@"早餐",@"午餐",@"晚餐",@"饮料",@"零食",@"交通",@"购物",@"娱乐",@"社交",@"衣物", nil];
    
    _listTable.delegate=self;
    _listTable.dataSource=self;
    
    //获取当天日期
    NSDateComponents *datecomponents = [[NSCalendar currentCalendar] components: NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger year=[datecomponents year];
    NSInteger month=[datecomponents month];
    NSInteger day=[datecomponents day];
    currentDate=[NSString stringWithFormat:@"%ld/%ld/%ld",(long)year,(long)month,(long)day];
    
    //通过ws获取数据
    data=nil;
    [self bindList];
    [_listTable reloadData];
    
    //设置右上角的添加和选择日期的btn
    UIBarButtonItem *addBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addRecord)];
    
    UIBarButtonItem *selectBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:currentDate style:UIBarButtonItemStylePlain target:self action:@selector(setDate)];
    
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:addBarButtonItem,selectBarButtonItem, nil];
    UIColor *color=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backcolor"]];
    
    self.view.backgroundColor=color;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    data=nil;
    [self bindList];
    [_listTable reloadData];
    NSLog(@"willViewAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)addRecord {
    [self performSegueWithIdentifier:@"addSegue" sender:self];
}

//点击日期btn后触发的事件，ios7之后不支持alertview.addview，所以引用了CustomIOS7AlertView
- (void)setDate {
    picker=[[UIDatePicker alloc]init];
    picker.datePickerMode=UIDatePickerModeDate;
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy/MM/dd"];
    picker.date=[df dateFromString:currentDate];
    [picker addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    
    CustomIOS7AlertView *alertView=[[CustomIOS7AlertView alloc]init];
    [alertView setContainerView:picker];
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"确定",@"取消", nil]];
    [alertView setDelegate:self];
    [alertView show];
    
}

//CustomIOS7AlertView的delegate方法，用来为btn添加操作
- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //点击“确定”
    if (buttonIndex==0) {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"yyyy/MM/dd";
        currentDate=[formatter stringFromDate:picker.date];
        UIBarButtonItem *buttonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:1];
        buttonItem.title=currentDate;
        
        [self bindList];
        [_listTable reloadData];
    }
    [alertView close];
}

- (void)bindList {
    if (data==nil) {
        data=[[NSMutableArray alloc]init];
    }
    NSData *received=[self receriveData];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:&error];
    data= (NSMutableArray *)jsonObject;
    
    //计算总额
    NSInteger sum=[self calSum];
    _sumLabel.text=[NSString stringWithFormat:@"%ld",(long)sum];
}

//计算总额
- (NSInteger)calSum {
    NSInteger sum=0;
    for (NSDictionary *item in data) {
        NSInteger money=[[NSString stringWithFormat:@"%@",[item objectForKey:@"money"]]integerValue];
        sum=sum+money;
    }
    return sum;
}

//通过ws获取数据
- (NSData *)receriveData {
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/expend/listbyday"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    NSArray *dates=[currentDate componentsSeparatedByString:@"/"];
    NSString *paramstr=[NSString stringWithFormat:@"username=%@&&year=%@&&month=%@&&day=%@",username,[dates objectAtIndex:0],[dates objectAtIndex:1],[dates objectAtIndex:2]];
    NSData *params=[paramstr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:params];
    
    NSData *received=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return received;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listItem" forIndexPath:indexPath];
    
    NSDictionary *item=[data objectAtIndex:indexPath.row];
    
    NSString *type=[NSString stringWithFormat:@"%@",[item valueForKey:@"type"]];
    UIImage *image=[UIImage imageNamed:type];
    cell.imageView.image=image;
    cell.textLabel.text=[titles objectAtIndex:[type integerValue]];
    
    NSString *money=[NSString stringWithFormat:@"%@",[item valueForKey:@"money"]];
    cell.detailTextLabel.text=money;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        NSURL *url=[NSURL URLWithString:@"http://localhost:8080/expend/delete"];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
        [request setHTTPMethod:@"POST"];
        
        NSDictionary *item=[data objectAtIndex:indexPath.row];
        NSInteger recId=[[NSString stringWithFormat:@"%@",[item valueForKey:@"id"]] integerValue];
        NSString *paramstr=[NSString stringWithFormat:@"id=%ld",recId];
        NSData *params=[paramstr dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:params];
        
        NSData *received=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *res=[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
        NSLog(@"row:%ld",indexPath.row);
        if ([res compare:@"1"]==NSOrderedSame) {
            [self bindList];
            [_listTable reloadData];
        } else {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"删除失败，请重试~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
    }
//
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destView=[segue destinationViewController];
    if ([[segue identifier] compare:@"addSegue"]==NSOrderedSame) {
        AddViewController *addView=(AddViewController *)destView;
        addView.username=username;
        addView.currentDate=currentDate;
        addView.flag=0;
    }
    else if([[segue identifier] compare:@"editSegue"]==NSOrderedSame) {
        EditViewController *editView=(EditViewController *)destView;
        Record *record=[[Record alloc]init];
        NSIndexPath *selectIndexPath = [self.listTable indexPathForSelectedRow];
        NSDictionary *item=[data objectAtIndex:selectIndexPath.row];
        record.id=[[NSString stringWithFormat:@"%@",[item valueForKey:@"id"]] integerValue];
        record.username=[NSString stringWithFormat:@"%@",[item valueForKey:@"username"]];
        record.addTime=[NSString stringWithFormat:@"%@",[item valueForKey:@"addTime"]];
        record.money=[[NSString stringWithFormat:@"%@",[item valueForKey:@"money"]] integerValue];
        record.des=[NSString stringWithFormat:@"%@",[item valueForKey:@"des"]];
        record.type=[[NSString stringWithFormat:@"%@",[item valueForKey:@"type"]] integerValue];
        record.accountType=[[NSString stringWithFormat:@"%@",[item valueForKey:@"accountType"]] integerValue];
        record.year=[[NSString stringWithFormat:@"%@",[item valueForKey:@"year"]] integerValue];
        record.month=[[NSString stringWithFormat:@"%@",[item valueForKey:@"month"]] integerValue];
        record.day=[[NSString stringWithFormat:@"%@",[item valueForKey:@"day"]] integerValue];
        editView.record=record;
        editView.flag=0;
        NSLog(@"segue:%ld",record.money);
    }
}


@end
