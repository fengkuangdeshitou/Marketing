//
//  AppDelegate.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "AppDelegate.h"
#import "MyTabbarViewController.h"
#import "LoginViewController.h"
#import "CustomNavagationController.h"
#import <LinkedME_iOS/LinkedME.h>
#import <ShareSDK/ShareSDK.h>
#import "UpdateAlertView.h"
#import <UMCommon/UMCommon.h>

@interface AppDelegate ()

@property(nonatomic,strong)LMUniversalObject *linkedUniversalObject;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    
    MyTabbarViewController * tabbar = [[MyTabbarViewController alloc] init];
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
    
    [UMConfigure initWithAppkey:@"60ab5c95c9aacd3bd4e48e78" channel:@"App Store"];
    
    //9a36d88e4c646b80f6870e4e1cf0c165
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        [platformsRegister setupWeChatWithAppId:@"wxc8c23f591003b7ff" appSecret:nil universalLink:@"https://oxqkw.share2dlink.com/"];
    }];
    
    [self loadLinkMEWithLaunchOptions:launchOptions];
    [self loadIosAuditStateUrl];
    [self getAppUpdateVersion];
    
    return YES;
}

- (void)loadLinkMEWithLaunchOptions:(NSDictionary *)launchOptions{
    [DeviceTool shareInstance].h5Url = @"";
    LinkedME* linkedme = [LinkedME getInstance];
    //设置重试次数
    [linkedme setMaxRetries:60];
    //设置重试间隔时间
    [linkedme setRetryInterval:1];
    //打印日志
    [linkedme setDebug];
    //关闭剪切板匹配功能
    [linkedme disableClipboardMatch];
    //获取跳转参数
    [linkedme initSessionWithLaunchOptions:launchOptions automaticallyDisplayDeepLinkController:NO deepLinkHandler:^(NSDictionary* params, NSError* error) {
        if (!error) {
            //防止传递参数出错取不到数据,导致App崩溃这里一定要用try catch
            @try {
                NSLog(@"LinkedME finished init with params = %@",[params description]);
                [DeviceTool shareInstance].h5Url = params[@"h5_url"];
            } @catch (NSException *exception) {

            } @finally {

            }
        } else {
            NSLog(@"LinkedME failed init: %@", error);
        }
    }];
}

- (void)loadIosAuditStateUrl{
    [NetworkWorker networkGet:[NetworkUrlGetter getIosAuditStateUrl] success:^(NSDictionary *result) {
        [DeviceTool shareInstance].reviewStatus = result[@"str"];
//        [DeviceTool shareInstance].reviewStatus = REVIEWING;
        if ([[DeviceTool shareInstance].reviewStatus isEqualToString:APPROVED]) {
            if ([PreHelper isLogin]) {
                MyTabbarViewController * tabbar = [[MyTabbarViewController alloc] init];
                self.window.rootViewController = tabbar;
            }else{
                LoginViewController * login = [[LoginViewController alloc] init];
                CustomNavagationController * nav = [[CustomNavagationController alloc] initWithRootViewController:login];
                self.window.rootViewController = nav;
            }
        }
    } failure:^(NSString *errorMessage) {
        
    }];
}

/// 版本更新检查
- (void)getAppUpdateVersion{
    [NetworkWorker networkGet:[NetworkUrlGetter getAppVersion] success:^(NSDictionary *result) {
        
        NSArray * list = result[@"List"];
        
        if (list.count == 0) {
            return;
        }
        
        NSDictionary * updateInfo = list.firstObject;
        
        NSString * currentVersionString = [DeviceTool shareInstance].appVersion;
        NSString * onlineVersionString = updateInfo[@"title"];
        
        if ([currentVersionString isEqualToString:onlineVersionString]) {
            return;
        }
        
        if (currentVersionString.length < onlineVersionString.length) {
            currentVersionString = [currentVersionString stringByAppendingString:@".0"];
        }else if (onlineVersionString.length < currentVersionString.length){
            onlineVersionString = [onlineVersionString stringByAppendingString:@".0"];
        }
        
        NSInteger currentVersion = [currentVersionString stringByReplacingOccurrencesOfString:@"." withString:@""].integerValue;
        NSInteger onlineVersion = [onlineVersionString stringByReplacingOccurrencesOfString:@"." withString:@""].integerValue;
        
        if (currentVersion < onlineVersion) {
            [self showUpdateView:updateInfo];
        }
        
    } failure:^(NSString *errorMessage) {
        
    }];
}

- (void)showUpdateView:(NSDictionary *)result{
    [UpdateAlertView showUpdateAlertViewWithData:result];
}

- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation{
    //判断是否是通过LinkedME的UrlScheme唤起App
//    if ([[url description] rangeOfString:@"click_id"].location != NSNotFound) {
        return [[LinkedME getInstance] handleDeepLink:url];
//    }
    
//    return YES;
}

- (BOOL)application:(UIApplication*)application continueUserActivity:(NSUserActivity*)userActivity restorationHandler:(void (^)(NSArray*))restorationHandler{
    
    //判断是否是通过LinkedME的Universal Links唤起App
//    if ([[userActivity.webpageURL description] rangeOfString:@"lkme.cc"].location != NSNotFound) {
        return  [[LinkedME getInstance] continueUserActivity:userActivity];
//    }
//
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    NSLog(@"opened app from URL %@", [url description]);
    
    //判断是否是通过LinkedME的UrlScheme唤起App
//    if ([[url description] rangeOfString:@"click_id"].location != NSNotFound) {
        return [[LinkedME getInstance] handleDeepLink:url];
//    }
//    return YES;
}

@end
