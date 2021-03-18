//
//  PreHelper.m
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "MyTabbarViewController.h"
#import "LoginViewController.h"
#import "CustomNavagationController.h"

@implementation PreHelper

+ (UIColor *)colorWithHexString:(NSString *)color{
    return [self colorWithHexString:color alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (BOOL)isLogin{
    UserModel * model = [UserManager getUser];
    if (model) {
        return YES;
    }else{
        return NO;
    }
}

+ (void)pushToTabbarController{
    MyTabbarViewController *tabbar = [[MyTabbarViewController alloc] init];
    UIWindow *window =  [[UIApplication sharedApplication].delegate window];
    window.rootViewController = tabbar;
    [window makeKeyAndVisible];
}

+ (void)pushToLoginController{
    LoginViewController *login = [[LoginViewController alloc] init];
    CustomNavagationController * nav = [[CustomNavagationController alloc] initWithRootViewController:login];
    UIWindow *window =  [[UIApplication sharedApplication].delegate window];
    window.rootViewController = nav;
    [window makeKeyAndVisible];
}

+ (UIViewController *)jsd_getRootViewController{

    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController* currentViewController = [self jsd_getRootViewController];

    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else {
                break;
            }
        }
    }
    return currentViewController;
}

+ (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)setCreateTime:(NSString *)createTime {
    NSDate *dateTime = [[NSDate alloc] initWithTimeIntervalSince1970:[createTime longLongValue] / 1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"yyyy年MM月dd HH:mm"];
    NSString *dateString = [formatter stringFromDate:dateTime];
    return dateString;
}

+ (NSString *)getHourAndMinute:(NSDate *)date {
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* nowHour = [cal components:NSHourCalendarUnit fromDate:date];
    NSDateComponents* nowMinute = [cal components:NSMinuteCalendarUnit fromDate:date];
//    NSDateComponents* nowSceond = [cal components:NSCalendarUnitSecond fromDate:date];
    NSString *hour = [NSString stringWithFormat:@"%ld",(long)nowHour.hour];
    NSString *minute = [NSString stringWithFormat:@"%ld",(long)nowMinute.minute];
//    NSString *sceonds = [NSString stringWithFormat:@"%ld",(long)nowSceond.second];
    if (minute.length == 1) {
        minute = [@"0" stringByAppendingString:minute];
    }
    return [[hour stringByAppendingString:@":"]stringByAppendingString:minute];
}


+ (NSString *)getDays:(NSString *)dateStr {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate * date2 = [NSDate dateWithTimeIntervalSince1970:[dateStr longLongValue] / 1000];
    //创建了两个日期对象
    NSDate *date1= [NSDate new];
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    int days=((int)time)/(3600*24);
    return [NSString stringWithFormat:@"%i",days];
}

+ (NSString *)getHours:(NSString *)dateStr {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate * date2 = [NSDate dateWithTimeIntervalSince1970:[dateStr longLongValue] / 1000];
    //创建了两个日期对象
    NSDate *date1= [NSDate new];
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    int hours=((int)time)%(3600*24)/3600;
    return [NSString stringWithFormat:@"%i",hours];
}

+ (NSDateComponents *)getDate:(NSString *)dateStr
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 截止时间字符串格式
    NSString *expireDateStr = [dateFomatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dateStr longLongValue]/1000]];
    // 当前时间字符串格式
    NSString *nowDateStr = [dateFomatter stringFromDate:nowDate];
    // 截止时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:expireDateStr];
    // 当前时间data格式
    nowDate = [dateFomatter dateFromString:nowDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];
    return dateCom;
}

+ (void)setExtraCellLineHidden:(UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (NSString *)stringFormatDateMin:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT_TAKE_MIN];
    return [dateFormatter stringFromDate:date];
}

+ (NSData *)toJSONData:(id)theData{
      
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0){
        return jsonData;
    }else{
        return nil;
    }
}

+ (long long)getTimeSince1970InMsLongLong {
    NSDate *dateNow = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:dateNow];
    NSDate *localeDate = [dateNow dateByAddingTimeInterval:interval];
    return (long long) [localeDate timeIntervalSince1970] * 1000;
}

+(NSDate*)dateFromString:(NSString*)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    return [dateFormatter dateFromString:dateString];
}

