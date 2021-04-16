/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */
 
#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *LoadStringKey = &LoadStringKey;
static const void *IsHiddenLoadStringKey = &IsHiddenLoadStringKey;
static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (NSString *)loadString{
    return objc_getAssociatedObject(self, LoadStringKey);
}

- (void)setLoadString:(NSString *)loadString{
    objc_setAssociatedObject(self, LoadStringKey, loadString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)isHiddenLoadString{
    return [objc_getAssociatedObject(self, IsHiddenLoadStringKey) boolValue];
}

- (void)setIsHiddenLoadString:(BOOL)isHiddenLoadString{
    objc_setAssociatedObject(self, IsHiddenLoadStringKey, [NSNumber numberWithBool:isHiddenLoadString], OBJC_ASSOCIATION_ASSIGN);
}

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    if (self.isHiddenLoadString) {
        return;
    }
    
    if (self.loadString) {
        hint = self.loadString;
    }else{
        if (!hint) {
            hint = @"加载中";
        }
    }
    if ([self HUD]) {
        return;
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = hint;
    HUD.offset = CGPointMake(0, 0);
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.offset = CGPointMake(0, 150.f);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)showHint:(NSString *)hint yOffset:(CGFloat)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.offset = CGPointMake(0, yOffset);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hideHud{
    [[self HUD] hideAnimated:YES];
}

@end
