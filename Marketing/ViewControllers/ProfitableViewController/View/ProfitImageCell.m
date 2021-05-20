//
//  ImageOrVideoCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/2.
//

#import "ProfitImageCell.h"
#import "YBImageBrowser.h"

@interface ProfitImageCell ()

@property(nonatomic,weak)IBOutlet UIImageView * coverImageView;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint * coverImageViewWidthConstraint;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint * coverImageViewHeightConstraint;

@end

@implementation ProfitImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewImageView)];
    self.coverImageView.userInteractionEnabled = YES;
    [self.coverImageView addGestureRecognizer:tap];
}

- (void)setModel:(ShareModel *)model{
    _model = model;
    [ImageLoader loadImage:self.coverImageView url:model.imgurl placeholder:nil];
    self.coverImageViewWidthConstraint.constant = [PreHelper getWidthWithUrl:model.imgurl];
    self.coverImageViewHeightConstraint.constant = [PreHelper getHeightWithUrl:model.imgurl];
}

- (void)previewImageView{
    YBIBImageData * data = [YBIBImageData new];
    data.imageURL = [NSURL URLWithString:self.model.imgurl];
    data.projectiveView = self.coverImageView;
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = @[data];
    browser.currentPage = 0;
    [browser show];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
