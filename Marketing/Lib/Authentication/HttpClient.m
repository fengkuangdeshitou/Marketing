//
//  Model.m
//  Marketing
//
//  Created by maiyou on 2021/3/10.
//

#import "HttpClient.h"

@implementation HttpClient{
    NSURL *_url;
}

// 为了方便把流程说清楚，这里用了同步方法，在接入的时候兼用用异步方式实现。
- (void)requestSync:(NSString*)url bodyString:(NSString *)bodyString  clientCallback:(ClientCallback)clientCallback {
    NSLog(@"bodyString = %@",bodyString);
    _url = [NSURL URLWithString: url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url
                                                                       cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                                   timeoutInterval:10];
    //POST请求
    [request setHTTPMethod:@"POST"];
    //把bodyString转换为NSData数据
    bodyString = [bodyString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSData *bodyData =  [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request addValue:@"application/x-www-form-urlencoded ;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //防重放
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    [request setValue:dateStr forHTTPHeaderField:@"X-Ca-Nonce"];
    //APPCODE
    //TODO 替换成自己的appCode
    [request setValue:@"68b291c8c4874247ae3ef17988d2e4a8" forHTTPHeaderField:@"Authorization"];
    //测试环境
    [request addValue:@"TEST" forHTTPHeaderField:@"X-Ca-Stage"];
    //body 数据
    [request setHTTPBody:bodyData];
    //创建任务
    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"%@",((NSHTTPURLResponse*)response).allHeaderFields);
            NSLog(@"%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            NSLog(@"%@", error);
            NSString* resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            clientCallback(resultStr);
        }else{
            clientCallback(nil);
        }
    }];
    
    //开启网络任务
    [task resume];
}

@end
