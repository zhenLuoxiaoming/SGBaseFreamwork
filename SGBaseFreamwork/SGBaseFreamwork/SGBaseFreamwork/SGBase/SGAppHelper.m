//
//  SGAppHelper.m
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "SGAppHelper.h"
#import "SGBaseMacro.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <objc/runtime.h>
#import <CoreImage/CoreImage.h>// 二维码

@implementation SGAppHelper
#pragma -mark:时间戳
+ (long long)currentTime{
    NSDate* date = [NSDate date];
    double time  = [date timeIntervalSince1970];
    NSNumber* number = [NSNumber numberWithDouble:time];
    return [number longLongValue];
}

#pragma -mark:通过一个View将其内容生成图片
+(UIImage *)imageWithCaputureView:(UIView *)view
{
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 把控件上的图层渲染到上下文,layer只能渲染
    [view.layer renderInContext:ctx];
    
    // 生成一张图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

#pragma -mark:裁剪图片
+(UIImage *)clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage {
    CGImageRef imageRef = [clipImage CGImage];
    CGSize size = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));//这个size就是实际图片的像素大小
    CGFloat Bili = size.height / SG_SCREEN_HEIGHT;
    CGImageRef ref = CGImageCreateWithImageInRect([clipImage CGImage], CGRectMake(clipRect.origin.x * Bili, clipRect.origin.y * Bili, clipRect.size.width * Bili, clipRect.size.height * Bili));//这里的rect切割是按图片的像素切割
    UIImage *img = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return  img;
}

#pragma -mark: 压缩图片
+(UIImage *)litleImage:(UIImage *)myimage
{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(myimage, 0.5);
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    UIImage * image = [UIImage imageWithData:data];
    return image;
}

#pragma -mark:二维码生成
+(UIImage *)QRcodeWithStr:(NSString *)str{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    // 2. 给滤镜添加数据
    NSString *string = str;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    // 4. 显示二维码
    return [self createNonInterpolatedUIImageFormCIImage:image withSize:200];
}

+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma -mark:字典转json字符串
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma -mark:数组转json
+(NSString *)arrayToJSONString:(NSArray *)array
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

#pragma -mark:字典转json
+(NSDictionary *)dicWithjasonSring:(NSString *)str {
    if (str == nil) {
        return nil;
    }
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma -mark:加载storyBorad的控制器
+(UIViewController *)loadStoryBoradSBID:(NSString *)SBID VCID:(NSString *)VCID {
    if (!VCID) {
        return [[UIStoryboard storyboardWithName:SBID bundle:nil] instantiateInitialViewController];
    }
    return [[UIStoryboard storyboardWithName:SBID bundle:nil] instantiateViewControllerWithIdentifier:VCID];
}

#pragma -mark:打电话
+ (void)callPhoneStr:(NSString*)phoneStr  withVC:(UIViewController *)selfvc{
    NSString *str2 = [[UIDevice currentDevice] systemVersion];
    
    if ([str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedDescending || [str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedSame)
    {
        NSLog(@">=10.2");
        NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",phoneStr];
        if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
            UIApplication * app = [UIApplication sharedApplication];
            if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
                [app openURL:[NSURL URLWithString:PhoneStr]];
            }
        }
    }else {
        NSMutableString* str1 = [[NSMutableString alloc]initWithString:phoneStr];// 存在堆区，可变字符串
        if (phoneStr.length == 10) {
            [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
            [str1 insertString:@"-"atIndex:7];// 把一个字符串插入另一个字符串中的某一个位置
        }else {
            [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
            [str1 insertString:@"-"atIndex:8];// 把一个字符串插入另一个字符串中的某一个位置
        }
        NSString * str = [NSString stringWithFormat:@"是否拨打电话\n%@",str1];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message: nil preferredStyle:UIAlertControllerStyleAlert];
        // 设置popover指向的item
        alert.popoverPresentationController.barButtonItem = selfvc.navigationItem.leftBarButtonItem;
        // 添加按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSLog(@"点击了呼叫按钮10.2下");
            NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",phoneStr];
            if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
                UIApplication * app = [UIApplication sharedApplication];
                if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
                    [app openURL:[NSURL URLWithString:PhoneStr]];
                }
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"点击了取消按钮");
        }]];
        [selfvc presentViewController:alert animated:YES completion:nil];
    }
}

#pragma -mark:当前设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    // 2017
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}

#pragma -mark:时间戳转时间字符串(秒)
+(NSString *)TimeStampFromStr:(long long)stamp{
    NSTimeInterval interval=stamp;// / 1000.0;
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}

#pragma -mark:时间戳转时间字符串（毫秒）
+(NSString *)TimeStampFromStrMS:(long long)stamp{
    NSTimeInterval interval=stamp / 1000.0;
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}

#pragma -mark:时间戳转自定义格式化时间字符串 (毫秒)
+(NSString *)TimeStampFromStrMS:(long long)stamp FormaterStr:(NSString *)formaterStr{
    NSTimeInterval interval=stamp / 1000.0;
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:formaterStr];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}

#pragma -mark:距离现在的时间
+(NSString *)dateFormNow:(NSString *)dateStr {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSDate * newDate = [dateFormatter dateFromString:dateStr];
    NSDateFormatter * fomater = [[NSDateFormatter alloc]init];
    [fomater setDateFormat:@"yyyy-MM-dd"];
    NSString * returnStr = [fomater stringFromDate:newDate];
    NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 8];
    double  shijian =  [nowDate timeIntervalSinceDate:newDate];
    int day  = shijian / (24 * 60 * 60) ;
    int hour = ((int)shijian%(24 * 60 * 60)) / (60 * 60 );
    int min  = shijian / 60;
    if (day == 0 && hour == 0 && min < 1) {
        return [NSString stringWithFormat:@"刚刚"];
    }else if(day == 0 && hour == 0) {
        return [NSString stringWithFormat:@"%d分钟前",min];
    }else if(day == 0 && hour > 0) {
        return [NSString stringWithFormat:@"%d小时前",hour];
    }else if(day > 0 && day < 1) {
        return [NSString stringWithFormat:@"昨天"];
    }else {
        return returnStr;
    }
}

#pragma -mark:传入date类型值 返回一个自定义格式化的字符串
+(NSString *)dateStr:(NSDate *)date andFormatterStr:(NSString *)FormatterStr{
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:FormatterStr];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    return timeStr;
}

#pragma -mark:星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:inputDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}
@end
