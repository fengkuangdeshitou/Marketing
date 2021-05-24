//
//  UserHeaderCell.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "UserHeaderCell.h"
#import "GlobalNotification.h"
#import "MembersViewController.h"

@interface UserHeaderCell ()

@property(nonatomic,weak)IBOutlet UIImageView * headerImageView;
@property(nonatomic,weak)IBOutlet UIImageView * memberImageView;
@property(nonatomic,weak)IBOutlet UILabel * titleLabel;
@property(nonatomic,weak)IBOutlet UILabel * descLabel;
@property(nonatomic,weak)IBOutlet UILabel * VIPInfoLabel;

@end

@implementation UserHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMyVIPInfo) name:NOTIFICATION_VIP_CHANGE object:nil];
    [self getMyVIPInfo];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMember)];
    [self.memberImageView addGestureRecognizer:tap];
    
}

/// 会员中心
- (void)pushToMember{
    if (![PreHelper isLogin]) {
        [PreHelper pushToLoginController];
        return;
    }
    MembersViewController * memeber = [[MembersViewController alloc] init];
    memeber.title = @"会员中心";
    memeber.hidesBottomBarWhenPushed = true;
    [[PreHelper getCurrentVC].navigationController pushViewController:memeber animated:YES];
}

/// 获取 VIP 信息
- (void)getMyVIPInfo{
    [NetworkWorker networkGet:[NetworkUrlGetter getMyVipUrl] success:^(NSDictionary *result) {
        if ([result[@"vip"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary * level = result[@"vip"][@"level"];
            self.VIPInfoLabel.text = [NSString stringWithFormat:@"%@ %@",level[@"level_name"],result[@"vip"][@"expire_time"]];
            [self.memberButton setTitle:@"立即续费" forState:UIControlStateNormal];
        }
    } failure:^(NSString *errorMessage) {
        
    }];
}

- (void)setModel:(UserModel *)model{
    _model = model;
    if (![PreHelper isLogin]) {
        self.titleLabel.text = @"未登录";
    }else{
        self.titleLabel.text = model.nickname;
        self.descLabel.text = [NSString stringWithFormat:@"ID:%@",self.model.mb_no];
    }
    [ImageLoader loadImage:self.headerImageView url:self.model.headimgurl placeholder:[UIImage imageNamed:@"placehold"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
