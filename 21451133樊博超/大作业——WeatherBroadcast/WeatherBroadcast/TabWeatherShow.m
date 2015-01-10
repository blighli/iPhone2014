//
//  TabWeatherShow.m
//  WeatherBroadcast
//
//  Created by 樊博超 on 14-12-22.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "TabWeatherShow.h"
#import "Logger.h"

@interface TabWeatherShow ()
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *weatherName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *weather2;
@property (weak, nonatomic) IBOutlet UILabel *temperature2;
@property (weak, nonatomic) IBOutlet UILabel *weather3;
@property (weak, nonatomic) IBOutlet UILabel *temperature3;
- (IBAction)refresh:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *weatherView;
@property (weak, nonatomic) IBOutlet UIImageView *weatherView2;
@property (weak, nonatomic) IBOutlet UIImageView *weatherView3;


@end

@implementation TabWeatherShow

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchDataFromWeb];
//    _cityName.a
    // Do any additional setup after loading the view.
}

-(void)fetchDataFromWeb{
    NSUserDefaults *mySettingDataR = [NSUserDefaults standardUserDefaults];
    
//    NSString *urlString =[[NSString alloc] initWithFormat:@"http://m.weather.com.cn/data/%@.html",[mySettingDataR objectForKey:@"cityCode"]];
    NSString *new = [mySettingDataR objectForKey:@"cityCode"];
    
    NSString *urlString =[[NSString alloc] initWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=A72e372de05e63c8740b2622d0ed8ab1",new];
    NSLog(urlString);
    NSString *encoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encoded];
    if (url == nil) {
        NSLog(@"Invalid URL");
        return;
    }
//    Logger *logger = [[Logger alloc] init];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    __unused NSURLConnection *fetchConn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    NSLog(@"received %lu bytes", [data length]);
    if (!incomingData) {
        incomingData = [[NSMutableData alloc] init]; }
    [incomingData appendData:data];
}

//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    NSError *error;
//    NSLog(@"Got it all!");
//    NSString *string
//    = [[NSString alloc] initWithData:incomingData
//                            encoding:NSUTF8StringEncoding]; NSLog(@"The whole string is %@", string);
//    
//    weatherDic = [NSJSONSerialization JSONObjectWithData:incomingData options:NSJSONReadingMutableLeaves error:&error];
//    weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
//    
//    NSString *k = [[NSString alloc] initWithString:[NSString stringWithFormat:@"今天是 %@  %@",[weatherInfo objectForKey:@"date_y"],[weatherInfo objectForKey:@"week"]]];
//
//    [_weatherName setText:[weatherInfo objectForKey:@"weather1"]];
//    [_cityName setText:[weatherInfo objectForKey:@"currentCitycity"]];
//    [_time setText:k];
//    [_temperature setText:[weatherInfo objectForKey:@"temp1"]];
//    [_weather2  setText:[weatherInfo objectForKey:@"weather2"]];
//    [_weather3  setText:[weatherInfo objectForKey:@"weather3"]];
//    [_temperature2  setText:[weatherInfo objectForKey:@"temp2"]];
//    [_temperature3  setText:[weatherInfo objectForKey:@"temp3"]];
//    incomingData = nil;
//}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"Got it all!");
    NSString *string
    = [[NSString alloc] initWithData:incomingData
                            encoding:NSUTF8StringEncoding]; NSLog(@"The whole string is %@", string);
    NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
    
    [mySettingData setObject:incomingData forKey:@"weatherData"];
    [mySettingData synchronize];
    [self setTheView];
       incomingData = nil;
}

-(void)setTheView{
    NSError *error;
    weatherDic = [NSJSONSerialization JSONObjectWithData:incomingData options:NSJSONReadingMutableLeaves error:&error];
    NSArray *results = [weatherDic objectForKey:@"results"];
    NSArray *weather_data = [[results objectAtIndex:0] objectForKey:@"weather_data"];
    [_weatherName setText:[[weather_data objectAtIndex:0] objectForKey:@"weather"]];
    [_cityName setText:[[results objectAtIndex:0] objectForKey:@"currentCity"]];
    [_time setText:[[weather_data objectAtIndex:0] objectForKey:@"date"]];
    [_temperature setText:[[weather_data objectAtIndex:0] objectForKey:@"temperature"]];
    [_weather2  setText:[[weather_data objectAtIndex:1] objectForKey:@"weather"]];
    [_weather3  setText:[[weather_data objectAtIndex:2] objectForKey:@"weather"]];
    [_temperature2  setText:[[weather_data objectAtIndex:1] objectForKey:@"temperature"]];
    [_temperature3  setText:[[weather_data objectAtIndex:2] objectForKey:@"temperature"]];
    
    //获取当前时间
    NSDate* now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:now];
    
    
    long hour = [dd hour];
    
    
    //设置图片
    NSString *imgUrl;
    NSString *imgUrl2;
    NSString *imgUrl3;
    if (hour >= 7 && hour <= 19) {
        imgUrl = [[weather_data objectAtIndex:0] objectForKey:@"dayPictureUrl"];
        imgUrl2 = [[weather_data objectAtIndex:1] objectForKey:@"dayPictureUrl"];
        imgUrl3 = [[weather_data objectAtIndex:2] objectForKey:@"dayPictureUrl"];
    }else{
        imgUrl = [[weather_data objectAtIndex:0] objectForKey:@"nightPictureUrl"];
        imgUrl2 = [[weather_data objectAtIndex:1] objectForKey:@"nightPictureUrl"];
        imgUrl3 = [[weather_data objectAtIndex:2] objectForKey:@"nightPictureUrl"];
    }
    
    NSURL *url=[NSURL URLWithString:imgUrl];
    UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
    [_weatherView setImage:imgFromUrl];
    NSURL *url2=[NSURL URLWithString:imgUrl2];
    UIImage *imgFromUrl2 =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url2]];
    [_weatherView2 setImage:imgFromUrl2];
    NSURL *url3=[NSURL URLWithString:imgUrl3];
    UIImage *imgFromUrl3 =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url3]];
    [_weatherView3 setImage:imgFromUrl3];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)refresh:(id)sender {
    [self fetchDataFromWeb];
}
@end
