//
//  UIView+SGUIView_Extension.m
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "UIView+SGExtension.h"

@implementation UIView (SGExtension)
-(void)setSgX:(CGFloat)sgX {
    CGRect frame = self.frame;
    frame.origin.x = sgX;
    self.frame = frame;
}

- (CGFloat)sgX {
    return self.frame.origin.x;
}

-(void)setSgY:(CGFloat)sgY {
    CGRect frame = self.frame;
    frame.origin.y = sgY;
    self.frame = frame;
}

-(CGFloat)sgY {
    return self.sgY;
}

-(void)setSgCenterX:(CGFloat)sgCenterX {
    CGPoint center = self.center;
    center.x = sgCenterX;
    self.center = center;
}

-(CGFloat)sgCenterX {
    return self.center.x;
}

-(void)setSgCenterY:(CGFloat)sgCenterY {
    CGPoint center = self.center;
    center.y = sgCenterY;
    self.center = center;
}

-(CGFloat)sgCenterY {
    return self.center.y;
}

-(void)setSgWidth:(CGFloat)sgWidth {
    CGRect frame = self.frame;
    frame.size.width = sgWidth;
    self.frame = frame;
}

-(CGFloat)sgWidth {
    return self.frame.size.width;
}

-(void)setSgHeight:(CGFloat)sgHeight {
    CGRect frame = self.frame;
    frame.size.height = sgHeight;
    self.frame = frame;
}

-(CGFloat)sgHeight {
    return self.frame.size.height;
}

-(void)setSgSize:(CGSize)sgSize {
    CGRect frame = self.frame;
    frame.size = sgSize;
    self.frame = frame;
}

-(CGSize)sgSize {
    return self.frame.size;
}

-(void)setSgOrigin:(CGPoint)sgOrigin {
    CGRect frame = self.frame;
    frame.origin = sgOrigin;
    self.frame = frame;
}

-(CGPoint)sgOrigin {
    return self.frame.origin;
}

- (UIViewController *)sgController {
    for (UIView *view = self; view; view = view.superview)
    {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
