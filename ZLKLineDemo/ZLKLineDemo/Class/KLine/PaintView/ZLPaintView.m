//
//  ZLPaintView.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/8/1.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLPaintView.h"

#import "ZLPaintCore.h"
#import "ZLPaintMainScene.h"
#import "ZLPaintAssistScene.h"

#import "ZLQuoteDataCenter.h"

@interface ZLPaintView()

@property (nonatomic, strong) ZLPaintCore *paintCore;

@property (nonatomic, strong) ZLPaintMainScene *mainPaintScene;
@property (nonatomic, strong) ZLPaintAssistScene *assistPaintScene;

@property (nonatomic, assign) BOOL isAllLoad;

@end

@implementation ZLPaintView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initDefault];
        [self loadData];
    }
    return self;
}

- (void)initDefault {
    [super initDefault];
    self.backgroundColor = ZLGray(33);
    
    self.paintCore = [[ZLPaintCore alloc] init];
    self.paintCore.paintMainType = GuidePaintMainTypeNone;
    self.paintCore.paintAssistType = GuidePaintAssistTypeKDJ;
    
    self.mainPaintScene = [[ZLPaintMainScene alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height / 3 * 2)];
    self.mainPaintScene.paintCore = self.paintCore;
    
    self.assistPaintScene = [[ZLPaintAssistScene alloc] initWithFrame:CGRectMake(0, self.height / 3 * 2, self.width, self.height / 3)];
    self.assistPaintScene.paintCore = self.paintCore;
    
    [self addSubview:self.mainPaintScene];
    [self addSubview:self.assistPaintScene];
}

- (void)loadData {
    [SVProgressHUD showWithStatus:@"初始化数据"];
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        self.userInteractionEnabled = YES;
        self.paintCore.drawDataArray = [ZLQuoteDataCenter shareInstance].hisKLineDataArray;
        [self draw];
    });
}

- (void)loadMoreData {
    if (self.isAllLoad) {
        return;
    }
    [SVProgressHUD showWithStatus:@"加载更多历史数据"];
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        self.userInteractionEnabled = YES;
        
        if ([[ZLQuoteDataCenter shareInstance] isLastData]) {
            [@"没有更多行情" showNotice];
            self.isAllLoad = YES;
            return;
        }
        [[ZLQuoteDataCenter shareInstance] loadMoreHisData];
        self.paintCore.drawDataArray = [ZLQuoteDataCenter shareInstance].hisKLineDataArray;
        [self draw];
    });
}


#pragma mark - override
- (void)draw {
    [self.mainPaintScene draw];
    [self.assistPaintScene draw];
}

// tap
- (void)tapAtPoint:(CGPoint)point {
    if (CGRectContainsPoint(self.mainPaintScene.frame, point)) {
        [self.mainPaintScene tapAtPoint:point];
    }
    
    if (CGRectContainsPoint(self.assistPaintScene.frame, point)) {
        [self.assistPaintScene tapAtPoint:point];
    }
}

// pan
- (void)panBeganPoint:(CGPoint)point {
    [self.mainPaintScene panBeganPoint:point];
    [self.assistPaintScene panBeganPoint:point];
}
- (void)panChangedPoint:(CGPoint)point {
    [self.mainPaintScene panChangedPoint:point];
    [self.assistPaintScene panChangedPoint:point];
}
- (void)panEndedPoint:(CGPoint)point {
    [self.mainPaintScene panEndedPoint:point];
    [self.assistPaintScene panEndedPoint:point];
    
    if (self.paintCore.curIndex < 20) {
        [self loadMoreData];
    }
}

// pinch
- (void)pinchBeganScale:(CGFloat)scale {
    [self.mainPaintScene pinchBeganScale:scale];
    [self.assistPaintScene pinchBeganScale:scale];
}
- (void)pinchChangedScale:(CGFloat)scale {
    [self.mainPaintScene pinchChangedScale:scale];
    [self.assistPaintScene pinchChangedScale:scale];
}
- (void)pinchEndedScale:(CGFloat)scale {
    [self.mainPaintScene pinchEndedScale:scale];
    [self.assistPaintScene pinchEndedScale:scale];
    
    if (self.paintCore.isShowAll) {
        [self loadMoreData];
    }
}

// longPress
- (void)longPressBeganLocation:(CGPoint)location {
    [self.mainPaintScene longPressBeganLocation:location];
    [self.assistPaintScene longPressBeganLocation:location];
}
- (void)longPressChangedLocation:(CGPoint)location {
    [self.mainPaintScene longPressChangedLocation:location];
    [self.assistPaintScene longPressChangedLocation:location];
}
- (void)longPressEndedLocation:(CGPoint)location {
    [self.mainPaintScene longPressEndedLocation:location];
    [self.assistPaintScene longPressEndedLocation:location];
}

#pragma mark - system
- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
