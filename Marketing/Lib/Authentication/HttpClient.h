//
//  Model.h
//  Marketing
//
//  Created by maiyou on 2021/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ClientCallback)(NSString* resultStr);

@interface HttpClient : NSObject

- (void)requestSync:(NSString*)url bodyString:(NSString *)bodyString  clientCallback:(ClientCallback)clientCallback;

@end

NS_ASSUME_NONNULL_END
