//
//  SGBaseViewController.h
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
/**
 * 一个快捷生成的tableView,在子类中使用的时候只需要将该BaseTableView 加入到视图中（协议代理已经绑定好，为当前控制器）,然后实现协议方法即可。如果有位置大小等需要修改的直接修改frame即可。
 */
@property(nonatomic,strong)UITableView * BaseTableView;

/**
 * 是否隐藏导航栏的那根黑线 YES:隐藏 NO:显示
 * 注:在viewDidload里面设置好.
 */
@property (nonatomic,assign) BOOL hideNavLine;

/**
 * 一个用来做回掉的block，如果有需要在适当的地方去调用。
 */
@property(nonatomic,strong)  void(^commomBlock)(id x);

/**
 * 设置当前控制器导航栏左右的按钮。
 */
// 左
@property (nonatomic,strong) UIButton * leftButton;
// 右
@property (nonatomic,strong) UIButton * rightButton;

/**
 * 设置当前控制器导航栏左右的按钮图片
 * 注:当导航栏左/右按钮只有图片的时候可以使用该方法快速创建左右按钮。
 */
// 左
-(void)setLeftButtonImage:(UIImage *)image;
// 右
-(void)setRightButtonImage:(UIImage *)image;

/**
 * 点击导航栏左按钮时执行的方法。需要实现了 -(void)setLeftButtonImage:(UIImage *)image 或者 给leftButton赋值才能有效
 */
-(void)leftButtonClick;

/**
 * 点击导航栏右按钮时执行的方法。需要实现了 -(void)setRightButtonImage:(UIImage *)image 或者 给rightButton赋值才能有效
 */
-(void)rightButtonClick;

/**
 * 在设置了自定义导航返回按钮的时候点击返回按钮将要执行的方法。
 * 注:如果需要在pop到上一级控制器的时候做某些操作可以在子类当中重写该方法。
 */
-(void)goback;

@end
