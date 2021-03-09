//
//  CircleBaseCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/1.
//

#import "CircleBaseCell.h"

@implementation CircleBaseCell

+ (CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath dataModel:(id)model{
    if (indexPath.row == 0) {
        return 76;
    }else if(indexPath.row == 1){
        return UITableViewAutomaticDimension;
    }else if(indexPath.row == 2){
        NSString * content = model[@"content"];
        CGFloat heigit = [content boundingRectWithSize:CGSizeMake((SCREEN_WIDTH-64.5-15), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
        return heigit > 60 ? 40 : 0.001;
    }else if(indexPath.row == 3){
        return 250;
    }else{
        return 61;
    }
}

@end
