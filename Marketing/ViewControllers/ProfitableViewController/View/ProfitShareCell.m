//
//  ProfitShareCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/2.
//

#import "ProfitShareCell.h"

@implementation ProfitShareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self addBordorColorWithView:self.shareToGroupButton];
    [self addBordorColorWithView:self.shareToFriendsButton];
    
}

- (void)addBordorColorWithView:(UIView *)view{
    view.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    view.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
