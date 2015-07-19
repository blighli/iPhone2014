//
//  MyPoint.h
//  whereAmI
//
//  Created by lh on 14-12-29.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyPoint : NSObject <MKAnnotation>

@property (nonatomic,readonly)CLLocationCoordinate2D coordinate;
@property (nonatomic,copy)NSString* title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)t;

@end
