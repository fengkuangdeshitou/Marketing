//
//  CircleHeaderCell.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "CircleHeaderCell.h"

@interface CircleHeaderCell ()

@property(nonatomic,weak)IBOutlet UILabel * titleLabel;
@property(nonatomic,weak)IBOutlet UILabel * timeLabel;
@property(nonatomic,weak)IBOutlet UIImageView * avararImageView;

@end

@implementation CircleHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CircleModel *)model{
    [super setModel:model];
    self.titleLabel.text = model.title;
    self.timeLabel.text = [PreHelper compareCurrentTime:model.title.longLongValue];
    [ImageLoader loadImage:self.avararImageView url:model.avatar placeholder:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
