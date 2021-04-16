//
//  ImageLoader.h
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageLoader : NSObject

+ (void)loadBtnImage:(UIButton *)dirBtn
                 url:(NSString *)url
         placeholder:(UIImage *)placeholder
             success:(void (^)(UIImage *image))success
                fail:(void (^)(NSError *error))fail;

+ (void)loadImage:(UIImageView *)imageView url:(NSString *)url placeholder:(UIImage *)placeholder;

+ (void)downloadImageByUrl:(NSString *)url
                   success:(void (^)(UIImage *image))success
                      fail:(void (^)(NSError *error))fail;

+ (UIImage *)getCenterImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (UIImage *)getCenterImageByData:(NSData *)data scaledToSize:(CGSize)newSize;

+ (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (NSString *)getCreateImageName:(NSString *)userId;

+ (NSString *)getCreateVidelName;

+ (NSString *)md5:(NSString *)input;

+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (UIImage*)getVideoFirstViewImage:(NSString *)path;

@end
