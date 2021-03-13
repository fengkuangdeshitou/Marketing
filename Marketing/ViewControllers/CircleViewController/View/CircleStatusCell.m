//
//  CircleStatusCell.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "CircleStatusCell.h"

@implementation CircleStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)cellHeightChangeAction:(UIButton *)sender{
    self.model.isOpen = !self.model.isOpen;
    [sender setTitle:self.model.isOpen ? @"收起" : @"全文" forState:UIControlStateNormal];
    if (self.cellHeightChangeBlock) {
        self.cellHeightChangeBlock();
    }
}

@end
