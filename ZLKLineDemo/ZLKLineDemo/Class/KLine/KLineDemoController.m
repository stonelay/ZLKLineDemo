//
//  KLineDemoController.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/17.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "KLineDemoController.h"

#import "ZLPaintView.h"

@interface KLineDemoController ()

@property (nonatomic, strong) ZLPaintView *paintView;

@end

@implementation KLineDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:self.controllerTitle withLeft:[UIImage imageNamed:@"icon_back"]];
    
    self.paintView = [[ZLPaintView alloc] initWithFrame:CGRectMake(10, NAVBARHEIGHT + 10, SCREENWIDTH - 2 * 10, SCREENHEIGHT - NAVBARHEIGHT - 2 * 10)];
//    [painter draw];
    
    [self.view addSubview:self.paintView];
    [self.view bringSubviewToFront:self.paintView];
}

- (NSString *)controllerTitle {
    return @"K线图";
}

@end
