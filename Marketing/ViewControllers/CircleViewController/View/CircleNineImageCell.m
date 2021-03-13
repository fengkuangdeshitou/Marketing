//
//  CircleNineImageCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/1.
//

#import "CircleNineImageCell.h"

@interface CircleNineImageCell ()

@property(nonatomic,weak)IBOutlet UIView * imagesView;

@end

@implementation CircleNineImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CircleModel *)model{
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

@end
