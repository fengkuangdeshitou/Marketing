//
//  CircleModel.h
//  Marketing
//
//  Created by 王帅 on 2021/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleModel : NSObject

@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * time;
@property(nonatomic,copy)NSString * avatar;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,strong)NSArray * images;

@end

NS_ASSUME_NONNULL_END
