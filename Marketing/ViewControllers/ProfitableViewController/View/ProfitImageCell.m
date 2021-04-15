//
//  ImageOrVideoCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/2.
//

#import "ProfitImageCell.h"

@interface ProfitImageCell ()

@property(nonatomic,weak)IBOutlet UIImageView * coverImageView;

@end

@implementation ProfitImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ShareModel *)model{
    _model = model;
    [ImageLoader loadImage:self.coverImageView url:model.imgurl placeholder:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
