//
//  AddValueServicesController.m
//  Marketing
//
//  Created by maiyou on 2021/3/9.
//

#import "AddValueServicesController.h"
#import <StoreKit/StoreKit.h>

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
//    self.requestId = @"com.wecein.weshop_yearMember";
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
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    if ([SKPaymentQueue canMakePayments]) {
        [self requestProductData:self.requestId];
    }else{
        NSLog(@"不允许程序内付费");
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

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray * productsArray = response.products;
    NSLog(@"%@", productsArray);
    if (productsArray.count == 0) {
        [self.view makeToast:@"查找不到商品信息"];
        return;
    }
    
    NSLog(@"支付中");
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

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    for (SKPaymentTransaction * transaction in transactions) {
        [self verifyPurchaseWithPaymentTransaction:transaction];
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"buyed"];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
                break;
            case SKPaymentTransactionStateRestored:{
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
    NSURL * receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData * receiptData = [NSData dataWithContentsOfURL:receiptURL];
    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSURL *url = [NSURL URLWithString:@""];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", encodeStr];

    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:payloadData];
    [request setHTTPMethod:@"POST"];
    NSURLResponse*response =nil;
    // 此请求返回的是一个json结果  将数据反序列化为数据字典

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if(data ==nil) {
        return;
    }

    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data   options:NSJSONReadingAllowFragments error:nil];
    if(jsonResponse !=nil) {
        if([[jsonResponse objectForKey:@"status"]intValue] == 0){
            //通常需要校验：bid，product_id，purchase_date，status
        }else{
            //验证失败，检查你的机器是否越狱
        }
    }
    //结束交易
    [self finshTransaction:transaction];
}

- (void)finshTransaction:(SKPaymentTransaction*)transaction{
    //结束交易
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

/// 请求完成
/// @param request 支付请求
- (void)requestDidFinish:(SKRequest *)request{

}

/// 支付失败
/// @param request 支付请求
/// @param error 错误
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{

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
