//
//  NetworkWorker.h
//  TravelMan
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

//@class AFHTTPRequestOperation;

#import <UIKit/UIKit.h>

@interface NetworkWorker : NSObject

+ (void)networkGet:(NSString *)URLString
           success:(void (^)(NSDictionary *dictionary))success
           failure:(void (^)(NSString *error, NSDictionary *dictionary))failure;

+ (void)networkPost:(NSString *)URLString
           formJson:(NSString *)jsonString
            success:(void (^)(NSDictionary *dictionary))success
            failure:(void (^)(NSString *error, NSDictionary *dictionary))failure;

+ (void)newNetworkPost:(NSString *)URLString
             params:(NSDictionary *)dictionary
            success:(void (^)(NSDictionary *dictionary))success
            failure:(void (^)(NSString *error, NSDictionary *dictionary))failure;


+ (void)networkPost:(NSString *)URLString
           formPostData:(NSData *)paostData
        andFileName:(NSString *)fileName
            success:(void (^)(NSDictionary *dictionary))success
            failure:(void (^)(NSString *error, NSDictionary *dictionary))failure;


+ (void)networkForContentTypePost:(NSString *)URLString
                     formPostDict:(NSDictionary *)dict
                          success:(void (^)(NSDictionary *dictionary))success
                          failure:(void (^)(NSError * error))failure;

+ (void)networkDelete:(NSString *)URLString
           parameters:(NSDictionary *)dictData
              success:(void (^)(NSDictionary * dictionary))success
              failure:(void(^)(NSString * error,NSDictionary * dictionary))failure;

+ (void)networkPut:(NSString *)URLString
       paramenters:(NSDictionary *)parameters
           success:(void(^)(NSDictionary * dictionary))success
           failure:(void(^)(NSString * errar,NSDictionary * dictionary))failure;

+(void)networkOperationCancel;

@end
