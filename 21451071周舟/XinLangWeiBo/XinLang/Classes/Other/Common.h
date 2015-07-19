//
//  Common.h
//  XinLang
//
//  Created by 周舟 on 14-9-29.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#ifndef XinLang_Common_h
#define XinLang_Common_h

//0.账号相关

#define XLAppKey @"3607049420"
#define XLAppSecret @"4d86433b6cd893b8aab3f85b943c4edd"
#define XLRedirectURI @"http://www.baidu.com"
#define XLLoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", XLAppKey, XLRedirectURI]

//1.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)


//2.获得的RGB颜色
#define XLColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]




//3.微博cell上的属性
#define XLStatusCellBorder 10
/**
 *  头像的宽高
 */
#define XLStatusCellIconWH 35

/**
 *  昵称的字体
 */
#define XLStatusNameFont [UIFont systemFontOfSize:15]
/**
 *  被转发微博昵称的字体
 */
#define XLRetweetStatusNameFont XLStatusNameFont
/** 时间的字体 */
#define XLStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define XLStatusSourceFont XLStatusTimeFont

/** 正文的字体 */
#define XLStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define XLRetweetStatusContentFont XLStatusContentFont

/** 表格的边框宽度 */
#define XLStatusTableBorder 5


//4.微博cell的内部相册
/**
 *  多张照片宽高
 */
#define XLPhotoW 70
#define XLPhotoH 70
/**
 *  图片的间距
 */
#define XLPhotoMargin 10

#define XLSinglePhotoWH 140

#endif
