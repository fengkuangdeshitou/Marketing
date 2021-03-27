//
//  GroupModel.h
//  Marketing
//
//  Created by 王帅 on 2021/3/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupModel : NSObject

@property(nonatomic,copy)NSString * label;
@property(nonatomic,copy)NSString * img_urls;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * add_time;
@property(nonatomic,copy)NSString * wxg_desc;

@end

NS_ASSUME_NONNULL_END
