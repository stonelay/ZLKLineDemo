//
//  ZLViewController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "ZLViewController.h"
#import "ZLPreMacro.h"
#import "UIView+ZLEX.h"

@interface ZLViewController ()

@property (nonatomic, strong) UIView *navBarContainer;
@property (nonatomic, strong) UILabel *navTitleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation ZLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZLWhiteColor;
    [self createNavBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (NSString *)controllerTitle {
    return [NSStringFromClass(self.class) stringByReplacingOccurrencesOfString:@"Controller" withString:@""];
}

- (UIImage *)leftImage {
    return [UIImage imageNamed:@"icon_back"];
}

- (UIView *)navBarContainer {
    if (!_navBarContainer) {
        _navBarContainer = [[UIView alloc] init];
        _navBarContainer.backgroundColor = ZLWhiteColor;
        _navBarContainer.frame = CGRectMake(0, 0, SCREENWIDTH, 64);
    }
    return _navBarContainer;
}

- (UILabel *)navTitleLabel {
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] init];
        _navTitleLabel.textColor = ZLGray(34);
        _navTitleLabel.font = ZLBoldFont(17);
        _navTitleLabel.text = self.controllerTitle;
        [_navTitleLabel sizeToFit];
        _navTitleLabel.center = CGPointMake(SCREENWIDTH / 2, 20 + 22);
    }
    return _navTitleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:self.leftImage forState:UIControlStateNormal];
        _leftButton.tintColor = ZLWhiteColor;
        _leftButton.frame = CGRectMake(0, 20, 44, 44);
        [_leftButton addTarget:self action:@selector(leftBtnDidTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = ZLGray(240);
        _bottomLine.frame = CGRectMake(0, self.navBarContainer.height - LINEWIDTH, self.navBarContainer.width, LINEWIDTH);
    }
    return _bottomLine;
}

#pragma mark - Public
- (void)createNavBar {
    [self.view addSubview:self.navBarContainer];
    [self.navBarContainer addSubview:self.navTitleLabel];
    [self.navBarContainer addSubview:self.bottomLine];
    if (self.leftImage) {
        [self.view addSubview:self.leftButton];
    }
}

- (void)leftBtnDidTouch {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
