//
//  PhotoManager.h
//  Marketing
//
//  Created by 王帅 on 2021/3/15.
//

#import <Foundation/Foundation.h>
#import "HXPhotoPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoManager : NSObject

@property(nonatomic,strong)HXPhotoManager * manager;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
