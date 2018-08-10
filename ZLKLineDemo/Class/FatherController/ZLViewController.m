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

@end

@implementation ZLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZLWhiteColor;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Public
- (void)createNavBarWithTitle:(NSString *)title
{
    [self createNavBarWithTitle:title withLeft:nil];
}

- (void)createNavBarWithTitle:(NSString *)title withLeft:(UIImage *)leftImage {
    // 父容器
    UIView *navBarContainer = [[UIView alloc] init];
    self.navBarContainer = navBarContainer;
    [self.view addSubview:navBarContainer];
    navBarContainer.backgroundColor = ZLWhiteColor;
    navBarContainer.frame = CGRectMake(0, 0, SCREENWIDTH, 64);
    //    navBarContainer.layer.masksToBounds = NO;
    //    navBarContainer.layer.shadowColor = YPBlackColor.CGColor;
    //    navBarContainer.layer.shadowOffset = CGSizeMake(0, 0.1);
    //    navBarContainer.layer.shadowOpacity = 0.5;
    //
    
    // 标题标签
    UILabel *navTitleLabel = [[UILabel alloc] init];
    [self.navBarContainer addSubview:navTitleLabel];
    navTitleLabel.backgroundColor = ZLWhiteColor;
    navTitleLabel.textColor = ZLRGB(34, 34, 34);
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.font = ZLBoldFont(17);
    navTitleLabel.text = title;
    navTitleLabel.height = 44;
    
    navTitleLabel.top = 20;
//    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSFontAttributeName] = navTitleLabel.font;
//    attributes[NSForegroundColorAttributeName] = navTitleLabel.textColor;
//    size = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    navTitleLabel.width = SCREENWIDTH;
//    navTitleLabel.left = SCREENWIDTH * 0.5 - navTitleLabel.width * 0.5;
    navTitleLabel.center = CGPointMake(SCREENWIDTH / 2, navTitleLabel.centerY);
    
    // 左侧按钮(固定)
    if (leftImage) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.navBarContainer addSubview:leftBtn];
        [leftBtn setImage:leftImage forState:UIControlStateNormal];
        leftBtn.tintColor = ZLWhiteColor;
        leftBtn.frame = CGRectMake(0, 20, 44, 44);
        [leftBtn addTarget:self action:@selector(leftBtnDidTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // bottomLine
    UIView *bottomLine = [[UIView alloc] init];
    [self.navBarContainer addSubview:bottomLine];
    bottomLine.backgroundColor = ZLRGB(240, 240, 240);
    bottomLine.frame = CGRectMake(0, self.navBarContainer.height - 0.5, self.navBarContainer.width, 0.5);
    
}

- (void)leftBtnDidTouch {
    NSLog(@"left touch");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
