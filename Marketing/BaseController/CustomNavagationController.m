//
//  CustomNavagationController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "CustomNavagationController.h"

@interface CustomNavagationController ()

@end

@implementation CustomNavagationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.translucent = false;
    self.navigationBar.tintColor = [PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR];

    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100, 0) forBarMetrics:UIBarMetricsDefault];

    self.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName:[PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR],
        NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium]
    };
    
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
