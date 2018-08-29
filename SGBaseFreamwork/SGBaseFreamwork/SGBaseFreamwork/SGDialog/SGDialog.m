//
//  SGDialog.m
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "SGDialog.h"
#import "SVProgressHUD.h"
@implementation SGDialog
+(void)showWeakStr:(NSString *)meg {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];   //背景颜色
    
    [SVProgressHUD showImage:[UIImage imageNamed:@"noimage"] status:meg];
    //    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:3];
}

+ (void)showLoad {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];   //背景颜色
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
}

+(void)showErrorMessage:(NSString *)message afterDelay:(NSTimeInterval)time {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];   //背景颜色
    [SVProgressHUD showErrorWithStatus:message];
    [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:time? time : 2];
}

+(void)showErrorMessage:(NSString *)message {
    [self showErrorMessage:message afterDelay:2];
}

+ (void)showInfoMessage:(NSString *)message afterDelay:(NSTimeInterval)time
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];   //背景颜色
    [SVProgressHUD showInfoWithStatus:message];
    [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:time? time : 2];
}

+(void)showInfoMessage:(NSString *)message {
    [self showInfoMessage:message afterDelay:2];
}

+ (void)showLoadMessage:(NSString*) message {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]]; //字体颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];   //背景颜色
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus: message ? message :@"加载中"];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

@end
