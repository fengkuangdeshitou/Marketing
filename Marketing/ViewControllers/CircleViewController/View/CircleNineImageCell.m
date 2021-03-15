//
//  CircleNineImageCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/1.
//

#import "CircleNineImageCell.h"
#import "UIImageView+WebCache.h"
#import "HXPhotoPicker.h"

@interface CircleNineImageCell ()
@property(nonatomic,strong)HXPhotoManager *photoManager;
@property(nonatomic,weak)IBOutlet UIView * imagesView;

@end

@implementation CircleNineImageCell

- (HXPhotoManager *)photoManager{
    if (!_photoManager) {
        _photoManager = [HXPhotoManager managerWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    }
    HXWeakSelf
    // 跳转预览界面时动画起始的view
    _photoManager.configuration.customPreviewFromView = ^UIView *(NSInteger currentIndex) {
        return weakSelf;
    };
    // 跳转预览界面时展现动画的image
    _photoManager.configuration.customPreviewFromImage = ^UIImage *(NSInteger currentIndex) {
        return ((UIImageView *)[weakSelf.imagesView viewWithTag:currentIndex+10]).image;
    };
    // 退出预览界面时终点view
    _photoManager.configuration.customPreviewToView = ^UIView *(NSInteger currentIndex) {
        return weakSelf;
    };
    return _photoManager;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    for (UIImageView * imageView in self.imagesView.subviews) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDetail:)];
        [imageView addGestureRecognizer:tap];
    }
    
}

- (void)setModel:(CircleModel *)model{
    [super setModel:model];
    for (UIImageView * imageView in self.imagesView.subviews) {
        imageView.image = [UIImage new];
    }
    
    if (model.images.count == 4) {
        for (int i=0; i<2; i++) {
            [ImageLoader loadImage:[self.imagesView viewWithTag:i+10] url:model.images[i] placeholder:nil];
            [ImageLoader loadImage:[self.imagesView viewWithTag:i+13] url:model.images[i] placeholder:nil];
        }
    }else{
        for (int i=0; i<model.images.count; i++) {
            [ImageLoader loadImage:[self.imagesView viewWithTag:i+10] url:model.images[i] placeholder:nil];
        }
    }
}

- (void)imageDetail:(UITapGestureRecognizer *)sender{
    NSMutableArray * imageModelArray = [[NSMutableArray alloc] init];
    for (int i=0; i<self.model.images.count; i++) {
        HXCustomAssetModel *assetModel = [HXCustomAssetModel assetWithNetworkImageURL:[NSURL URLWithString:self.model.images[i]] selected:YES];
        [imageModelArray addObject:assetModel];
    }
    [self.photoManager addCustomAssetModel:imageModelArray];
    [[PreHelper getCurrentVC] hx_presentPreviewPhotoControllerWithManager:self.photoManager previewStyle:HXPhotoViewPreViewShowStyleDark showBottomPageControl:NO currentIndex:sender.view.tag-10];
    
}

@end
