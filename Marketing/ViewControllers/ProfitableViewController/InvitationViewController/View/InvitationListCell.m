//
//  InvitationListCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/9.
//

#import "InvitationListCell.h"

@interface InvitationListCell ()

@property(nonatomic,weak)IBOutlet UIImageView * headerImageView;
@property(nonatomic,weak)IBOutlet UILabel * nickname;
@property(nonatomic,weak)IBOutlet UILabel * shareTime;
@property(nonatomic,weak)IBOutlet UILabel * priceLabel;

@end

@implementation InvitationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(InvitationModel *)model{
    _model = model;
    [ImageLoader loadImage:self.headerImageView url:model.headimgurl placeholder:nil];
    self.nickname.text = model.nickname;
    self.shareTime.text = model.share_reg_time;
    if (model.buy_count.intValue == 0) {
        self.priceLabel.text = @"未支付";
        self.priceLabel.textColor = [PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR];
    }else{
        self.priceLabel.text = model.buy_price_total;
        self.priceLabel.textColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
