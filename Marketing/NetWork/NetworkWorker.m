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
    if ([UserManager getUser].token) {
        [_headers setValue:[UserManager getUser].token forKey:@"token"];
    }
    return _headers;
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    return _manager;
}

+ (void)showNetworkActivityIndicatorVisible{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });

    UIViewController * currentController = [PreHelper getCurrentVC];
    [currentController showHudInView:currentController.view hint:currentController.loadString];
}

+ (void)dismissNetworkActivityIndicatorVisible{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
    [[PreHelper getCurrentVC] hideHud];
}

+ (void)networkGet:(NSString *)URLString
           success:(RequestSuccessCompletion)success
           failure:(RequestFailureCompletion)failure {
    [self showNetworkActivityIndicatorVisible];
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NetworkWorker * network = [NetworkWorker shareInstance];
    [network.manager GET:URLString parameters:nil headers:network.headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result=%@",result);
        if ([[result objectForKey:@"code"] intValue] == requestSuccess) {
            success(result);
        }else{
            failure(result[@"msg"]);
        }
        [self dismissNetworkActivityIndicatorVisible];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dismissNetworkActivityIndicatorVisible];
    }];
    
}

+ (void)networkPost:(NSString *)URLString
                params:(NSDictionary *)jsonString
               success:(RequestSuccessCompletion)success
               failure:(RequestFailureCompletion)failure {
    [self showNetworkActivityIndicatorVisible];
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NetworkWorker * network = [NetworkWorker shareInstance];
    [network.manager POST:URLString parameters:jsonString headers:network.headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result=%@",result);
        if ([[result objectForKey:@"code"] intValue] == requestSuccess) {
            success(result);
        }else{
            failure(result[@"msg"]);
        }
        [self dismissNetworkActivityIndicatorVisible];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dismissNetworkActivityIndicatorVisible];
    }];
}

+ (void)networkPost:(NSString *)URLString
           formPostData:(NSData *)postData
        andFileName:(NSString *)fileName
            success:(RequestSuccessCompletion)success
            failure:(RequestFailureCompletion)failure {
    [self showNetworkActivityIndicatorVisible];
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:fileName forKey:@"parts"];
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NetworkWorker * network = [NetworkWorker shareInstance];
    [network.manager POST:URLString parameters:dictionary headers:network.headers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:postData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg/video"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result=%@",result);
        if ([[result objectForKey:@"code"] intValue] == requestSuccess) {
            success(result);
        }else{
            failure(result[@"msg"]);
        }
        [self dismissNetworkActivityIndicatorVisible];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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

+ (void)networkOperationCancel {
    NetworkWorker * network = [NetworkWorker shareInstance];
    NSOperationQueue *operationQueue = network.manager.operationQueue;
    if (operationQueue.operations.count > 0) {
        NSOperation *operation = [operationQueue.operations objectAtIndex:0];
        [operation cancel];
    }
}

@end
