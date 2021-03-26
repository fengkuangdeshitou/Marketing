//
//  AddValueServicesController.m
//  Marketing
//
//  Created by maiyou on 2021/3/9.
//

#import "AddValueServicesController.h"
#import <StoreKit/StoreKit.h>
#import "NetworkUrl.h"

@interface AddValueServicesController ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@property(nonatomic,weak)IBOutlet UIButton * downloadButton;
@property(nonatomic,weak)IBOutlet UIButton * createButton;

@property(nonatomic,weak)IBOutlet UILabel * remainingDownloadLabel;
@property(nonatomic,weak)IBOutlet UILabel * remainingCreateLabel;
@property(nonatomic,strong)UIView * flagView;
@property(nonatomic,strong)IBOutlet UIView * memberBackgroundView;
@property(nonatomic,assign)NSInteger typeFlag; /// 下载发布标志
@property(nonatomic,assign)NSInteger flag; /// 次数标志
@property(nonatomic,strong)NSArray * downloadNumberArray;
@property(nonatomic,strong)NSArray * createNumberArray;
@property(nonatomic,copy)NSString * requestId;
@property(nonatomic,strong)NSDictionary * priceDictionary;

@end

@implementation AddValueServicesController

- (UIView *)flagView{
    if (!_flagView) {
        _flagView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4-40, 36, 80, 1)];
        _flagView.backgroundColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR];
    }
    return _flagView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.downloadNumberArray = @[@{@"number":@"10次",@"price":@"50"},@{@"number":@"20次",@"price":@"98"},@{@"number":@"50次",@"price":@"198"},@{@"number":@"100次",@"price":@"298"},@{@"number":@"200次",@"price":@"398"},@{@"number":@"500次",@"price":@"498"}];
    self.createNumberArray = @[@{@"number":@"100次",@"price":@"50"},@{@"number":@"200次",@"price":@"98"},@{@"number":@"500次",@"price":@"198"}];
    [self topupItem:self.downloadButton];
    [self exchangeMemberTime:[self.memberBackgroundView viewWithTag:10].gestureRecognizers.firstObject];
    
    [self loadData];
    [self getDicPriceList];
    
}

- (void)loadData{
    [NetworkWorker networkGet:[NetworkUrlGetter getMyGroupDownUrl] success:^(NSDictionary *result) {
        self.remainingDownloadLabel.text = [NSString stringWithFormat:@"%@次",result[@"downCount"]];
        self.remainingCreateLabel.text = [NSString stringWithFormat:@"%@次",result[@"topCount"]];
    } failure:^(NSString *errorMessage) {
        
    }];
}

/// 充值类型
/// @param sender 按钮
- (IBAction)topupItem:(UIButton *)sender{
    [self.downloadButton setTitleColor:[PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR] forState:UIControlStateNormal];
    [self.createButton setTitleColor:[PreHelper colorWithHexString:COLOR_NAVIGATION_TITLE_COLOR] forState:UIControlStateNormal];
    [sender setTitleColor:[PreHelper colorWithHexString:COLOR_MAIN_COLOR] forState:UIControlStateNormal];
    [sender addSubview:self.flagView];
    self.typeFlag = sender == self.downloadButton ?  0 :  1;
    [self setSelectedData];
    [self formatRequesr];
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
    [self formatRequesr];
}

- (void)formatRequesr{
    if (self.typeFlag == 0) {
        if (self.flag == 0) {
            self.requestId = @"com.wecein.weshop_download10";
        }else if (self.flag == 1){
            self.requestId = @"com.wecein.weshop_download20";
        }else{
            self.requestId = @"com.wecein.weshop_download50";
        }
    }else{
        if (self.flag == 0) {
            self.requestId = @"com.wecein.weshop_create100";
        }else if (self.flag == 1){
            self.requestId = @"com.wecein.weshop_create200";
        }else{
            self.requestId = @"com.wecein.weshop_create500";
        }
    }
    NSString * comboPriceId = nil;
    NSArray * createPriceList = self.priceDictionary[@"createPriceList"];
    NSArray * downPriceList = self.priceDictionary[@"downPriceList"];
    if (self.typeFlag == 0) {
        comboPriceId = [NSString stringWithFormat:@"%@",downPriceList[self.flag][@"id"]];
    }else{
        comboPriceId = [NSString stringWithFormat:@"%@",createPriceList[self.flag][@"id"]];;
    }
}

