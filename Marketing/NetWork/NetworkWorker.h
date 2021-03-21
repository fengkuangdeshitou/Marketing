//
//  NetworkWorker.h
//  TravelMan
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

//@class AFHTTPRequestOperation;

#import <UIKit/UIKit.h>

typedef void(^RequestSuccessCompletion)(NSDictionary *result);
typedef void(^RequestFailureCompletion)(NSString *errorMessage);

@interface NetworkWorker : NSObject

+ (void)networkGet:(NSString *)URLString
           success:(RequestSuccessCompletion)success
           failure:(RequestFailureCompletion)failure;

+ (void)networkPost:(NSString *)URLString
             params:(NSDictionary *)dictionary
            success:(RequestSuccessCompletion)success
            failure:(RequestFailureCompletion)failure;

+ (void)networkPost:(NSString *)URLString
           formPostData:(NSData *)paostData
        andFileName:(NSString *)fileName
            success:(RequestSuccessCompletion)success
            failure:(RequestFailureCompletion)failure;


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
