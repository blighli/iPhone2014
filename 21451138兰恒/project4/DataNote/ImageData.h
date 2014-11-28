//
//  ImageData.h
//  DataNote
//
//  Created by lh on 14-11-27.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MyNote;

@interface ImageData : NSManagedObject

@property (nonatomic, retain) NSString * image_path;
@property (nonatomic, retain) MyNote *imageTONote;

@end
