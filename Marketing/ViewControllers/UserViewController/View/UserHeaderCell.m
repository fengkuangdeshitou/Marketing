//
//  UserHeaderCell.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "UserHeaderCell.h"

@implementation UserHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if (![PreHelper isLogin]) {
        self.titleLabel.text = @"未登录";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
