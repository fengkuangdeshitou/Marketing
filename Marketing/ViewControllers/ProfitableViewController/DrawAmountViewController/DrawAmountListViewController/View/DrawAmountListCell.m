//
//  DrawAmountListCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/9.
//

#import "DrawAmountListCell.h"

@interface DrawAmountListCell ()

@property(nonatomic,weak)IBOutlet UILabel * timeLabel;
@property(nonatomic,weak)IBOutlet UILabel * statusLabel;
@property(nonatomic,weak)IBOutlet UILabel * moneyLabel;

@end

@implementation DrawAmountListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(BankModel *)model{
    _model = model;
    self.timeLabel.text = model.draw_time;
    self.statusLabel.text = model.draw_state;
    self.moneyLabel.text = [NSString stringWithFormat:@"提现金额:%@",model.draw_money];
    self.statusLabel.textColor = [model.draw_state isEqualToString:@"已发放"] ? [PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR] : [PreHelper colorWithHexString:COLOR_MAIN_COLOR];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
