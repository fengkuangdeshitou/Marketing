//
//  AddFriendAlertView.m
//  Marketing
//
//  Created by 王帅 on 2021/3/10.
//

#import "AddFriendAlertView.h"
#import <ContactsUI/ContactsUI.h>

@interface AddFriendAlertView ()<CNContactViewControllerDelegate>

@property(nonatomic,strong)CircleModel * model;
@property(nonatomic,weak)IBOutlet UILabel * nameLabel;
@property(nonatomic,weak)IBOutlet UILabel * wechatLabel;
@property(nonatomic,weak)IBOutlet UILabel * mobileLabel;
@property(nonatomic,weak)IBOutlet UIImageView * avatarImageView;
@property(nonatomic,weak)IBOutlet UIButton * duplicateWechatButton;
@property(nonatomic,weak)IBOutlet UIButton * addAddressBookButton;
@property(nonatomic, strong)CNContactViewController *controller;

@end

@implementation AddFriendAlertView

+ (void)addFriendWithModel:(CircleModel *)model{
    AddFriendAlertView * alertView = [[AddFriendAlertView alloc] initWithModel:model];
    [alertView show];
}

- (instancetype)initWithModel:(CircleModel *)model
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AddFriendAlertView class]) owner:self options:nil] lastObject];
        self.frame = UIScreen.mainScreen.bounds;
        self.alpha = 0;
        [UIApplication.sharedApplication.keyWindow addSubview:self];
        self.model = model;
        
        self.nameLabel.text = model.nikename;
        self.wechatLabel.text = [NSString stringWithFormat:@"微信号:%@",model.wechat_num];
        self.mobileLabel.text = [NSString stringWithFormat:@"手机号:%@",model.contact];
        [ImageLoader loadImage:self.avatarImageView url:model.wechat_er_code placeholder:nil];
        
        self.addAddressBookButton.layer.cornerRadius = 17;
        self.addAddressBookButton.layer.borderColor = [PreHelper colorWithHexString:COLOR_MAIN_COLOR].CGColor;
        self.addAddressBookButton.layer.borderWidth = 1;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)show{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
}

/// 复制微信
/// @param sender 按钮
- (IBAction)copyWechat:(UIButton *)sender{
    UIPasteboard * paste = [UIPasteboard generalPasteboard];
    paste.string = @"微信号";
    [self makeToast:@"已复制到剪贴板"];
}

/// 导入通讯录
/// @param sender 按钮
- (IBAction)addAddressBook:(UIButton *)sender{
    [self dismiss];
    
    switch ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts])
        {
                //存在权限
            case CNAuthorizationStatusAuthorized:
                break;
                
                //权限未知
            case CNAuthorizationStatusNotDetermined:
                //请求权限
                break;
                
                //如果没有权限
            case CNAuthorizationStatusRestricted:
            case CNAuthorizationStatusDenied://需要提示
                break;
        }
    
    CNMutableContact * contack = [[CNMutableContact alloc] init];
    contack.nickname = @"啦啦啦";
    CNPhoneNumber * number = [CNPhoneNumber phoneNumberWithStringValue:@"18700850373"];
    CNLabeledValue * value = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:number];
    contack.phoneNumbers = @[value];
    
    
    
//    //初始化方法
//    CNSaveRequest * saveRequest = [[CNSaveRequest alloc]init];
//    //添加联系人
//    [saveRequest addContact:contack toContainerWithIdentifier:nil];
//
//    CNContactStore * store = [[CNContactStore alloc]init];
//    [store executeSaveRequest:saveRequest error:nil];
    
    CNContactViewController * contackController = [CNContactViewController viewControllerForNewContact:contack];
    contackController.contactStore = [[CNContactStore alloc] init];
    contackController.delegate = [PreHelper getCurrentVC];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:contackController];
    nav.navigationBar.barTintColor = [UIColor whiteColor];
    [[PreHelper getCurrentVC] presentViewController:nav animated:true completion:^{

    }];
//    _controller.hidesBottomBarWhenPushed = true;
//    [[PreHelper getCurrentVC].navigationController pushViewController:_controller animated:true];
}

/// 发送到微信
/// @param sender 按钮
- (IBAction)sendToWechat:(UIButton *)sender{
    
}

/// 保存到相册
- (void)saveToPhoto{
    UIImageWriteToSavedPhotosAlbum(self.avatarImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败";
    }else{
        msg = @"保存图片成功";
    }
    [self makeToast:msg];
}

- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(CNContact *)contact{
    if (contact) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"点击了取消，保存失败");
    }
    [viewController dismissViewControllerAnimated:YES completion:nil];
//    [[PreHelper getCurrentVC].navigationController popViewControllerAnimated:true];
}

- (void)dismiss{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
