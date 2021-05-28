//
//  ProfitHeaderCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/2.
//

#import "ProfitHeaderCell.h"

@interface ProfitHeaderCell ()

@property(nonatomic,weak)IBOutlet UILabel * titleLabel;
@property(nonatomic,weak)IBOutlet UILabel * contentLabel;

@end

@implementation ProfitHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ShareModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"文案%@:",[self formatNumberWithValue:model.index+1]];
    if ([model.text containsString:@"http"]) {
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:model.text];
        NSArray * arrar = [model.text componentsSeparatedByString:@"http"];
        NSString * url = arrar.lastObject;
        [string addAttribute:NSForegroundColorAttributeName value:[PreHelper colorWithHexString:@"#5798FF"] range:NSMakeRange(model.text.length-url.length-4, url.length+4)];
        self.contentLabel.attributedText = string;
    }else{
        self.contentLabel.text = model.text;
    }
}

- (NSString *)formatNumberWithValue:(NSInteger)value{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    /// 拼写输出中文
    formatter.numberStyle = kCFNumberFormatterSpellOutStyle;
    /// 如果不设置locle 跟随系统语言
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *spellOutStr = [formatter stringFromNumber:[NSNumber numberWithInteger:value]];
    return spellOutStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
