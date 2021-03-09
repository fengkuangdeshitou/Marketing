//
// NSString+MD5.h
// Originally created for MyFile
//
// Created by Árpád Goretity, 2011. Some infos were grabbed from StackOverflow.
// Released into the public domain. You can do whatever you want with this within the limits of applicable law (so nothing nasty!).
// I'm not responsible for any damage related to the use of this software. There's NO WARRANTY AT ALL.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

// The string's MD5 hash
- (NSString *) MD5Hash;
/**  32位大写  */
- (NSString *)md5_32bit;
/**  32位小写  */
- (NSString *)md5HashToLower32Bit;

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;

/**  判断字符串是否为空  */
- (BOOL)isBlankString;

@end

