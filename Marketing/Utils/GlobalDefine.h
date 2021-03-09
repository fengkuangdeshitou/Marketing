//
//  GlobalDefine.h
//  TravelMan
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#define kDuration 0.25

#define StatusBarHeight         [UIApplication sharedApplication].statusBarFrame.size.height

#define iosVersion              [[[UIDevice currentDevice] systemVersion] floatValue]

#define requestSuccess                                 1
#define requestFail                                    0

#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/**
 UserDefaults
 */
#define K_UD_SAVE(obj, key) [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key]

#define K_UD_READ(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
