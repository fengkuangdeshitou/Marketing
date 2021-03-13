//
//  CustomerServiceCell.m
//  Marketing
//
//  Created by maiyou on 2021/3/12.
//

#import "CustomerServiceCell.h"

@interface CustomerServiceCell ()

@property(nonatomic,weak)IBOutlet UILabel * titleLabel;

@end

@implementation CustomerServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    self.titleLabel.text = dataDic[@"title"];
}

- (IBAction)moreBtnClick:(id)sender
{
    if (self.moreBtnBlock) {
        self.moreBtnBlock();
    }
}

@end
