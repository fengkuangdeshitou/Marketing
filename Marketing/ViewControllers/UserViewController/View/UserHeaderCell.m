//
//  UserHeaderCell.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "UserHeaderCell.h"

@interface UserHeaderCell ()

@property(nonatomic,weak)IBOutlet UIImageView * headerImageView;
@property(nonatomic,weak)IBOutlet UILabel * titleLabel;
@property(nonatomic,weak)IBOutlet UILabel * descLabel;

@end

@implementation UserHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}

- (void)setModel:(UserModel *)model{
    _model = model;
    NSLog(@"user=%@",[model mj_keyValues]);
    if (![PreHelper isLogin]) {
        self.titleLabel.text = @"未登录";
    }else{
        self.titleLabel.text = model.nickname;
    }
    [ImageLoader loadImage:self.headerImageView url:self.model.headimgurl placeholder:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
