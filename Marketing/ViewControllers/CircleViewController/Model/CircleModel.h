//
//  CircleModel.h
//  Marketing
//
//  Created by 王帅 on 2021/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleModel : NSObject

@property(nonatomic,copy)NSString * nikename;
@property(nonatomic,copy)NSString * add_time;
@property(nonatomic,copy)NSString * head_url;
@property(nonatomic,copy)NSString * text;
@property(nonatomic,copy)NSString * wechat_num;
@property(nonatomic,copy)NSString * contact;
@property(nonatomic,copy)NSString * wechat_er_code;
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,copy)NSString * img_urls;
@property(nonatomic,strong)NSArray * images;

@end

NS_ASSUME_NONNULL_END
