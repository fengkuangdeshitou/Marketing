//
//  CircleNineImageCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/1.
//

#import "CircleNineImageCell.h"
#import "UIImageView+WebCache.h"
#import "YBImageBrowser.h"

@interface CircleNineImageCell ()

@property(nonatomic,weak)IBOutlet NSLayoutConstraint * imageWidthConstraint;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint * imageHeightConstraint;
@property(nonatomic,weak)IBOutlet UIView * imagesView;

@end

@implementation CircleNineImageCell

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
    self.imageHeightConstraint.constant = 80;
    self.imageWidthConstraint.constant = 80;
    for (UIImageView * imageView in self.imagesView.subviews) {
        imageView.image = [UIImage new];
    }
    
    if (model.images.count == 1){
        CGFloat imageHeight = [PreHelper getHeightWithUrl:model.images.firstObject];
        CGFloat imageWidth = [PreHelper getWidthWithUrl:model.images.firstObject];
        self.imageHeightConstraint.constant = imageHeight > 0 ? imageHeight : 180;
        self.imageWidthConstraint.constant = imageWidth > 0 ? imageWidth : 120;
        [ImageLoader loadImage:[self.imagesView viewWithTag:10] url:model.images.firstObject placeholder:[UIImage imageNamed:@"placehold1"]];
    }else if (model.images.count == 4) {
        for (int i=0; i<2; i++) {
            [ImageLoader loadImage:[self.imagesView viewWithTag:i+10] url:model.images[i] placeholder:[UIImage imageNamed:@"placehold"]];
            [ImageLoader loadImage:[self.imagesView viewWithTag:i+13] url:model.images[i] placeholder:[UIImage imageNamed:@"placehold"]];
        }
    }else{
        for (int i=0; i<model.images.count; i++) {
            [ImageLoader loadImage:[self.imagesView viewWithTag:i+10] url:model.images[i] placeholder:[UIImage imageNamed:@"placehold"]];
        }
    }
}

- (void)imageDetail:(UITapGestureRecognizer *)sender{
    NSMutableArray * imageModelArray = [[NSMutableArray alloc] init];
    for (int i=0; i<self.model.images.count; i++) {
        YBIBImageData * data = [YBIBImageData new];
        data.imageURL = [NSURL URLWithString:self.model.images[i]];
        data.projectiveView = [self.imagesView viewWithTag:i+10];
        [imageModelArray addObject:data];
    }
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = imageModelArray;
    browser.currentPage = sender.view.tag-10;
    [browser show];
}

@end
