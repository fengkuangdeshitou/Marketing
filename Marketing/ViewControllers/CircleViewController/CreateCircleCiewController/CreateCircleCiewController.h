//
//  CreateCircleCiewController.h
//  Marketing
//
//  Created by 王帅 on 2021/3/13.
//

#import <UIKit/UIKit.h>
@class HXPhotoManager;

NS_ASSUME_NONNULL_BEGIN

@protocol CreateCircleCiewControllerDelegate <NSObject>

- (void)onCreateCircleSuccess;

@end

@interface CreateCircleCiewController : UIViewController

@property (strong, nonatomic) HXPhotoManager *photoManager;

@property (weak, nonatomic) id<CreateCircleCiewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
