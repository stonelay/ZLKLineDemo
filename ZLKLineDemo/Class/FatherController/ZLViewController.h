//
//  ZLViewController.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLViewController : UIViewController

@property (nonatomic, strong) NSString *controllerTitle;
@property (nonatomic, weak) UIView *navBarContainer;

- (void)leftBtnDidTouch;

- (void)createNavBarWithTitle:(NSString *)title;
- (void)createNavBarWithTitle:(NSString *)title withLeft:(UIImage *)leftImage;

@end
