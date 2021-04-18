//
//  MyTabbarViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "MyTabbarViewController.h"
#import "CustomNavagationController.h"
#import "UIImage+YYCompress.h"
#import "HomeViewController.h"
#import "CircleViewController.h"
#import "ProfitableViewController.h"
#import "UserViewController.h"

@interface MyTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation MyTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    // 设置 TabBarItemTestAttributes 的颜色。
    [self setUpTabBarItemTextAttributes];
    
    // 设置子控制器
    [self setUpChildViewController];
    
    self.delegate = self;
}

/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes{
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [PreHelper colorWithHexString:COLOR_TABBAR_NORMAL_COLOR];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [PreHelper colorWithHexString:COLOR_TABBAR_SELECTED_COLOR];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    UIColor * lineColor = [PreHelper colorWithHexString:COLOR_TABBAR_TOPLINE_COLOR];
    
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttrs;
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttrs;
        appearance.shadowColor = lineColor;
        appearance.backgroundColor = [UIColor whiteColor];
        [self.tabBar setStandardAppearance:appearance];
    }else{
        //去除 TabBar 自带的顶部阴影
        [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:lineColor]];
        [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    }
    
}

/**
 *  添加子控制器，我这里值添加了4个，没有占位自控制器
 */
- (void)setUpChildViewController{
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    
    [self addOneChildViewController:[[CustomNavagationController alloc]initWithRootViewController:[[HomeViewController alloc]init]]
                          WithTitle:@"工具"
                          imageName:@"tabbar_home_normal"
                  selectedImageName:@"tabbar_home_selected"];
    
    [self addOneChildViewController:[[CustomNavagationController alloc]initWithRootViewController:[[CircleViewController alloc] init]]
                          WithTitle:@"品圈"
                          imageName:@"tabbar_circle_normal"
                  selectedImageName:@"tabbar_circle_selected"];

    [self addOneChildViewController:[[CustomNavagationController alloc]initWithRootViewController:[[ProfitableViewController alloc]init]]
            WithTitle:@"赚钱"
            imageName:@"tabbar_money_normal"
    selectedImageName:@"tabbar_money_selected"];


    [self addOneChildViewController:[[CustomNavagationController alloc]initWithRootViewController:[[UserViewController alloc]init]]
                          WithTitle:@"我的"
                          imageName:@"tabbar_user_normal"
                  selectedImageName:@"tabbar_user_selected"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */

- (void)addOneChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    viewController.view.backgroundColor     = [UIColor whiteColor];
    viewController.tabBarItem.title         = title;
    viewController.tabBarItem.image         = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = image;
    //    viewController.tabBarItem.selectedImage = [UIImage imageNamed:imageName];
    [self addChildViewController:viewController];
    
}

- (void)addOneNewChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    viewController.view.backgroundColor     = [UIColor whiteColor];
    viewController.tabBarItem.title         = title;
    UIImage *image = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = image;
    viewController.tabBarItem.image         = image;
    [viewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 10)];
    [self addChildViewController:viewController];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    CustomNavagationController * nav = (CustomNavagationController *)viewController;
    if ([nav.topViewController isKindOfClass:[CircleViewController class]] || [nav.topViewController isKindOfClass:[ProfitableViewController class]]) {
        if (![PreHelper isLogin]) {
            [PreHelper pushToLoginController];
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

//这个方法可以抽取到 UIImage 的分类中
- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
