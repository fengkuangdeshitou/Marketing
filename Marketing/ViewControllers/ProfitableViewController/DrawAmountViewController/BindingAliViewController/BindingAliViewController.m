//
//  BindingAliViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/10.
//

#import "BindingAliViewController.h"

@interface BindingAliViewController ()

@property(nonatomic,weak)IBOutlet UITextField * nameTextField;
@property(nonatomic,weak)IBOutlet UITextField * accountTextField;

@end

@implementation BindingAliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)doneAction:(UIButton *)sender{
    
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
