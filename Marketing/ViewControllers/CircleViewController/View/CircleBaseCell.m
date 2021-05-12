//
//  CircleBaseCell.m
//  Marketing
//
//  Created by 王帅 on 2021/3/1.
//

#import "CircleBaseCell.h"

@implementation CircleBaseCell

+ (CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath dataModel:(CircleModel *)model{
    if (indexPath.row == 0) {
        return 76;
    }else if(indexPath.row == 1){
        CGFloat contentHeight = [PreHelper getCircleContentHeight:model.text];
        if (model.isOpen) {
            return UITableViewAutomaticDimension;
        }else{
            return contentHeight > 61 ? 61 :  UITableViewAutomaticDimension;
        }
    }else if(indexPath.row == 2){
        CGFloat heigit = [PreHelper getCircleContentHeight:model.text];
        return heigit > 61 ? 30 : 0.001;
    }else if(indexPath.row == 3){
        if (model.video_url.length > 0) {
            return [PreHelper getVideoHeightWithUrl:model.video_url];
        }else{
            if (model.images.count == 0) {
                return 0.001;
            }else if (model.images.count == 1){
                return [PreHelper getHeightWithUrl:model.images.firstObject];
            }else if (model.images.count > 1 && model.images.count < 4){
                return 95;
            }else if (model.images.count > 3 && model.images.count < 7){
                return 180;
            }else{
                return 250;
            }
        }
    }else{
        return 61;
    }
}

@end
