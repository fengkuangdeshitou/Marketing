//
//  ProfitableViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/3/1.
//

#import "ProfitableViewController.h"
#import "ProfitHeaderCell.h"
#import "ProfitShareCell.h"
#import "DrawAmountViewController.h"
#import "InvitationViewController.h"

@interface ProfitableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,weak)IBOutlet UIView * todayView;
@property(nonatomic,weak)IBOutlet UIView * totalView;
@property(nonatomic,weak)IBOutlet UIView * invitationView;
@property(nonatomic,strong) NSArray * titleArray;

@end

@implementation ProfitableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"赚钱";
    [self addShadowWithView:self.todayView];
    [self addShadowWithView:self.totalView];
    [self addShadowWithView:self.invitationView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ProfitHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ProfitHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ProfitShareCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ProfitShareCell class])];
    
    
    
}

/// 提现
/// @param sender 按钮
- (IBAction)drawAmount:(UIButton *)sender{
    DrawAmountViewController * drawAmount = [[DrawAmountViewController alloc] init];
    drawAmount.title = @"提现";
    drawAmount.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:drawAmount animated:true];
}

/// 邀请记录
/// @param sender 按钮
- (IBAction)InvitationAction:(UIButton *)sender{
    InvitationViewController * invitation = [[InvitationViewController alloc] init];
    invitation.title = @"邀请记录";
    invitation.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:invitation animated:true];
}
- (void)addShadowWithView:(UIView *)view{
    view.layer.shadowColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:0.35].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,0);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 5;
    view.layer.cornerRadius = 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ProfitHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProfitHeaderCell class]) forIndexPath:indexPath];
        return cell;
    }else{
        ProfitShareCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProfitShareCell class]) forIndexPath:indexPath];
        return cell;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return UITableViewAutomaticDimension;
    }else{
        return 71;
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
