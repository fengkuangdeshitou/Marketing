//
//  ImageLoader.m
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import "ImageLoader.h"
#import <SDWebImage/SDWebImage.h>
#import "NetworkUrlGetter.h"
#import "AFNetworkReachabilityManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

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

+ (NSString *)getCreateVidelName{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:TIME_FORMAT];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *imageName = dateTime;
    return [imageName stringByAppendingFormat:@".mp4"];
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

+ (void)loadImage:(UIImageView *)imageView url:(NSString *)url placeholder:(UIImage *)placeholder{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

+ (UIImage*)getVideoFirstViewImage:(NSURL *)url {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}

@end
