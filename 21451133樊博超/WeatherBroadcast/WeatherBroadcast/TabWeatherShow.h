//
//  TabWeatherShow.h
//  WeatherBroadcast
//
//  Created by 樊博超 on 14-12-22.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitySelect.h"
@interface TabWeatherShow : UIViewController
{
    NSMutableData *incomingData;
    
    NSDictionary *weatherDic;
    NSDictionary *weatherInfo;
}
@end
