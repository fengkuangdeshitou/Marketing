//
//  UserModel.m
//  Marketing
//
//  Created by 王帅 on 2021/3/18.
//

#import "UserModel.h"
#import <objc/runtime.h>

@implementation UserModel


- (void)encodeWithCoder:(NSCoder *)coder {
    unsigned int numberOfIvars = 0;
    //成员变量
    Ivar *ivars = class_copyIvarList([self class], &numberOfIvars);
    
    for (const Ivar *p = ivars; p < ivars + numberOfIvars; p++) {
        Ivar const ivar = *p;
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [coder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}
 
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        unsigned int numberOfIvars = 0;
        //成员变量
        Ivar *ivars = class_copyIvarList([self class], &numberOfIvars);
        
        for (const Ivar *p = ivars; p < ivars + numberOfIvars; p++) {
            Ivar const ivar = *p;
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[coder decodeObjectForKey:key] forKey:key];
        }
        free(ivars);
    }
    return self;
}

@end
