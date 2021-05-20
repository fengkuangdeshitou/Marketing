//
//  MembersViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "MembersViewController.h"
#import <StoreKit/StoreKit.h>
#import "NetworkUrl.h"
#import "GlobalNotification.h"

@interface MembersViewController ()<UITableViewDelegate,UITableViewDataSource,SKProductsRequestDelegate,SKPaymentTransactionObserver>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,strong)NSArray * list;
@property(nonatomic,strong)IBOutlet UITableViewCell * headerCell;
@property(nonatomic,strong)IBOutlet UITableViewCell * interestsCell;
@property(nonatomic,strong)IBOutlet UIView * interestsView;

@property(nonatomic,strong)IBOutlet UIImageView * avararImageView;
@property(nonatomic,strong)IBOutlet UILabel * userNameLabel;
@property(nonatomic,strong)IBOutlet UILabel * userStatusLabel;
@property(nonatomic,strong)IBOutlet UIView * memberBackgroundView;
@property(nonatomic,assign)NSInteger flag;
@property(nonatomic,strong)UserModel * userModel;
@property(nonatomic,copy)NSString * requestId;

@end

@implementation MembersViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [PreHelper colorWithHexString:@"#202228"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName:[UIColor whiteColor]
    };
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = UIColor.blackColor;
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName:[UIColor blackColor]
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray * titleArray = @[@"无限群码",@"无限发布",@"无限人脉",@"发布视频"];
    for (int i=0; i<titleArray.count; i++) {
        UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake((((SCREEN_WIDTH-38*2-50*4)/3)+50)*(i%4), 95*(i/4), 50, 75)];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_member_%d",i]];
        [contentView addSubview:imageView];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75-13, 95, 13)];
        titleLabel.text = titleArray[i];
        titleLabel.textColor = [PreHelper colorWithHexString:@"#282828"];
        titleLabel.font = [UIFont systemFontOfSize:13];
        [contentView addSubview:titleLabel];
        
        [self.interestsView addSubview:contentView];
    }
 
    [self exchangeMemberTime:[self.memberBackgroundView viewWithTag:10].gestureRecognizers.firstObject];
    
    self.userModel = [UserManager getUser];
    [ImageLoader loadImage:self.avararImageView url:self.userModel.headimgurl placeholder:nil];
    [self getConfig];
    [self getMyVIPInfo];
    [self getPriceList];
}

/// 获取会员信息
- (void)getMyVIPInfo{
    [NetworkWorker networkGet:[NetworkUrlGetter getMyVipUrl] success:^(NSDictionary *result) {
        if ([result[@"vip"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary * level = result[@"vip"][@"level"];
            self.userStatusLabel.text = [NSString stringWithFormat:@"%@ %@",level[@"level_name"],result[@"vip"][@"expire_time"]];
        }
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
}

/// 切换会员时间
/// @param sender 手势
- (IBAction)exchangeMemberTime:(UITapGestureRecognizer *)sender{
    for (UIView * subview in self.memberBackgroundView.subviews) {
        subview.layer.borderWidth = 0;
    }
    sender.view.layer.borderWidth = 2;
    sender.view.layer.borderColor = [PreHelper colorWithHexString:COLOR_ROUND_LINE_COLOR].CGColor;
    self.flag = sender.view.tag - 10;
    if (self.flag == 0) {
        self.requestId = @"com.wecein.weshop_monthMember";
    }else if(self.flag == 1){
        self.requestId = @"com.wecein.weshop_quarterMember";
    }else{
        self.requestId = @"com.wecein.weshop_oneyearMember";
    }
}

- (void)getConfig{
    [NetworkWorker networkGet:[NetworkUrlGetter getIosAuditStateUrl] success:^(NSDictionary *result) {
            
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
}

/// 会员价格表
- (void)getPriceList{
    [NetworkWorker networkGet:[NetworkUrlGetter getPriceListUrl] success:^(NSDictionary *result) {
        NSInteger buyCount = [result[@"buyCount"] integerValue];
        self.list = result[@"list"];
        for (int i=0; i<self.list.count; i++) {
            NSDictionary * item = self.list[i];
            for (UIView * view in self.memberBackgroundView.subviews) {
                UIView * contentView = [view viewWithTag:i+10];
                UILabel * nowPriceLabel = [contentView viewWithTag:1001];
                UILabel * oldPriceLabel = [contentView viewWithTag:1002];
                if (buyCount == 0) {
                    nowPriceLabel.text = [NSString stringWithFormat:@"%@",item[@"sell_price"]];
                    oldPriceLabel.text = [NSString stringWithFormat:@"¥%@",item[@"old_price"]];
                }else{
                    nowPriceLabel.text = [NSString stringWithFormat:@"%@",item[@"frist_price"]];
                    oldPriceLabel.text = [NSString stringWithFormat:@"¥%@",item[@"old_price"]];
                }
            }
        }
    } failure:^(NSString *errorMessage) {
        
    }];
}

/// 内购
/// @param sender 按钮
- (IBAction)payAction:(UIButton *)sender{
    [self showHudInView:self.view hint:@"正在请求商品信息"];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    if ([SKPaymentQueue canMakePayments]) {
        [self requestProductData:self.requestId];
    }else{
        [self hideHud];
        [self.view makeToast:@"暂无付费信息"];
    }
}

/// 到苹果服务器请求商品
/// @param data 商品
- (void)requestProductData:(NSString *)data{
    NSArray * dataArray = [[NSArray alloc] initWithObjects:data, nil];
    NSSet * set = [NSSet setWithArray:dataArray];
    SKProductsRequest * request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    [request start];
}

/// 请求完成
/// @param request 支付请求
- (void)requestDidFinish:(SKRequest *)request{

}

/// 支付失败
/// @param request 支付请求
/// @param error 错误
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    [self hideHud];
    [self.view makeToast:@"请求失败"];
}

/// 收到返回产品信息
/// @param request request
/// @param response response
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray * productsArray = response.products;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideHud];
        });
    });
    
    if (productsArray.count == 0) {
        [self.view makeToast:@"查找不到商品信息"];
        return;
    }
    
    for (SKProduct * product in productsArray) {
        NSLog(@"%@", [product description]);
        NSLog(@"%@", [product localizedTitle]);
        NSLog(@"%@", [product localizedDescription]);
        NSLog(@"%@", [product price]);
        NSLog(@"%@", [product productIdentifier]);
        if([product.productIdentifier isEqualToString:self.requestId]){
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showHudInView:self.view hint:@"正在发起支付"];
                });
            });
            SKPayment * payment = [SKPayment paymentWithProduct:product];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
    }
}