+ (NSString *)compareCurrentTime:(long long)time {
    NSDate * timeDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    NSString *result;
    if (timeInterval/60 < 1)
    {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage; 
}

+ (NSString *)getCurrentDataAndTime {
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    int year=[comps year];
    int month = [comps month];
    int day = [comps day];
//    m_labDate.text=[NSString stringWithFormat:@"%d年%d月",year,month];
//    m_labToday.text=[NSString stringWithFormat:@"%d",day];
//    m_labWeek.text=[NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week]];
    NSString *weekDay = [arrWeek objectAtIndex:week-1];
    return [[[[[NSString stringWithFormat:@"%d",month]stringByAppendingString:@"月"]stringByAppendingFormat:@"%d",day] stringByAppendingString:@"日  "]stringByAppendingString:weekDay];
}

+ (NSString *)getSubmitMouth:(long long)submitTime {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:submitTime / 1000];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    return [NSString stringWithFormat:@"%ld",(long)[comps month]];
}

+ (NSString *)getSubmitDays:(long long)submitTime {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:submitTime / 1000];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    return [NSString stringWithFormat:@"%ld",(long)[comps day]];
}


+(long long)longLongFromDate:(NSDate*)date{
    return [date timeIntervalSince1970] * 1000;
}

+ (CGFloat)getCircleContentHeight:(NSString *)content {
    UIFont *font = [UIFont systemFontOfSize:17];
    CGRect rect = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 83, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil];
    return rect.size.height;
}

+ (void)resetTableViewFrame:(UITableView *)tableView {
    [UIView beginAnimations:nil context:nil];
    //设定动画持续时间
    [UIView setAnimationDuration:kDuration];
    //动画的内容
    tableView.frame = CGRectMake(tableView.frame.origin.x, 0, tableView.frame.size.width, tableView.frame.size.height);
    //动画结束
    [UIView commitAnimations];
}

+ (void)resignFirstResponderTextFieldOrTextView:(NSArray *)fieldArray {
    for (int i = 0 ; i < fieldArray.count; i ++) {
        id field = fieldArray [i];
        if ([field isKindOfClass:[UITextField class]]) {
            UITextField * textFiled = field;
            [textFiled resignFirstResponder];
        } else if ([field isKindOfClass:[UITextView class]]) {
            UITextView * textFiled = field;
            [textFiled resignFirstResponder];
        }
    }
}

+ (long long)getTimeWithDateStr:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate * localeDate = [dateFormatter dateFromString:dateStr];
    return [localeDate timeIntervalSince1970] * 1000;
}

//读取Data文件转字典行 返回来
+(NSDictionary*)ReadDocmentsTempFile :(NSString*)_Name{
    
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *Json_path=[path stringByAppendingPathComponent:_Name];
    NSLog(@"%@",Json_path);
    //==Json数据
    NSData *data=[NSData dataWithContentsOfFile:Json_path];
    
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *data2dic = [unarchiver decodeObjectForKey:_Name];
    [unarchiver finishDecoding];
    NSLog(@"%@",data2dic);
    
    return data2dic;
    
}

+(BOOL)DocumentFilePaht:(NSString*)fileName requestUrl:(NSString*)URl{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *Json_path;
    //NSUserDefaults*myUserDefault = [NSUserDefaults standardUserDefaults];
    
    Json_path=[path stringByAppendingPathComponent:fileName];
    
    
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:Json_path];
    
    return blHave;
}

#pragma mark - 字符串判空
+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)valiMobile:(NSString *)mobile{
    BOOL isValiMobile;
    if (mobile.length < 11)
    {
        isValiMobile = NO;
    }else{
        NSString *phoneRegex1=@"1[3456789]([0-9]){9}";
        NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
        isValiMobile = [phoneTest1 evaluateWithObject:mobile];
        /*
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8])|(19[8,9]))\\d{8}|(1705)\\d{7}$";
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-9])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        NSString *CT_NUM = @"^((133)|(149)|(153)|(166)|(17[1,3,5,7])|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            isValiMobile = YES;
        }else{
            isValiMobile = NO;;
        }
         */
    }
    NSLog(@"isValiMobile=%@",isValiMobile == YES ? @"yes" : @"no");
    return isValiMobile;
}

@end
