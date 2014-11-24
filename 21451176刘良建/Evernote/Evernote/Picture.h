//
//  Picture.h
//  Evernote
//
//  Created by JANESTAR on 14-11-23.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Picture : NSManagedObject

@property (nonatomic, retain) NSString * subloc;
@property (nonatomic, retain) NSString * loc;

@end
