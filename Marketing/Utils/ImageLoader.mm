//
//  ImageLoader.m
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import "SDWebImage.h"
#import "ImageLoader.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "NetworkUrlGetter.h"
#import "UIButton+WebCache.h"
#import "AFNetworkReachabilityManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ImageLoader

+ (void)loadBtnImage:(UIButton *)dirBtn
                 url:(NSString *)url
         placeholder:(UIImage *)placeholder
             success:(void (^)(UIImage *image))success
                fail:(void (^)(NSError *error))fail {
    [dirBtn sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
}

+ (void)loadImageForTable:(UIImageView *)dirImage
                      url:(NSString *)url
                      tag:(NSInteger)tag
              placeholder:(UIImage *)placeholder
                  success:(void (^)(UIImage *image))success
                     fail:(void (^)(NSError *error))fail {
    [dirImage setTag:tag];
    [self downloadImageByUrl:url success:^(UIImage *image) {
        if (image) {
            // 设置图片显示
            if (tag == dirImage.tag) {
                [dirImage setImage:image];
            }
            if (success) {
                success(image);
            }
        }else{
            UIImage *placeholderTemp;
            if (placeholder) {
                placeholderTemp = placeholder;
            } else {
                placeholderTemp = [UIImage imageNamed:@"imgplacehandle"];
            }
            if (tag == dirImage.tag) {
                [dirImage setImage:placeholderTemp];
            }
        }
    } fail:^(NSError *error) {
        if(error){
            fail(error);
        }
    }];
}


+ (void)downloadImageByUrl:(NSString *)url
                   success:(void (^)(UIImage *image))success
                      fail:(void (^)(NSError *error))fail {
    SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
    NSURL *imageUrl = [NSURL URLWithString:url];
    [manager downloadImageWithURL:imageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (image && !error && finished) {
            // 如果不是硬盘缓存，则存储到硬盘
            [[SDImageCache sharedImageCache] storeImage:image forKey:url toDisk:TRUE completion:nil];
            if (success) {
                success(image);
            }
        } else {
            if (fail) {
                fail(error);
            }
        }
    }];
    
}

+ (UIImage *)getCenterImage:(UIImage *)image
               scaledToSize:
(CGSize)newSize {
    CGFloat scale = newSize.height / newSize.width;
    
    CGFloat newWidth = image.size.width;
    CGFloat newHeight = newWidth * scale;
    if (newHeight > image.size.height) {
        newHeight = image.size.height;
        newWidth = newHeight / scale;
    }
    
    CGFloat startX = (image.size.width - newWidth) / 2;
    CGFloat startY = (image.size.height - newHeight) / 2;
    
    CGRect rect = CGRectMake(startX, startY, newWidth, newHeight);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    image = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    return image;
}

+ (UIImage *)getCenterImageByData:(NSData *)data scaledToSize:(CGSize)newSize {
    UIImage *image = [UIImage imageWithData:data];
    
    return [self getCenterImage:image scaledToSize:newSize];
}

//等比例缩放图片
+ (UIImage *)imageWithImageSimple:(UIImage *)image
                     scaledToSize:
(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+ (NSString *)getCreateImageName:(NSString *)userId {
    if (userId) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:TIME_FORMAT];
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        
        NSString *imageName = [[userId stringByAppendingString:@"_"]stringByAppendingString:dateTime];
        return [imageName stringByAppendingFormat:@".jpg"];
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:TIME_FORMAT];
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        NSString *imageName = dateTime;
        return [imageName stringByAppendingFormat:@".jpg"];
    }
}

+ (void)praiseAnimationsWithView:(UIView *)pariseview
{
    [UIView animateWithDuration:0.25 animations:^{
        CATransform3D transform = CATransform3DMakeScale(1.6, 1.6, 1.0);
        pariseview.layer.transform = transform;
        //        view.transform = CGAffineTransformMakeScale(2.0, 2.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            pariseview.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
        }];
    }];

}

+ (NSString *)getYMD:(long long)time
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // YYYY年MM月dd日
    [format setDateFormat:@"MM-dd"];
    
    //获取传过来的时间的时分
    NSDateFormatter *fo = [[NSDateFormatter alloc] init];
    [fo setDateFormat:@"HH:mm"];
    NSString *hoursandSec = [fo stringFromDate:date];
    
    //获取传过来的时间的date
    NSString *createDate = [format stringFromDate:date];
    
    //获取今天
    NSDate *nowDate = [NSDate date];
    NSString *today = [format stringFromDate:nowDate];
    
    //获取昨天
    NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    NSString *yesterday = [format stringFromDate:yesterdayDate];
    
    if ([createDate isEqualToString:today]) {
        return [NSString stringWithFormat:@"今天 %@",hoursandSec];
    }else if ([createDate isEqualToString:yesterday])
    {
        return [NSString stringWithFormat:@"昨天 %@",hoursandSec];
    }else
    {
        //return hoursandSec;
        return [NSString stringWithFormat:@"%@ %@",createDate,hoursandSec];
    }
}

+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 1.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 1;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 1;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"could not scale image");
    }
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return randomString;
}

+(BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                    
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (void)layerWithView:(UIView *)view corner:(CGFloat)corner{
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = path.CGPath;
    view.layer.mask = maskLayer;
}

+ (void)loadImage:(UIImageView *)imageView url:(NSString *)url placeholder:(UIImage *)placeholder{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;

    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)[PreHelper colorWithHexString:fromHexColorStr alpha:1].CGColor,(__bridge id)[PreHelper colorWithHexString:toHexColorStr alpha:1].CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
}

@end
