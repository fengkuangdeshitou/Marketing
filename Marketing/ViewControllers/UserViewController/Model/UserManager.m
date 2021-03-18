//
//  UserManager.m
//  Marketing
//
//  Created by 王帅 on 2021/3/18.
//

#import "UserManager.h"

NSString * const K_USERVALUE = @"USER";

@implementation UserManager

+ (NSString *)filePath{
    NSString* docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString* filePath = [docPath stringByAppendingPathComponent:@"archiving"];
    return filePath;
}

+ (void)saveUser:(UserModel *)model{
    NSMutableData* data = [[NSMutableData alloc]init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:model forKey:K_USERVALUE];
    [archiver finishEncoding];
    [data writeToFile:[self filePath] atomically:YES];
}

+ (UserModel *)getUser{
    //1.从文件中读取到数据(NSData)
    NSData*  readData = [NSData dataWithContentsOfFile:[self filePath]];
    //2.创建NSKeyedUnarchiver对象
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:readData];
    //3.对数据进行解码操作
    UserModel* model =  [unarchiver decodeObjectForKey:K_USERVALUE];
    //4.完成解码操作
    [unarchiver finishDecoding];
    return model;
}

+ (void)deleteUser{
    NSMutableData* data = [[NSMutableData alloc]init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver finishEncoding];
    [data writeToFile:[self filePath] atomically:YES];
}

@end
