//
//  DoubanSong.h
//  DoubanFM
//
//  Created by 陈聪荣 on 14/12/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoubanSong : NSObject

//{"album":"\/subject\/1850556\/","picture":"http:\/\/img3.douban.com\/lpic\/s1742323.jpg","ssid":"9174","artist":"Sizzla","url":"http:\/\/mr3.douban.com\/201412111318\/bf8aedfefb96f83071c2fe179e5c85a0\/view\/song\/small\/p2184749.mp3","company":"Warner","title":"Same Complain","rating_avg":3.61873,"length":216,"subtype":"","public_time":"2005","songlists_count":0,"sid":"2184749","aid":"1850556","sha256":"3ca648d7d783fe499eb14d9818f3ddb9c8a467575b1702cdeb0dab2aab7688ce","kbps":"64","albumtitle":"Reggae Gold 2005","like":"0"}
@property(strong , nonatomic) NSString* title;
@property(strong , nonatomic) NSString* artist;
@property(strong , nonatomic) NSString* picUrl;
@property(strong , nonatomic) NSString* songUrl;
@property(strong , nonatomic) NSString* length;
@property(strong , nonatomic) NSString* rating_avg;
@property(strong , nonatomic) NSString* albumtitle;
@end
