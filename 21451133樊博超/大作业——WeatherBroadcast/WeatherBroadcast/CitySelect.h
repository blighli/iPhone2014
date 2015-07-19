//
//  CitySelect.h
//  WeatherBroadcast
//
//  Created by 樊博超 on 14-12-22.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>



@interface CitySelect : UIViewController <UIApplicationDelegate,UITableViewDataSource>
{
    NSMutableArray * cityList;
    NSMutableDictionary * cityCode;
}



@end

