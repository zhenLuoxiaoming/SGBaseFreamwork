//
//  SGDialog.h
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGDialog : NSObject
/**
 * 无图标提示
 */
+ (void)showWeakStr:(NSString *)meg;

/**
 * 信息图标提示
 */
+ (void)showInfoMessage:(NSString *)message afterDelay:(NSTimeInterval)time;

/**
 * 信息图标提示(会自动关闭)
 */
+ (void)showInfoMessage:(NSString *)message;

/**
 * 错误提示
 */
+ (void)showErrorMessage:(NSString *)message afterDelay:(NSTimeInterval)time;

/**
 * 错误提示（会自动关闭)
 */
+ (void)showErrorMessage:(NSString *)message;

/**
 * 加载中
 */
+ (void)showLoadMessage:(NSString*) message;

/**
 * 加载中
 */
+ (void)showLoad;

/**
 * 关闭
 */
+ (void)dismiss;
@end
