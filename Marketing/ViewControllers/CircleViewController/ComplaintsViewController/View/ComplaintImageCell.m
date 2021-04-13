//
//  ComplaintImageCell.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "ComplaintImageCell.h"

@interface ComplaintImageCell ()<HXPhotoViewDelegate>

@property(nonatomic,strong) HXPhotoView * photoView;

@end

@implementation ComplaintImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [PhotoManager shareInstance].manager.type = HXPhotoManagerSelectedTypePhoto;
    [PhotoManager shareInstance].manager.configuration.photoMaxNum = 5;
    
    self.photoView = [HXPhotoView photoManager:PhotoManager.shareInstance.manager];
    self.photoView.frame = CGRectMake(15, 55, SCREEN_WIDTH-30, 80);
    self.photoView.lineCount = 4;
    self.photoView.spacing = 5;
    self.photoView.outerCamera = NO;
    self.photoView.addImageName = @"circle_complaint_upload";
    self.photoView.delegate = self;
    [self.contentView addSubview:self.photoView];
}

- (IBAction)addPhotoAction:(UIButton *)sender{
    [self.photoView goPhotoViewController];
}

- (void)photoListViewControllerDidDone:(HXPhotoView *)photoView allList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal{
    if (self.delegate && [self.delegate respondsToSelector:@selector(complaintImageCellDidSelectedImage:)]) {
        [self.delegate complaintImageCellDidSelectedImage:photos];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
