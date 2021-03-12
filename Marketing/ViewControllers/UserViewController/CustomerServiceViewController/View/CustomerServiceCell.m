//
//  CustomerServiceCell.m
//  Marketing
//
//  Created by maiyou on 2021/3/12.
//

#import "CustomerServiceCell.h"

@implementation CustomerServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)moreBtnClick:(id)sender
{
    if (self.moreBtnBlock) {
        self.moreBtnBlock();
    }
}

@end
