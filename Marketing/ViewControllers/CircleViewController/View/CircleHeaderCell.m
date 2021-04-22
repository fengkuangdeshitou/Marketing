//
//  CircleHeaderCell.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "CircleHeaderCell.h"
#import "AddFriendAlertView.h"
#import <ShareSDK/ShareSDK.h>

@interface CircleHeaderCell ()

@property(nonatomic,weak)IBOutlet UILabel * titleLabel;
@property(nonatomic,weak)IBOutlet UILabel * timeLabel;
@property(nonatomic,weak)IBOutlet UIImageView * avararImageView;

@end

@implementation CircleHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerAction:)];
    [self.avararImageView addGestureRecognizer:tap];
}

- (void)setModel:(CircleModel *)model{
    [super setModel:model];
    self.titleLabel.text = model.nikename;
    self.timeLabel.text = model.add_time;
    [ImageLoader loadImage:self.avararImageView url:model.head_url placeholder:[UIImage imageNamed:@"placehold"]];
}

- (IBAction)headerAction:(UITapGestureRecognizer *)sender{
    [AddFriendAlertView addFriendWithModel:self.model];
}

- (IBAction)shareAction:(UIButton *)sender{
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.model.text;
    NSMutableDictionary * shareDict = [[NSMutableDictionary alloc] init];
    [shareDict SSDKSetupWeChatParamsByText:self.model.text title:self.model.text url:[NSURL URLWithString:self.model.video_url] thumbImage:nil image:self.model.images musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil sourceFileExtension:nil sourceFileData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
    [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareDict onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
