//
//  ImageOrVideoCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/2.
//

#import "ImageOrVideoCell.h"

@interface ImageOrVideoCell ()

@end

@implementation ImageOrVideoCell

- (UIImageView *)placeholdImageView{
    if (!_placeholdImageView) {
        _placeholdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    }
    return _placeholdImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
