//
//  UserInfoHeaderCell.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "UserInfoHeaderCell.h"
#import "PhotoManager.h"

@interface UserInfoHeaderCell ()

@property(nonatomic,weak)IBOutlet UIImageView * headerImageView;

@end

@implementation UserInfoHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAvatar)];
    [self.headerImageView addGestureRecognizer:tap];
    
    PhotoManager.shareInstance.manager.type = HXPhotoManagerSelectedTypePhoto;
    PhotoManager.shareInstance.manager.configuration.maxNum = 1;
    PhotoManager.shareInstance.manager.configuration.photoMaxNum = 1;
    PhotoManager.shareInstance.manager.configuration.videoMaxNum = 0;
}

- (void)setModel:(UserModel *)model{
    _model = model;
    [ImageLoader loadImage:self.headerImageView url:model.headimgurl placeholder:nil];
}

- (void)changeAvatar{
    [[PreHelper getCurrentVC] hx_presentSelectPhotoControllerWithManager:PhotoManager.shareInstance.manager didDone:^(NSArray<HXPhotoModel *> * _Nullable allList, NSArray<HXPhotoModel *> * _Nullable photoList, NSArray<HXPhotoModel *> * _Nullable videoList, BOOL isOriginal, UIViewController * _Nullable viewController, HXPhotoManager * _Nullable manager) {
        [photoList hx_requestImageWithOriginal:NO completion:^(NSArray<UIImage *> * _Nullable imageArray, NSArray<HXPhotoModel *> * _Nullable errorArray) {
            [NetworkWorker networkPost:[NetworkUrlGetter getUploadImgUrl] formPostData:UIImageJPEGRepresentation(imageArray.firstObject, 0.3) andFileName:[ImageLoader getCreateImageName:[UserManager getUser].mb_no] success:^(NSDictionary *result) {
                NSLog(@"relu=%@",result);
                [ImageLoader loadImage:self.headerImageView url:result[@"url"] placeholder:nil];
                [self uploadImageWithUrl:result[@"url"]];
            } failure:^(NSString *errorMessage) {
                [self makeToast:errorMessage];
            }];
        }];
        
    } cancel:^(UIViewController * _Nullable viewController, HXPhotoManager * _Nullable manager) {
        
    }];
}

- (void)uploadImageWithUrl:(NSString *)url{
    [NetworkWorker networkPost:[NetworkUrlGetter getUpdateMemberInfoUrl] params:@{@"headimgurl":url} success:^(NSDictionary *result) {
        self.model.headimgurl = url;
        [UserManager saveUser:self.model];
        if (self.headerImageReloadCompletion) {
            self.headerImageReloadCompletion();
        }
    } failure:^(NSString *errorMessage) {
        [self makeToast:errorMessage];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
