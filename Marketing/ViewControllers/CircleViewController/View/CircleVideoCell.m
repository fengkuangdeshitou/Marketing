//
//  CircleVideoCell.m
//  Marketing
//
//  Created by maiyou on 2021/4/13.
//

#import "CircleVideoCell.h"

@interface CircleVideoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *mediaTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation CircleVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.clipsToBounds = YES;
    _coverImageView.backgroundColor = UIColor.clearColor;
//    _coverImageView.sd_imageTransition = [SDWebImageTransition fadeTransition];
    _coverImageView.userInteractionEnabled = YES;
    
//    SJCornerMaskSetRound(_avatarImageView, 2, UIColor.brownColor);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [_coverImageView addGestureRecognizer:tap];
}

- (void)setModel:(CircleModel *)model{
    [super setModel:model];
//    [ImageLoader loadImage:self.coverImageView url:model.cover placeholder:nil];
//    [ImageLoader loadImage:self.avatarImageView url:model.avatar placeholder:nil];
//        _mediaTitleLabel.attributedText = _dataSource.mediaTitle;
//        _usernameLabel.attributedText = _dataSource.username;
}

- (void)handleTapGesture:(id)sender {
    if ( [(id)_delegate respondsToSelector:@selector(coverItemWasTapped:)] ) {
        [_delegate coverItemWasTapped:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
