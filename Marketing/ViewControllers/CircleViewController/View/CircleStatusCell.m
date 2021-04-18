//
//  CircleStatusCell.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "CircleStatusCell.h"

@interface CircleStatusCell ()

@property(nonatomic,weak)IBOutlet UIButton * statusButton;

@end

@implementation CircleStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CircleModel *)model{
    [super setModel:model];
    [self.statusButton setTitle:model.isOpen ? @"收起" : @"全文" forState:UIControlStateNormal];
}

- (IBAction)cellHeightChangeAction:(UIButton *)sender{
    self.model.isOpen = !self.model.isOpen;
    if (self.cellHeightChangeBlock) {
        self.cellHeightChangeBlock();
    }
}

@end
