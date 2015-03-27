//
//  NearStatusMapViewController.h
//  HVeBo
//
//  Created by HJ on 14/12/23.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface NearStatusMapViewController : BaseViewController<CLLocationManagerDelegate>

@property (nonatomic, strong) NSArray *data;

@end
