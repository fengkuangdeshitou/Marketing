//
//  UserInfoHeaderCell.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "UserInfoHeaderCell.h"
#import "PhotoManager.h"

@implementation UserInfoHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAvatar)];
    [self.headerImageView addGestureRecognizer:tap];
    
}

- (void)changeAvatar{
    PhotoManager.shareInstance.manager.type = HXPhotoManagerSelectedTypePhoto;
    [[PreHelper getCurrentVC] hx_presentSelectPhotoControllerWithManager:PhotoManager.shareInstance.manager didDone:^(NSArray<HXPhotoModel *> * _Nullable allList, NSArray<HXPhotoModel *> * _Nullable photoList, NSArray<HXPhotoModel *> * _Nullable videoList, BOOL isOriginal, UIViewController * _Nullable viewController, HXPhotoManager * _Nullable manager) {
            
    } cancel:^(UIViewController * _Nullable viewController, HXPhotoManager * _Nullable manager) {
        
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
