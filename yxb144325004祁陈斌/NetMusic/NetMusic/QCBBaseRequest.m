//
//  QCBBaseRequest.m
//  NetMusic
//
//  Created by xsdlr on 14/12/4.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "QCBBaseRequest.h"

@interface QCBBaseRequest()

@end

@implementation QCBBaseRequest

+ (AFHTTPRequestOperationManager*) OperationManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer setValue:@"application/json" forKey:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json" forKey:@"content-type"];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forKey:@"Accept"];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forKey:@"content-type"];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithArray:@[@"application/json",@"application/javascript",@"application/x-www-form-urlencoded",@"charset=utf-8",@"image/*"]];
    return manager;
}

+ (AFURLSessionManager*) SessionManager {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    return manager;
}

+ (AFHTTPRequestOperation *)GETRequestWithPath:(NSString *)path
                                    parameters:(NSDictionary*) parameters
                                       success:(requestSuccess)success
                                          fail:(requestError)fail {
    AFHTTPRequestOperation *operation = [[QCBBaseRequest OperationManager] GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* dic = [QCBBaseRequest parseJSON: responseObject];
        success(dic);
    }  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(error);
    }];
    return operation;
}

+ (NSDictionary *)parseJSON:(NSObject *)jsonObject {
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary*) jsonObject;
    } else {
        return nil;
    }
}

+ (NSURLSessionDownloadTask *)downloadFile:(NSString *)path
                                    rename:(NSString*) rename
                                   success:(requestSuccess)success
                                      fail:(requestError)fail {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    NSURLSessionDownloadTask *downloadTask = [[QCBBaseRequest SessionManager] downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        if (rename && rename.length>0) {
            return [documentsDirectoryURL URLByAppendingPathComponent:rename];
        } else {
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        }
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (!error) {
            success(filePath);
        } else {
            fail(error);
        }
    }];
    [downloadTask resume];
    return downloadTask;
}
@end
