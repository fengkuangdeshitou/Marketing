//
//  GlobalState.h
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalState : NSObject

extern NSString * const USER_LOGIN;

extern NSString * const DATE_FORMAT;

extern NSString * const DATE_FORMAT_MIN;

extern NSString * const TIME_FORMAT;

extern NSString * const DATE_FORMAT_TAKE_MIN;

extern NSString * const REQUEST_FAIL;

extern NSString * const REVIEWING;

extern NSString * const APPROVED;

extern CGFloat const NavagationBarHeight;
/// 图片默认宽度
extern CGFloat const DEFAULT_IMAGE_WIDTH;
/// 图片默认高度
extern CGFloat const DEFAULT_IMAGE_HEIGHT;
/// 视频默认宽度
extern CGFloat const DEFAULT_VIDEO_WIDTH;
/// 视频默认高度
extern CGFloat const DEFAULT_VIDEO_HEIGHT;

@end
