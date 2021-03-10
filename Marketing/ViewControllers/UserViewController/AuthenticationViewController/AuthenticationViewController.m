//
//  AuthenticationViewController.m
//  Marketing
//
//  Created by maiyou on 2021/3/10.
//

#import "AuthenticationViewController.h"
#import <EsandZim/EsandZim.h>
#import "HttpClient.h"

@interface AuthenticationViewController ()

@property(nonatomic,weak)IBOutlet UITextField * nameTextField;
@property(nonatomic,weak)IBOutlet UITextField * numberTextField;

@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)nextAction:(UIButton *)sender{
    ZolozManager *zolozManager = [[ZolozManager alloc] initWithUIViewController:self];
    // 认证初始化
    ZolozResult* zolozResult = [zolozManager authInit:nil certNo:self.numberTextField.text cerName:self.nameTextField.text];
    if (zolozResult.code == ZOLOZ_SUCCESS) {
        // 发起认证初始化操作
        HttpClient *client = [[HttpClient alloc] init];
        NSError *error;
        NSData *jsonData = [zolozResult.data dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        NSString* bodyString = [NSString stringWithFormat:@"identityParam=%@&packageId=%@&platform=%@&bizId=%@&packageName=%@&appName=%@&metaInfo=%@&businessId=%@",
                                dict[@"identityParam"],dict[@"packageId"],dict[@"platform"],dict[@"bizId"],dict[@"packageId"],dict[@"appName"],dict[@"metaInfo"],dict[@"businessId"]];
        [client requestSync:@"http://ediszim.market.alicloudapi.com/zoloz/zim/init" bodyString: bodyString  clientCallback:^(NSString *resultStr) {
            // 调用校验函数
             [zolozManager auth: resultStr zolozCallback:^(ZolozResult *zolozResult) {
                 if (zolozResult.code!=ZOLOZ_SUCCESS) {
                     [self logError: [NSString stringWithFormat:@"认证失败 : code = %d  data=%@ msg= %@", zolozResult.code, zolozResult.data, zolozResult.msg]];
                     return;
                 }
                 
                 [self logMsg: [[NSString alloc] initWithFormat:@"认证完成: %@", zolozResult.msg]];
                 [self logMsg: @"3. 获取认证结果"];
        
                 NSError *error;
                 NSData *jsonData = [zolozResult.data dataUsingEncoding:NSUTF8StringEncoding];
                 NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
                 NSString * req = [NSString stringWithFormat:@"bizId=%@&certifyId=%@",[jsonDict objectForKey:@"bizid"],[jsonDict objectForKey:@"certifyId"]];
                 //校验成功 从服务器获取认证结果
                 [client requestSync:@"https://ediszim.market.alicloudapi.com/zoloz/zim/getResult" bodyString:req clientCallback:^(NSString *resultStr) {
                     if (!resultStr) {
                         [self logMsg: @"网络请求失败"];
                     }else{
                         [self logMsg: resultStr];
                     }
                 }];
             }];
        }];
    }
}

- (void)logMsg:(NSString*) content
{
    [self logWithContent:content color:[UIColor blackColor]];
}

- (void)logError:(NSString*)content
{
    [self logWithContent:content color:[UIColor redColor]];
}

- (void)logWithContent:(NSString*)content color:(UIColor*)color
{
    if (content == NULL) {
        return;
    }
    
    NSLog(@"content=%@",content);
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