//
//  CircleVideoCell.m
//  Marketing
//
//  Created by maiyou on 2021/4/13.
//

#import "CircleVideoCell.h"
#import "PlayerSuperImageView.h"

@interface CircleVideoCell ()

@property (weak, nonatomic) IBOutlet PlayerSuperImageView *coverImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewHeightConstraint;

@end

@implementation CircleVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.coverImageView addGestureRecognizer:tap];
}

- (void)setModel:(CircleModel *)model{
    [super setModel:model];
    self.coverImageView.image = [ImageLoader getVideoFirstViewImage:model.video_url];
    self.coverImageViewWidthConstraint.constant = [PreHelper getWidthWithUrl:model.video_url];
    self.coverImageViewHeightConstraint.constant = [PreHelper getHeightWithUrl:model.head_url];
}

- (void)handleTapGesture:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(coverItemWasTapped:)] ) {
        [self.delegate coverItemWasTapped:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
