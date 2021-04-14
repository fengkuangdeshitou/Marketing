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
#import "DetailViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface AppDelegate ()

@property(nonatomic,strong)LMUniversalObject *linkedUniversalObject;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    if ([PreHelper isLogin]) {
        MyTabbarViewController * tabbar = [[MyTabbarViewController alloc] init];
        self.window.rootViewController = tabbar;
    }else{
        LoginViewController * login = [[LoginViewController alloc] init];
        CustomNavagationController * nav = [[CustomNavagationController alloc] initWithRootViewController:login];
        nav.navigationBar.hidden = true;
        self.window.rootViewController = nav;
    }
    
    //9a36d88e4c646b80f6870e4e1cf0c165
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        [platformsRegister setupWeChatWithAppId:@"wxc8c23f591003b7ff" appSecret:nil universalLink:@"https://oxqkw.share2dlink.com/"];
    }];
    
    LinkedME* linkedme = [LinkedME getInstance];
    //设置重试次数
//    [linkedme setMaxRetries:60];
    //设置重试间隔时间
//    [linkedme setRetryInterval:1];
    //打印日志
//    [linkedme setDebug];
    
    [linkedme disableClipboardMatch];
    
//    DetailViewController * detail = [[DetailViewController alloc] init];
//    [linkedme registerDeepLinkController:detail forKey:@"DetailViewController"];
//    //获取跳转参数
//    [linkedme initSessionWithLaunchOptions:launchOptions automaticallyDisplayDeepLinkController:NO deepLinkHandler:^(NSDictionary* params, NSError* error) {
//        if (!error) {
//            //防止传递参数出错取不到数据,导致App崩溃这里一定要用try catch
//            @try {
//                NSLog(@"LinkedME finished init with params = %@",[params description]);
//                //获取标题
//                NSString *title = [params objectForKey:@"$og_title"];
//                NSString *tag = params[@"$control"][@"View"];
//
//                if (title.length >0 && tag.length >0) {
//
//                    //[自动跳转]使用自动跳转
//                    //SDK提供的跳转方法
//                    /**
//                     *  pushViewController : 类名
//                     *  storyBoardID : 需要跳转的页面的storyBoardID
//                     *  animated : 是否开启动画
//                     *  customValue : 传参
//                     *
//                     *warning  需要在被跳转页中实现次方法 - (void)configureControlWithData:(NSDictionary *)data;
//                     */
//
//                    //[LinkedME pushViewController:title storyBoardID:@"detailView" animated:YES customValue:@{@"tag":tag} completion:^{
//
//                    //}];
//
//                    //自定义跳转
//                    detail.openUrl = params[@"$control"][@"ViewId"];
//                    [[LinkedME getViewController] showViewController:detail sender:nil];
//
//                }
//
//            } @catch (NSException *exception) {
//
//            } @finally {
//
//            }
//        } else {
//            NSLog(@"LinkedME failed init: %@", error);
//        }
//    }];

    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation{
    //判断是否是通过LinkedME的UrlScheme唤起App
    if ([[url description] rangeOfString:@"click_id"].location != NSNotFound) {
        return [[LinkedME getInstance] handleDeepLink:url];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication*)application continueUserActivity:(NSUserActivity*)userActivity restorationHandler:(void (^)(NSArray*))restorationHandler{
    
    //判断是否是通过LinkedME的Universal Links唤起App
    if ([[userActivity.webpageURL description] rangeOfString:@"lkme.cc"].location != NSNotFound) {
        return  [[LinkedME getInstance] continueUserActivity:userActivity];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    NSLog(@"opened app from URL %@", [url description]);
    
    //判断是否是通过LinkedME的UrlScheme唤起App
    if ([[url description] rangeOfString:@"click_id"].location != NSNotFound) {
        return [[LinkedME getInstance] handleDeepLink:url];
    }
    return YES;
}

@end
