//
//  TabDetailShow.m
//  WeatherBroadcast
//
//  Created by 樊博超 on 14-12-22.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "TabDetailShow.h"

@interface TabDetailShow ()
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *pmLevel;
@property (weak, nonatomic) IBOutlet UILabel *tips;
@property (weak, nonatomic) IBOutlet UIImageView *wearingView;
@property (weak, nonatomic) IBOutlet UIImageView *tourView;
@property (weak, nonatomic) IBOutlet UIImageView *sportView;
@property (weak, nonatomic) IBOutlet UIImageView *sunshineView;
@property (weak, nonatomic) IBOutlet UILabel *wearingLevel;
@property (weak, nonatomic) IBOutlet UILabel *tourLevel;
@property (weak, nonatomic) IBOutlet UILabel *sportLevel;
@property (weak, nonatomic) IBOutlet UILabel *sunshineLevel;

@end

@implementation TabDetailShow

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTheView];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTheView{
    NSError *error;
    NSUserDefaults *mySettingDataR = [NSUserDefaults standardUserDefaults];
    NSData *data = [mySettingDataR objectForKey:@"weatherData"];
    NSMutableDictionary *weatherDic;
    weatherDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *results = [weatherDic objectForKey:@"results"];
    NSString *pm = [[results objectAtIndex:0] objectForKey:@"pm25"];
    int pmint = [pm intValue];
    if (pmint < 50) {
        [_pmLevel setText:[NSString stringWithFormat:@"%@ %@",[[results objectAtIndex:0] objectForKey:@"pm25"], @"优"]];
        [_pmLevel setTextColor:[UIColor greenColor]];
    }else if (pmint <100){
        [_pmLevel setText:[NSString stringWithFormat:@"%@ %@",[[results objectAtIndex:0] objectForKey:@"pm25"], @"良"]];
        [_pmLevel setTextColor:[UIColor yellowColor]];
    }else if (pmint < 150){
        [_pmLevel setText:[NSString stringWithFormat:@"%@ %@",[[results objectAtIndex:0] objectForKey:@"pm25"], @"轻度污染"]];
        [_pmLevel setTextColor:[UIColor orangeColor]];
    }else if (pmint < 200){
        [_pmLevel setText:[NSString stringWithFormat:@"%@ %@",[[results objectAtIndex:0] objectForKey:@"pm25"], @"中度污染"]];
        [_pmLevel setTextColor:[UIColor redColor]];
    }else if (pmint < 330){
        [_pmLevel setText:[NSString stringWithFormat:@"%@ %@",[[results objectAtIndex:0] objectForKey:@"pm25"], @"重度污染"]];
        [_pmLevel setTextColor:[UIColor purpleColor]];
    }else{
        [_pmLevel setText:[NSString stringWithFormat:@"%@ %@",[[results objectAtIndex:0] objectForKey:@"pm25"], @"严重污染"]];
        [_pmLevel setTextColor:[UIColor brownColor]];
    }
    [_cityName setText:[[results objectAtIndex:0] objectForKey:@"currentCity"]];
    NSArray *index = [[results objectAtIndex:0] objectForKey:@"index"];
    
    [_wearingLevel setText:[[index objectAtIndex:0] objectForKey:@"zs"]];
    [_tourLevel setText:[[index objectAtIndex:2] objectForKey:@"zs"]];
    [_sportLevel setText:[[index objectAtIndex:4] objectForKey:@"zs"]];
    [_sunshineLevel setText:[[index objectAtIndex:5] objectForKey:@"zs"]];
    
    _tips.lineBreakMode = UILineBreakModeCharacterWrap;
    _tips.numberOfLines = 0;
    [_tips setText:[[index objectAtIndex:3] objectForKey:@"des"]];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
