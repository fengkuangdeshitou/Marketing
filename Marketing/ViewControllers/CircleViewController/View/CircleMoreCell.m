//
//  CircleMoreCell.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "CircleMoreCell.h"

@interface CircleMoreCell ()

@property(nonatomic,weak)IBOutlet UIButton * deleteButton;

@end

@implementation CircleMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CircleModel *)model{
    [super setModel:model];
    if (model.isShowDeleteButton) {
        self.deleteButton.hidden = NO;
    }else{
        self.deleteButton.hidden = YES;
    }
}

/// 删除品圈
/// @param sender 按钮
- (IBAction)deleteCircleData:(UIButton *)sender{
    [NetworkWorker networkGet:[NetworkUrlGetter getDeleteCircelWithCircleId:self.model.circle_id] success:^(NSDictionary *result) {
        if (self.DeleteCircleBlock) {
            self.DeleteCircleBlock(self.model.circle_id);
        }
    } failure:^(NSString *errorMessage) {

    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
