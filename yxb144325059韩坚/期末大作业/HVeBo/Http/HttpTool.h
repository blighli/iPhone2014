//
//  HttpTool.h
//  HVeBo
//
//  Created by HJ on 14/12/10.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^myBHttpRequest )(WBHttpRequest *request, id result, NSError *error);

@interface HttpTool : NSObject

+ (void)dowloadImage:(NSString *)url iamgeview:(UIImageView *)iamgeviewv placeHolder:(UIImage *) placeHolder;

//+ (void)dowloadImageBig:(NSString *)url iamgeview:(UIImageView *)iamgeviewv placeHolder:(UIImage *) placeHolder;

+ (void)wbHttpRequest:(NSString *)url httpMethod:(NSString *)httpMethod params:(NSMutableDictionary *)params hander:(myBHttpRequest)hander;


@end
