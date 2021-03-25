//
//  UserInfoViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/2/28.
//

#import "UserInfoViewController.h"
#import "UserInfoHeaderCell.h"
#import "SettingCell.h"
#import "EditUserInfoViewController.h"
#import "PhotoManager.h"

@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView * tableView;
@property(nonatomic,strong) NSArray * titleArray;
@property(nonatomic,strong)NSMutableArray * valueArray;
@property(nonatomic,strong) UserModel * userModel;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userModel = [UserManager getUser];
    self.titleArray = @[@"名称",@"微信号",@"微信绑定手机号",@"微信二维码"];
    self.valueArray = [[NSMutableArray alloc] initWithArray:@[self.userModel.nickname,self.userModel.wechatNum?:@"暂未填写",self.userModel.contact ?: @"暂无绑定",@""]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserInfoHeaderCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([UserInfoHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SettingCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SettingCell class])];
    self.tableView.tableFooterView = [UIView new];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UserInfoHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoHeaderCell class]) forIndexPath:indexPath];
        cell.model = self.userModel;
        cell.headerImageReloadCompletion = ^{
            if (self.reloadUserInfo) {
                self.reloadUserInfo();
            }
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
    }else{
        SettingCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SettingCell class]) forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArray[indexPath.row];
        
        if (indexPath.row == self.titleArray.count-1) {
            cell.detailIconWidth.constant = 30;
            [ImageLoader loadImage:cell.detailIcon url:self.userModel.wechatErCode placeholder:nil];
        }else{
            cell.detailIconWidth.constant = 5.5;
            cell.detailIcon.image = [UIImage imageNamed:@"setting_cell_more"];
        }
        cell.descLabel.text = self.valueArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self updateUserInfoWithTitle:self.titleArray[indexPath.row] key:@"nickname" completiion:^(NSString * value) {
            self.userModel.nickname = value;
            [self reloadIndexPath:indexPath forValue:value];
        }];
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        [self updateUserInfoWithTitle:self.titleArray[indexPath.row] key:@"wechatNum" completiion:^(NSString * value) {
            self.userModel.wechatNum = value;
            [self reloadIndexPath:indexPath forValue:value];
        }];
    }else if (indexPath.section == 1 && indexPath.row == 2) {
        [self updateUserInfoWithTitle:self.titleArray[indexPath.row] key:@"contact" completiion:^(NSString * value) {
            self.userModel.contact = value;
            [self reloadIndexPath:indexPath forValue:value];
        }];
    }else if (indexPath.section == 1 && indexPath.row == 3) {
        PhotoManager.shareInstance.manager.type = HXPhotoManagerSelectedTypePhoto;
        PhotoManager.shareInstance.manager.configuration.maxNum = 1;
        PhotoManager.shareInstance.manager.configuration.photoMaxNum = 1;
        PhotoManager.shareInstance.manager.configuration.videoMaxNum = 0;
        [self uploadWechatCode];
    }
}

- (void)uploadWechatCode{
    [[PreHelper getCurrentVC] hx_presentSelectPhotoControllerWithManager:PhotoManager.shareInstance.manager didDone:^(NSArray<HXPhotoModel *> * _Nullable allList, NSArray<HXPhotoModel *> * _Nullable photoList, NSArray<HXPhotoModel *> * _Nullable videoList, BOOL isOriginal, UIViewController * _Nullable viewController, HXPhotoManager * _Nullable manager) {
        [photoList hx_requestImageWithOriginal:NO completion:^(NSArray<UIImage *> * _Nullable imageArray, NSArray<HXPhotoModel *> * _Nullable errorArray) {
            [NetworkWorker networkPost:[NetworkUrlGetter getUploadImgUrl] formPostData:UIImageJPEGRepresentation(imageArray.firstObject, 0.3) andFileName:[ImageLoader getCreateImageName:[UserManager getUser].mb_no] success:^(NSDictionary *result) {
                NSLog(@"relu=%@",result);
                [self uploadImageWithUrl:result[@"url"]];
            } failure:^(NSString *errorMessage) {
                [self.view makeToast:errorMessage];
            }];
        }];
        
    } cancel:^(UIViewController * _Nullable viewController, HXPhotoManager * _Nullable manager) {
        
    }];
}

/// 上传微信二维码
/// @param url 微信二维码
- (void)uploadImageWithUrl:(NSString *)url{
    [NetworkWorker networkPost:[NetworkUrlGetter getUpdateMemberInfoUrl] params:@{@"wechatErCode":url} success:^(NSDictionary *result) {
        self.userModel.wechatErCode = url;
        [UserManager saveUser:self.userModel];
        [self.tableView reloadData];
    } failure:^(NSString *errorMessage) {
        [self.view makeToast:errorMessage];
    }];
}

/// 更新数据和刷新页面
/// @param indexPath indexPath
/// @param value value
- (void)reloadIndexPath:(NSIndexPath *)indexPath forValue:(NSString *)value{
    [UserManager saveUser:self.userModel];
    [self.valueArray replaceObjectAtIndex:indexPath.row withObject:value];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if (self.reloadUserInfo) {
        self.reloadUserInfo();
    }
}

/// 跳转编辑用户信息页面
/// @param title title
/// @param key key
/// @param completion 回调
- (void)updateUserInfoWithTitle:(NSString *)title key:(NSString *)key completiion:(void(^)(NSString *))completion{
    EditUserInfoViewController * editUserInfo = [[EditUserInfoViewController alloc] init];
    editUserInfo.title = title;
    editUserInfo.key = key;
    editUserInfo.editBlock = ^(NSString * _Nonnull value) {
        completion(value);
    };
    [self.navigationController pushViewController:editUserInfo animated:true];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? 64 : 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
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
