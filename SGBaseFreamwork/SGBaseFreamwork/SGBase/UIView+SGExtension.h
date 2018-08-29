//
//  UIView+SGUIView_Extension.h
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SGExtension)
/*
 * view的x
 **/
@property (assign, nonatomic) CGFloat sgX;
/*
 * view的y
 **/
@property (assign, nonatomic) CGFloat sgY;
/*
 * view的centerX
 **/
@property (assign, nonatomic) CGFloat sgCenterX;
/*
 * view的centerY
 **/
@property (assign, nonatomic) CGFloat sgCenterY;
/*
 * view的width
 **/
@property (assign, nonatomic) CGFloat sgWidth;
/*
 * view的height
 **/
@property (assign, nonatomic) CGFloat sgHeight;
/*
 * view的Size
 **/
@property (assign, nonatomic) CGSize  sgSize;
/*
 * view的Origin
 **/
@property (assign, nonatomic) CGPoint sgOrigin;

/*
 * view的x
 **/
-(UIViewController *)sgController;
@end
