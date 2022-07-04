//
//  ZWProgressHUD.h
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface ZWProgressHUD : UIView

/// 显示菊花
+ (void)showIndeterminate:(UIView *)view;

/// 显示自定义动画
+ (void)showCustomAnimation:(UIView *)view;

/// 显示自定义动画，offsetY：向下偏移量
+ (void)showCustomAnimation:(UIView *)view offsetY:(CGFloat)offsetY;

/// 显示文字提示，2s后自动隐藏
+ (void)showMessage:(NSString *)message view:(UIView *)view;

/// 显示成功提示，2s后自动隐藏
+ (void)showSuccess:(NSString *)message view:(UIView *)view;
//
/// 显示失败提示，2s后自动隐藏
+ (void)showFailure:(NSString *)message view:(UIView *)view;
//
/// 显示警告提示，2s后自动隐藏
+ (void)showWarning:(NSString *)message view:(UIView *)view;

/// 显示进度条
+ (void)showProgress:(float)progress view:(UIView *)view;

/// 隐藏
+ (void)hide:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
