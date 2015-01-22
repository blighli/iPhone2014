//
//  IncomeCountViewController.m
//  EasyCount
//
//  Created by yingxl1992 on 15/1/8.
//  Copyright (c) 2015年 21451043应晓立. All rights reserved.
//

#import "IncomeCountViewController.h"

@interface IncomeCountViewController ()

@end

@implementation IncomeCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *userInfo=[NSUserDefaults standardUserDefaults];
    username=[userInfo objectForKey:@"username"];
    titleStrs=[[NSArray alloc]initWithObjects:@"薪水",@"奖金",@"补助费",@"投资",@"其它",nil];
    
    [self receiveData:0];
    
    sliceColors =[NSArray arrayWithObjects:
                  [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                  [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                  [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                  [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                  [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    
    [self.countPie setDelegate:self];
    [self.countPie setDataSource:self];
    CGRect rect=[self.view frame];
    [self.countPie setPieCenter:CGPointMake(rect.size.width/2, rect.size.height/3)];
    [self.countPie setShowPercentage:YES];
    [self.countPie setLabelColor:[UIColor blackColor]];
    
    [_yearBtn addTarget:self action:@selector(yearCount) forControlEvents:1];
    [_monthBtn addTarget:self action:@selector(monthCount) forControlEvents:1];
    [_dayBtn addTarget:self action:@selector(dayCount) forControlEvents:1];
    
    NSLog(@"%ld",type);
}

- (void)yearCount {
    [self receiveData:0];
    [_countPie reloadData];
    NSLog(@"yearCount");
}

- (void)monthCount {
    [self receiveData:1];
    [_countPie reloadData];
    NSLog(@"monthCount");
}

- (void)dayCount {
    [self receiveData:2];
    [_countPie reloadData];
    NSLog(@"dayCount");
}

//通过ws获取数据
- (void)receiveData:(NSInteger) flag {
    //获取当天日期
    NSDateComponents *datecomponents = [[NSCalendar currentCalendar] components: NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger year=[datecomponents year];
    NSInteger month=[datecomponents month];
    NSInteger day=[datecomponents day];
    
    NSURL *url;
    NSString *paramstr;
    if (flag==0) {
        url=[NSURL URLWithString:@"http://localhost:8080/income/countByYear"];
        paramstr=[NSString stringWithFormat:@"username=%@&&year=%ld",username,year];
    } else if(flag==1) {
        url=[NSURL URLWithString:@"http://localhost:8080/income/countByMonth"];
        paramstr=[NSString stringWithFormat:@"username=%@&&year=%ld&&month=%ld",username,year,month];
    } else {
        url=[NSURL URLWithString:@"http://localhost:8080/income/countByDay"];
        paramstr=[NSString stringWithFormat:@"username=%@&&year=%ld&&month=%ld&&day=%ld",username,year,month,day];
    }
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    
    NSData *params=[paramstr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:params];
    
    NSData *received=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingAllowFragments error:&error];
    NSArray *data= (NSArray *)jsonObject;
    slices = [NSMutableArray arrayWithCapacity:[data count]];
    titles = [NSMutableArray arrayWithCapacity:[data count]];
    for(int i = 0; i < [data count]; i ++)
    {
        [slices addObject:[[data objectAtIndex:i] objectForKey:@"sum"]];
        NSString *typeStr=[NSString stringWithFormat:@"%@",[[data objectAtIndex:i] objectForKey:@"type"]];
        [titles addObject:[titleStrs objectAtIndex:[typeStr integerValue]]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_countPie reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return [slices count];
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[slices objectAtIndex:index] intValue];
}

- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index {
    return [titles objectAtIndex:index];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [sliceColors objectAtIndex:(index % sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %ld",index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %ld",index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %ld",index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    _resLable.text=[NSString stringWithFormat:@"%@:RMB%@",[titleStrs objectAtIndex:index],[slices objectAtIndex:index]];
}


@end
