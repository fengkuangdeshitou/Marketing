//
//  NoDataEmptyView.m
//  Marketing
//
//  Created by 王帅 on 2021/4/20.
//

#import "NoDataEmptyView.h"

@interface NoDataEmptyView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *label;

@end

@implementation NoDataEmptyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
//    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    self.hidden = YES;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.imageView.image = [UIImage imageNamed:@"noData"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.center = self.center;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.label.text = @"暂无数据!";
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.textColor = [PreHelper colorWithHexString:COLOR_TABBAR_NORMAL_COLOR];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.center = CGPointMake(self.imageView.center.x, CGRectGetMaxY(self.imageView.frame)+25);
    
    [self addSubview:self.imageView];
    [self addSubview:self.label];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
