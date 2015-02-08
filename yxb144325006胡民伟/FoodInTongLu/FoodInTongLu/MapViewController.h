//
//  MapViewController.h
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/13.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Restaurant.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) Restaurant *restaurant;
@end
