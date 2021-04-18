//
//  ProfitShareCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/2.
//

#import "ProfitShareCell.h"
#import <ShareSDK/ShareSDK.h>

@interface ProfitShareCell ()

@property(nonatomic,strong)NSMutableDictionary * params;
@property(nonatomic,weak)IBOutlet UIButton * shareToFriendsButton;
@property(nonatomic,weak)IBOutlet UIButton * shareToGroupButton;
@property(nonatomic,weak)IBOutlet UIButton * shareToFriendCircleButton;

@end

@implementation ProfitShareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self addBordorColorWithView:self.shareToGroupButton];
    [self addBordorColorWithView:self.shareToFriendsButton];
    
    
}

- (void)setModel:(ShareModel *)model{
    _model = model;
}

- (void)addBordorColorWithView:(UIView *)view{
    view.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    view.layer.borderWidth = 0.5;
}

- (IBAction)shareWechatSession:(UIButton *)sender{
    [self sharePlatformWithPlatformType:SSDKPlatformSubTypeWechatSession];
}

- (IBAction)shareWechatGroup:(UIButton *)sender{
    [self sharePlatformWithPlatformType:SSDKPlatformSubTypeWechatSession];
}

- (IBAction)shareWechatTimeline:(UIButton *)sender{
    [self sharePlatformWithPlatformType:SSDKPlatformSubTypeWechatTimeline];
}

- (void)sharePlatformWithPlatformType:(SSDKPlatformType)platformType{
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.model.text;
    self.params = [[NSMutableDictionary alloc] init];
    [self.params SSDKSetupWeChatParamsByText:self.model.text title:self.model.text url:nil thumbImage:nil image:[NSURL URLWithString:self.model.imgurl] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil sourceFileExtension:nil sourceFileData:nil type:SSDKContentTypeAuto forPlatformSubType:platformType];
    [ShareSDK share:platformType parameters:self.params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
