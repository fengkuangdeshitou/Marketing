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
        [ImageLoader loadImage:[self.imagesView viewWithTag:10] url:model.images[0] placeholder:[UIImage imageNamed:@"placehold"]];
        [ImageLoader loadImage:[self.imagesView viewWithTag:11] url:model.images[1] placeholder:[UIImage imageNamed:@"placehold"]];
        [ImageLoader loadImage:[self.imagesView viewWithTag:13] url:model.images[2] placeholder:[UIImage imageNamed:@"placehold"]];
        [ImageLoader loadImage:[self.imagesView viewWithTag:14] url:model.images[3] placeholder:[UIImage imageNamed:@"placehold"]];
    }else{
        for (int i=0; i<model.images.count; i++) {
            [ImageLoader loadImage:[self.imagesView viewWithTag:i+10] url:model.images[i] placeholder:[UIImage imageNamed:@"placehold"]];
        }
    }
}

- (void)imageDetail:(UITapGestureRecognizer *)sender{
    NSMutableArray * imageModelArray = [[NSMutableArray alloc] init];
    if (self.model.images.count == 4) {
        YBIBImageData * data1 = [YBIBImageData new];
        data1.imageURL = [NSURL URLWithString:self.model.images[0]];
        data1.projectiveView = [self.imagesView viewWithTag:10];
        [imageModelArray addObject:data1];
        YBIBImageData * data2 = [YBIBImageData new];
        data2.imageURL = [NSURL URLWithString:self.model.images[1]];
        data2.projectiveView = [self.imagesView viewWithTag:11];
        [imageModelArray addObject:data2];
        YBIBImageData * data3 = [YBIBImageData new];
        data3.imageURL = [NSURL URLWithString:self.model.images[2]];
        data3.projectiveView = [self.imagesView viewWithTag:13];
        [imageModelArray addObject:data3];
        YBIBImageData * data4 = [YBIBImageData new];
        data4.imageURL = [NSURL URLWithString:self.model.images[3]];
        data4.projectiveView = [self.imagesView viewWithTag:14];
        [imageModelArray addObject:data4];
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.dataSourceArray = imageModelArray;
        if (sender.view.tag == 10) {
            browser.currentPage = 0;
        }else if(sender.view.tag == 11){
            browser.currentPage = 1;
        }else if(sender.view.tag == 13){
            browser.currentPage = 2;
        }else if(sender.view.tag == 14){
            browser.currentPage = 3;
        }
        [browser show];
    }else{
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
}

@end
