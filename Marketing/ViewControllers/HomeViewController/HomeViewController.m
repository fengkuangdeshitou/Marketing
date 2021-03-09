//
//  HomeViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,weak)IBOutlet UIButton * beforeButton;
@property(nonatomic,weak)IBOutlet UIButton * nextButton;
@property(nonatomic,weak)IBOutlet UILabel * contentLabel;
@property(nonatomic,weak)IBOutlet UILabel * pageLabel;
@property(nonatomic,weak)IBOutlet UIImageView * icon;
@property(nonatomic,assign)NSInteger currentFlag;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.currentFlag = 0;
    self.beforeButton.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
    self.beforeButton.layer.borderWidth = 1;
    
    [self addObserver:self forKeyPath:@"currentFlag" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@",change);
    if (self.currentFlag == 0) {
        self.beforeButton.enabled = NO;
    }else if (self.currentFlag == self.dataArray.count) {
        self.nextButton.enabled = NO;
    }else{
        self.beforeButton.enabled = YES;
        self.nextButton.enabled = YES;
    }
}

- (IBAction)beforeAction:(id)sender{
    if (self.currentFlag > 0) {
        self.currentFlag--;
    }
}

- (IBAction)nextAction:(id)sender{
    if (self.currentFlag < self.dataArray.count) {
        self.currentFlag ++;
    }
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
