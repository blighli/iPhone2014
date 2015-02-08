//
//  Restaurant.h
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/18.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Restaurant : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * isVisited;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;

//-(id)initWithName:(NSString*) name andType:(NSString*)type andLocation:(NSString*)location andImage:(NSData*)image andIsVisited:(NSNumber*)isVisited;
@end
