//
//  PhotoManager.m
//  Marketing
//
//  Created by 王帅 on 2021/3/15.
//

#import "PhotoManager.h"

@implementation PhotoManager

static PhotoManager *_photoManager = nil;

+ (instancetype)shareInstance{
    if (!_photoManager){
        _photoManager = [[PhotoManager alloc] init];
    }
    return _photoManager;
}

- (HXPhotoManager *)manager{
    if (!_manager) {
        _manager = [HXPhotoManager managerWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.navBarBackgroudColor = UIColor.whiteColor;
        _manager.configuration.themeColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR];
        _manager.configuration.navigationTitleColor = [PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR];
        _manager.configuration.rowCount = 4;
        _manager.configuration.saveSystemAblum = NO;
        _manager.configuration.photoCanEdit = YES;
        _manager.configuration.videoCanEdit = false;
    }
    return _manager;
}

@end
