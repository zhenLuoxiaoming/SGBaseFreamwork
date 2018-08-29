//
//  SGBaseNavigationController.m
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "SGBaseNavigationController.h"

@interface SGBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation SGBaseNavigationController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO; //设置导航栏不透明
    self.interactivePopGestureRecognizer.delegate = self;
    [self setUI];
}

-(void)setUI {
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        // 非根控制器,隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 真正在跳转
    [super pushViewController:viewController animated:animated];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.childViewControllers.count >1 ;
}

// 状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
