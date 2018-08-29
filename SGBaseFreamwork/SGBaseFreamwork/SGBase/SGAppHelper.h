//
//  SGAppHelper.h
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SGAppHelper : NSObject
/*
 * 当前时间戳
 **/
+ (long long)currentTime;

/*
 * 将view的内容生成一张图片
 **/
+(UIImage *)imageWithCaputureView:(UIView *)view;

/**
 * 裁剪某个图片的某一个区域
 */
+(UIImage *)clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage;

/**
 * 压缩图片
 */
+(UIImage *)litleImage:(UIImage *)myimage;

/*
 * 生成二维码
 **/
+(UIImage *)QRcodeWithStr:(NSString *)str;

/*
 * json字符串转字典
 **/
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 * 数组转json字符串
 */
+(NSString *)arrayToJSONString:(NSArray *)array;

/**
 * json字符串转字典
 */
+(NSDictionary *)dicWithjasonSring:(NSString *)str;

/**
 * 加载storyBoard
 */
+(UIViewController *)loadStoryBoradSBID:(NSString *)SBID VCID:(NSString *)VCID;

/**
 * 优化后的打电话
 */
+ (void)callPhoneStr:(NSString*)phoneStr  withVC:(UIViewController *)selfvc;

/*
 * 当前设备型号
 **/
+ (NSString *)getCurrentDeviceModel;

/****************************************时间相关*******************************************/
/*
 * 时间戳转时间字符串(秒)
 **/
+(NSString *)TimeStampFromStr:(long long)stamp;

/**
 * 时间戳转时间字符串（毫秒）
 */
+(NSString *)TimeStampFromStrMS:(long long)stamp;

/**
 * 时间戳转自定义格式化时间字符串 (毫秒)
 */
+(NSString *)TimeStampFromStrMS:(long long)stamp FormaterStr:(NSString *)formaterStr;

/*
 * 距离现在的时间
 **/
+(NSString *)dateFormNow:(NSString *)dateStr;

/**
 * 传入date类型值 返回一个自定义格式化的字符串
 */
+(NSString *)dateStr:(NSDate *)date andFormatterStr:(NSString *)FormatterStr;

/**
 * 星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
@end
