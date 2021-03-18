//
//  DeviceTool.h
//  Marketing
//
//  Created by 王帅 on 2021/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceTool : NSObject

+ (instancetype)shareInstance;

/// 设备唯一标识
@property(nonatomic,readonly)NSString * deviceId;

/// 手机品牌
@property(nonatomic,readonly)NSString * brand;

/// 手机型号
@property(nonatomic,readonly)NSString * model;

/// APP版本号
@property(nonatomic,readonly)NSString * appVersion;

/// 渠道号
@property(nonatomic,readonly)NSString * getChannel;

@end

NS_ASSUME_NONNULL_END
