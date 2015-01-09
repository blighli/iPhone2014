//
//  Music.h
//  MyMusicPlayer
//
//  Created by 张榕明 on 15/01/01.
//  Copyright (c) 2015年 张榕明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject {
    NSString *name;
    NSString *type;
}
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *type;

- (id)initWithName:(NSString *)_name andType:(NSString *)_type;
@end