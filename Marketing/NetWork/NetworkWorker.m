//
//  NetworkWorker.m
//  TravelMan
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import "NetworkWorker.h"
#import "AFNetworking.h"
#import "ImageLoader.h"
#import "GlobalDefine.h"
#import "GlobalState.h"

@implementation NetworkWorker
static AFHTTPSessionManager *manager = nil;

+ (void)showNetworkActivityIndicatorVisible{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
}

+ (void)dismissNetworkActivityIndicatorVisible{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
}

+ (void)networkGet:(NSString *)URLString
           success:(void (^)(NSDictionary *dictionary))success
           failure:(void (^)(NSString *error, NSDictionary *dictionary))failure {
    if (!manager) {
        manager = [AFHTTPSessionManager manager];
    }
    [self showNetworkActivityIndicatorVisible];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",[dictionary objectForKey:@"message"]);
        if ([[dictionary objectForKey:@"success"] intValue] == requestSuccess) {
            success(dictionary);
        } else {
            success(dictionary);
        }
        [self dismissNetworkActivityIndicatorVisible];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"", nil);
        [self dismissNetworkActivityIndicatorVisible];
    }];
    
}

+ (void)newNetworkPost:(NSString *)URLString
              formJson:(NSDictionary *)jsonString
               success:(void (^)(NSDictionary *dictionary))success
               failure:(void (^)(NSString *error, NSDictionary *dictionary))failure {
    
    [self showNetworkActivityIndicatorVisible];
    if (!manager) {
        manager = [AFHTTPSessionManager manager];
    }
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:jsonString progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",[dictionary objectForKey:@"message"]);
        if ([[dictionary objectForKey:@"success"] intValue] == requestSuccess) {
            success(dictionary);
        } else {
            failure([dictionary objectForKey:@"result"], dictionary);
        }
        [self dismissNetworkActivityIndicatorVisible];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"", nil);
        [self dismissNetworkActivityIndicatorVisible];
    }];
}

 
+ (void)networkPost:(NSString *)URLString
           formJson:(NSString *)jsonString
            success:(void (^)(NSDictionary *dictionary))success
            failure:(void (^)(NSString *error, NSDictionary *dictionary))failure {
    [self showNetworkActivityIndicatorVisible];
    if (!manager) {
        manager = [AFHTTPSessionManager manager];
    }
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:URLString parameters:jsonString constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (jsonString) {
            NSData *postData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:postData name:@"data"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",[dictionary objectForKey:@"message"]);
        if ([[dictionary objectForKey:@"success"] intValue] == requestSuccess) {
            success(dictionary);
        } else {
            failure([dictionary objectForKey:@"data"], dictionary);
        }
        [self dismissNetworkActivityIndicatorVisible];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(REQUEST_FAIL, nil);
        [self dismissNetworkActivityIndicatorVisible];
    }];

}

+ (void)networkPost:(NSString *)URLString
           formPostData:(NSData *)postData
        andFileName:(NSString *)fileName
            success:(void (^)(NSDictionary *dictionary))success
            failure:(void (^)(NSString *error, NSDictionary *dictionary))failure {

    [self showNetworkActivityIndicatorVisible];
    if (!manager) {
        manager = [AFHTTPSessionManager manager];
    }
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:fileName forKey:@"name"];
    //NSDictionary *dictionary = [NSDictionary dictionaryWithObject:fileName forKey:@"name"];
    
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:URLString parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:postData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",[dictionary objectForKey:@"success"]);
        if ([[dictionary objectForKey:@"success"] intValue] == requestSuccess) {
            success(dictionary);
        } else {
            failure([dictionary objectForKey:@"data"], dictionary);
        }
        [self dismissNetworkActivityIndicatorVisible];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(REQUEST_FAIL, nil);
        [self dismissNetworkActivityIndicatorVisible];
    }];
}

+ (void)networkForContentTypePost:(NSString *)URLString formPostDict:(NSDictionary *)dict success:(void (^)(NSDictionary *dictionary))success failure:(void (^)(NSError * error))failure
{
    [self showNetworkActivityIndicatorVisible];
    if(!manager){
        manager = [AFHTTPSessionManager manager];
    }
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager POST:URLString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"success"] intValue] == requestSuccess) {
            success(responseObject);
        } else {
            failure(responseObject);
        }
        [self dismissNetworkActivityIndicatorVisible];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [self dismissNetworkActivityIndicatorVisible];
    }];
}

+ (void)networkDelete:(NSString *)URLString parameters:(NSDictionary *)dictData success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *, NSDictionary *))failure
{
    [self showNetworkActivityIndicatorVisible];
    if (!manager) {
        manager = [AFHTTPSessionManager manager];
    }
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager DELETE:URLString parameters:dictData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",[dictionary objectForKey:@"message"]);
        if ([[dictionary objectForKey:@"success"] intValue] == requestSuccess) {
            success(dictionary);
        } else {
            failure([dictionary objectForKey:@"result"], dictionary);
        }
        [self dismissNetworkActivityIndicatorVisible];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"", nil);
        [self dismissNetworkActivityIndicatorVisible];
    }];
}

+ (void)networkPut:(NSString *)URLString
       paramenters:(NSDictionary *)parameters
           success:(void(^)(NSDictionary * dictionary))success
           failure:(void(^)(NSString * errar,NSDictionary * dictionary))failure{
    [self showNetworkActivityIndicatorVisible];
    if(!manager){
        manager = [AFHTTPSessionManager manager];
    }
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",[dictionary objectForKey:@"message"]);
        if ([[dictionary objectForKey:@"success"] intValue] == requestSuccess) {
            success(dictionary);
        } else {
            failure([dictionary objectForKey:@"result"], dictionary);
        }
        [self dismissNetworkActivityIndicatorVisible];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"", nil);
        [self dismissNetworkActivityIndicatorVisible];
    }];
}

+ (void)networkOperationCancel {
    NSOperationQueue *operationQueue = manager.operationQueue;
    if (operationQueue.operations.count > 0) {
        NSOperation *operation = [operationQueue.operations objectAtIndex:0];
        [operation cancel];
    }
}

@end
