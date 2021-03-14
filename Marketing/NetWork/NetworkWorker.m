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

@interface NetworkWorker ()

@property(nonatomic,strong) AFHTTPSessionManager *manager;
@property(nonatomic,strong) NSMutableDictionary * headers;

@end

@implementation NetworkWorker

static NetworkWorker * networkWorker = nil;

+ (instancetype)shareInstance{
    if (!networkWorker) {
        networkWorker = [[NetworkWorker alloc] init];
    }
    return networkWorker;
}

- (NSMutableDictionary *)headers{
    if (!_headers) {
        _headers = [[NSMutableDictionary alloc] init];
    }
    return _headers;
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [_manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    return _manager;
}

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
    [self showNetworkActivityIndicatorVisible];
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NetworkWorker * network = [NetworkWorker shareInstance];
    [network.manager GET:URLString parameters:nil headers:network.headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                params:(NSDictionary *)jsonString
               success:(void (^)(NSDictionary *dictionary))success
               failure:(void (^)(NSString *error, NSDictionary *dictionary))failure {
    [self showNetworkActivityIndicatorVisible];
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NetworkWorker * network = [NetworkWorker shareInstance];
    [network.manager POST:URLString parameters:jsonString headers:network.headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NetworkWorker * network = [NetworkWorker shareInstance];
    [network.manager POST:URLString parameters:jsonString headers:network.headers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:fileName forKey:@"name"];
    //NSDictionary *dictionary = [NSDictionary dictionaryWithObject:fileName forKey:@"name"];
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NetworkWorker * network = [NetworkWorker shareInstance];
    [network.manager POST:URLString parameters:dictionary headers:network.headers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
    NetworkWorker * network = [NetworkWorker shareInstance];
    [network.manager POST:URLString parameters:dict headers:network.headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NetworkWorker * network = [NetworkWorker shareInstance];
    [network.manager DELETE:URLString parameters:dictData headers:network.headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NetworkWorker * network = [NetworkWorker shareInstance];
    [network.manager PUT:URLString parameters:parameters headers:network.headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
    NetworkWorker * network = [NetworkWorker shareInstance];
    NSOperationQueue *operationQueue = network.manager.operationQueue;
    if (operationQueue.operations.count > 0) {
        NSOperation *operation = [operationQueue.operations objectAtIndex:0];
        [operation cancel];
    }
}

@end
