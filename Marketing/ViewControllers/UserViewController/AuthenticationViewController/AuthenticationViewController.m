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

@property(nonatomic,weak)IBOutlet UIButton * autheticationButton;
@property(nonatomic,weak)IBOutlet UITextField * nameTextField;
@property(nonatomic,weak)IBOutlet UITextField * numberTextField;

@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UserModel * model = [UserManager getUser];
    if (model.cert_no.length > 0) {
        [self.autheticationButton setTitle:@"已认证" forState:UIControlStateNormal];
        self.nameTextField.text = model.cert_name;
        self.numberTextField.text = model.cert_no;
        self.nameTextField.userInteractionEnabled = NO;
        self.numberTextField.userInteractionEnabled = NO;
    }else{
        [self.autheticationButton setTitle:@"开始认证" forState:UIControlStateNormal];
    }
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
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [client requestSync:@"http://ediszim.market.alicloudapi.com/zoloz/zim/init" bodyString: bodyString  clientCallback:^(NSString *resultStr) {
                // 调用校验函数
                 [zolozManager auth: resultStr zolozCallback:^(ZolozResult *zolozResult) {
                     if (zolozResult.code!=ZOLOZ_SUCCESS) {
                         [self logError: [NSString stringWithFormat:@"认证失败 : code = %d  data=%@ msg= %@", zolozResult.code, zolozResult.data, zolozResult.msg]];
                         NSDictionary * errorResult = [NSJSONSerialization JSONObjectWithData:[zolozResult.msg dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [self.view makeToast:errorResult[@"msg"]];
                         });
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
                             NSDictionary * result = [NSJSONSerialization JSONObjectWithData:[resultStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                             NSLog(@"result=%@",result);
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 if ([[result objectForKey:@"resultCode"] isEqualToString:@"OK"]) {
                                     [self authWithCertifyId:[jsonDict objectForKey:@"certifyId"]];
                                 }else{
                                     NSLog(@"result=%@",result);
                                     [self.view makeToast:result[@"msg"]];
                                 }
                             });                             
                         }
                     }];
                 }];
            }];
        });
        
    }
}

- (void)authWithCertifyId:(NSString *)certifyId{
    [NetworkWorker networkPost:[NetworkUrlGetter getLivenessCheckUrl] params:@{@"certifyId":certifyId,@"mCertNo":self.numberTextField.text,@"mCertName":self.nameTextField.text} success:^(NSDictionary *result) {
        [self.view makeToast:@"认证成功"];
        UserModel * user = [UserManager getUser];
        user.cert_name = self.nameTextField.text;
        user.cert_no = self.numberTextField.text;
        [UserManager saveUser:user];
        if (self.delegate && [self.delegate respondsToSelector:@selector(onAuthemticationSuccess)]) {
            [self.delegate onAuthemticationSuccess];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *errorMessage) {
        
    }];
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
