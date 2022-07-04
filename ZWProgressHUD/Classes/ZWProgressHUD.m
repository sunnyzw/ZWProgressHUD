//
//  ZWProgressHUD.m
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import "ZWProgressHUD.h"
#import "MBProgressHUD.h"

@implementation ZWProgressHUD

// MARK: - 公开方法
/// 显示菊花
+ (void)showIndeterminate:(UIView *)view {
    MBProgressHUD *hud = [self createHUD:view message:nil mode:MBProgressHUDModeIndeterminate];
    hud.margin = 10;
}

/// 显示自定义动画
+ (void)showCustomAnimation:(UIView *)view {
    MBProgressHUD *hud = [self createHUD:view message:nil mode:MBProgressHUDModeCustomView];
    hud.bezelView.backgroundColor = UIColor.clearColor;
    hud.customView = [self createGifAnimation];
}

/// 显示自定义动画
+ (void)showCustomAnimation:(UIView *)view offsetY:(CGFloat)offsetY {
    MBProgressHUD *hud = [self createHUD:view message:nil mode:MBProgressHUDModeCustomView];
    hud.bezelView.backgroundColor = UIColor.clearColor;
    hud.customView = [self createGifAnimation];
    CGRect frame = hud.frame;
    frame.origin.y = offsetY;
    frame.size.height = frame.size.height - offsetY;
    hud.frame = frame;
}

/// 显示文字提示，2s后自动隐藏
+ (void)showMessage:(NSString *)message view:(UIView *)view {
    MBProgressHUD *hud = [self createHUD:view message:message mode:MBProgressHUDModeText];
    [hud hideAnimated:true afterDelay:2];
}

/// 显示成功提示，2s后自动隐藏
+ (void)showSuccess:(NSString *)message view:(UIView *)view {
    MBProgressHUD *hud = [self createCustomViewHUD:view imageName:@"" message:message];
    [hud hideAnimated:true afterDelay:2];
}

/// 显示失败提示，2s后自动隐藏
+ (void)showFailure:(NSString *)message view:(UIView *)view {
    MBProgressHUD *hud = [self createCustomViewHUD:view imageName:@"" message:message];
    [hud hideAnimated:true afterDelay:2];
}

/// 显示警告提示，2s后自动隐藏
+ (void)showWarning:(NSString *)message view:(UIView *)view {
    MBProgressHUD *hud = [self createCustomViewHUD:view imageName:@"" message:message];
    [hud hideAnimated:true afterDelay:2];
}

/// 显示进度条
+ (void)showProgress:(float)progress view:(UIView *)view {
    MBProgressHUD *hud = [self createHUD:view message:nil mode:MBProgressHUDModeAnnularDeterminate];
    hud.progress = progress;
}

/// 隐藏
+ (void)hide:(UIView *)view {
    for (UIView *hud in view.subviews) {
        if ([hud isKindOfClass:MBProgressHUD.class]) {
            [(MBProgressHUD *)hud hideAnimated:true];
            [hud removeFromSuperview];
        }
    }
}

// MARK: - 私有方法
/// 创建 HUD
+ (MBProgressHUD *)createHUD:(UIView *)view message:(NSString *)message mode:(MBProgressHUDMode)mode {
    [self hide:view];
    if (!view) {
        return nil;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:true];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    hud.bezelView.backgroundColor = mode == MBProgressHUDModeCustomView ? UIColor.clearColor : [UIColor.blackColor colorWithAlphaComponent:0.8];
    hud.contentColor = UIColor.whiteColor;
    hud.margin = 18;
    hud.userInteractionEnabled = message == nil || message.length == 0;
    hud.removeFromSuperViewOnHide = true;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.mode = mode;
    return hud;
}

/// 创建自定义视图 HUD
+ (MBProgressHUD *)createCustomViewHUD:(UIView *)view imageName:(NSString *)imageName message:(NSString *)message {
    MBProgressHUD *hud = [self createHUD:view message:message mode:MBProgressHUDModeCustomView];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    return hud;
}

/// 创建自定义Gif动画
+ (UIImageView *)createGifAnimation {
    NSMutableArray<UIImage *> *animationImages = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [animationImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"animation_%d", i]]];
    }
    UIImageView *customImgView = [[UIImageView alloc] init];
    customImgView.animationImages = animationImages;
    customImgView.animationRepeatCount = 0;
    customImgView.animationDuration = (animationImages.count + 1) * 0.15;
    [customImgView startAnimating];
    return customImgView;
}

@end
