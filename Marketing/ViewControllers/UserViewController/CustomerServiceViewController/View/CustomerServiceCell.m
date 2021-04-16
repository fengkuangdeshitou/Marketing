//
//  CustomerServiceCell.m
//  Marketing
//
//  Created by maiyou on 2021/3/12.
//

#import "CustomerServiceCell.h"

@interface CustomerServiceCell ()

@property(nonatomic,weak)IBOutlet UILabel * titleLabel;
@property(nonatomic,weak)IBOutlet UILabel * contentLabel;

@end

@implementation CustomerServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HelpModel *)model{
    _model = model;
    self.titleLabel.text = model.dict_name;
    self.contentLabel.text = model.dict_value;
}

- (IBAction)moreBtnClick:(id)sender
{
    if (self.moreBtnBlock) {
        self.moreBtnBlock();
    }
}

@end