/// 监听购买结果
/// @param queue queue
/// @param transactions transactions
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    for (SKPaymentTransaction * transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [self verifyPurchaseWithPaymentTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStatePurchasing:{
                NSLog(@"商品添加进列表");
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self showHudInView:self.view hint:@"正在付款"];
                    });
                });
            }
                break;
            case SKPaymentTransactionStateRestored:{
                NSLog(@"已经购买过商品");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [self.view makeToast:@"购买失败"];
            }
                break;
            default:
                break;
        }
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)verifyPurchaseWithPaymentTransaction:(SKPaymentTransaction*)transaction{
    [self showHudInView:self.view hint:@"验证支付结果"];
    
    NSURL * receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData * receiptData = [NSData dataWithContentsOfURL:receiptURL];

    
    NSString *receiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"receiptString=%@",receiptString);
    NSString*bodyString = [NSString stringWithFormat:@"{\"receipt-data\":\"%@\"}", receiptString];//拼接请求数据
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:ApplePayUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = bodyData;
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data   options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"jsonResponse=%@",jsonResponse);
        if(jsonResponse !=nil) {
            if([[jsonResponse objectForKey:@"status"]intValue] == 0){
                //通常需要校验：bid，product_id，purchase_date，status
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self applyPayNotifyWithReceipt:receiptString];
                    });
                });
            }else{
                //验证失败，检查你的机器是否越狱
            }
        }
    }];
    [task resume];
}

- (void)applyPayNotifyWithReceipt:(NSString *)receipt{
    NSDictionary * item = self.list[self.flag];
    NSString * combo_price_id = [NSString stringWithFormat:@"%@",item[@"combo_price_id"]];
    [NetworkWorker networkPost:[NetworkUrlGetter getApplyPayNotifyUrl] params:@{@"transactionReceipt":receipt,@"comboPriceId":combo_price_id,@"productId":self.requestId} success:^(NSDictionary *result) {
        [self hideHud];
        if (self.delegate && [self.delegate respondsToSelector:@selector(onRechargeMemberSuccess)]) {
            [self.delegate onRechargeMemberSuccess];
        }
        [self.view makeToast:@"支付成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_VIP_CHANGE object:nil];
        [self getMyVIPInfo];
    } failure:^(NSString *errorMessage) {
        [self hideHud];
        [self.view makeToast:errorMessage];
    }];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.headerCell;
    }else{
        self.userNameLabel.text = self.userModel.nickname;
        return self.interestsCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? 422 : 235;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0 ? 5 : 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footer = [[UIView alloc] init];
    footer.backgroundColor = section == 0 ? [PreHelper colorWithHexString:@"#F6F5FA"] : UIColor.clearColor;
    return footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

// 根据颜色生成UIImage
- (UIImage*)imageWithColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开始画图的上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 设置背景颜色
    [color set];
    // 设置填充区域
    UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // 返回UIImage
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
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