/// 重置数据
- (void)setSelectedData{
    for (int i=0; i<self.createNumberArray.count; i++) {
        UILabel * numberLabel = [[self.memberBackgroundView viewWithTag:i+10] viewWithTag:1000];
        UILabel * priceLabel = [[self.memberBackgroundView viewWithTag:i+10] viewWithTag:2000];
        if (self.typeFlag == 0) {
            numberLabel.text = self.downloadNumberArray[i][@"number"];
            priceLabel.text = self.downloadNumberArray[i][@"price"];
        }else{
            numberLabel.text = self.createNumberArray[i][@"number"];
            priceLabel.text = self.createNumberArray[i][@"price"];
        }
    }
}

/// 价目表
- (void)getDicPriceList{
    [NetworkWorker networkGet:[NetworkUrlGetter getDicPriceListUrl] success:^(NSDictionary *result) {
        self.priceDictionary = result;
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
}

/// 微信支付
/// @param sender 按钮
- (IBAction)wechatAction:(UIButton *)sender{
    
}

/// 支付宝支付
/// @param sender 按钮
- (IBAction)aliAction:(UIButton *)sender{
    
}

/// 苹果支付
/// @param sender 按钮
- (IBAction)appleAction:(UIButton *)sender{
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
        NSLog(@"state=%ld",transaction.transactionState);
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self hideHud];
                    });
                });
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [self verifyPurchaseWithPaymentTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStatePurchasing:{
                NSLog(@"商品添加进列表");
            }
                break;
            case SKPaymentTransactionStateRestored:{
                NSLog(@"已经购买过商品");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self hideHud];
                    });
                });
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

//- (void)dealloc{
//    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
//}

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
                        [self hideHud];
                    });
                });
                NSDictionary *receipt = jsonResponse[@"receipt"];
                NSDictionary *in_app = [receipt[@"in_app"] firstObject];
                
//                NSString *productId = in_app[@"product_id"];
//                NSString *transactionId = in_app[@"transaction_id"];
                //如果是消耗品则记录购买数量，非消耗品则记录是否购买过
    //            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //            if ([productIdentifier isEqualToString:@"123"]) {
    //                int purchasedCount=[defaults integerForKey:productIdentifier];//已购买数量
    //                [[NSUserDefaults standardUserDefaults] setInteger:(purchasedCount+1) forKey:productIdentifier];
    //            }else{
    //                [defaults setBool:YES forKey:productIdentifier];
    //            }
                [self applyPayNotifyWithReceipt:receiptString];
            }else{
                //验证失败，检查你的机器是否越狱
            }
        }
    }];
    
    [task resume];
}

- (void)applyPayNotifyWithReceipt:(NSString *)receipt{
    NSString * comboPriceId = nil;
    NSArray * createPriceList = self.priceDictionary[@"createPriceList"];
    NSArray * downPriceList = self.priceDictionary[@"downPriceList"];
    if (self.typeFlag == 0) {
        comboPriceId = [NSString stringWithFormat:@"%@",downPriceList[self.flag][@"id"]];
    }else{
        comboPriceId = [NSString stringWithFormat:@"%@",createPriceList[self.flag][@"id"]];;
    }
    [NetworkWorker networkPost:[NetworkUrlGetter getApplyPayNotifyUrl] params:@{@"transactionReceipt":receipt,@"comboPriceId":comboPriceId,@"productId":self.requestId} success:^(NSDictionary *result) {
        [self hideHud];
        [self.view makeToast:@"支付成功"];
        [self loadData];
    } failure:^(NSString *errorMessage) {
        [self hideHud];
        [self.view makeToast:errorMessage];
    }];
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
