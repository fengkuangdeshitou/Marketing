//
//  SearchItemCollectionCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/11.
//

#import "SearchItemCollectionCell.h"

@implementation SearchItemCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentLabel.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    self.contentLabel.layer.borderWidth = 0.5;
    self.contentLabel.layer.cornerRadius = 5;
    
}

@end
