//
//  BindingMobileViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/10.
//

#import "BindingMobileViewController.h"

@interface BindingMobileViewController ()

@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger time;
@property(nonatomic,weak)IBOutlet UIButton * codeButton;

@end

@implementation BindingMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.time = 60;
    self.codeButton.layer.cornerRadius = 15;
    self.codeButton.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    self.codeButton.layer.borderWidth = 0.5;
}

- (IBAction)sendCode:(UIButton *)sender{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:true];
}

- (void)timeChange{
    if (self.time > 1) {
        self.time--;
        [self.codeButton setTitle:[NSString stringWithFormat:@"%ld秒",self.time] forState:UIControlStateNormal];
        self.codeButton.userInteractionEnabled = NO;
    }else{
        self.time = 60;
        [self.timer invalidate];
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeButton.userInteractionEnabled = YES;
    }
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
