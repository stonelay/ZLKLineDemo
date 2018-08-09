//
//  KLineDemoController.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/17.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "KLineDemoController.h"

#import "ZLPaintView.h"
#import "ZLQuoteDataCenter.h"

@interface KLineDemoController ()<QuoteListener>

@property (nonatomic, strong) UILabel *quoteNoticeLabel;
@property (nonatomic, strong) ZLPaintView *paintView;

@end

@implementation KLineDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:self.controllerTitle withLeft:[UIImage imageNamed:@"icon_back"]];
    
    self.paintView = [[ZLPaintView alloc] initWithFrame:CGRectMake(10, NAVBARHEIGHT + 10, SCREENWIDTH - 2 * 10, SCREENHEIGHT - NAVBARHEIGHT - 2 * 10)];
//    [painter draw];
    
    [self.view addSubview:self.quoteNoticeLabel];
    [self.view addSubview:self.paintView];
    [self.view bringSubviewToFront:self.paintView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[ZLQuoteDataCenter shareInstance] addQuoteListener:self];
}

- (NSString *)controllerTitle {
    return @"K线图";
}

- (UILabel *)quoteNoticeLabel {
    if (!_quoteNoticeLabel) {
        _quoteNoticeLabel = [[UILabel alloc] init];
        _quoteNoticeLabel.font = ZLNormalFont(10);
        _quoteNoticeLabel.textColor = ZLRedColor;
    }
    return _quoteNoticeLabel;
}

#pragma mark - quotelistner
- (void)recQuoteData:(ZLQuoteNode *)quoteNode {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.quoteNoticeLabel.text = quoteNode.nodeDescription;
        self.quoteNoticeLabel.textColor = ZLHEXCOLOR(arc4random() % 0xffffff);
        [self.quoteNoticeLabel sizeToFit];
        self.quoteNoticeLabel.right = SCREENWIDTH - 20 * SCALE;
        self.quoteNoticeLabel.top = 20;
    });
}

@end
