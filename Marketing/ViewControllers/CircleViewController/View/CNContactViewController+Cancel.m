//
//  CNContactViewController+Cancel.m
//  Marketing
//
//  Created by 王帅 on 2021/3/10.
//

#import "CNContactViewController+Cancel.h"
#import <objc/runtime.h>

@implementation CNContactViewController (Cancel)

+(void)load{
//    SEL originalSelector = NSSelectorFromString(@"editCancel:");
//    SEL swizzledSelector = NSSelectorFromString(@"cancelHack");
//    Method originalMethod = class_getInstanceMethod(objc_getClass("CNContactViewController"), originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(objc_getClass("CNContactViewController"), swizzledSelector);
//    method_exchangeImplementations(originalMethod, swizzledMethod);
}

-(void)cancelHack{
    [self.delegate contactViewController:self didCompleteWithContact:self.contact];
}


@end
