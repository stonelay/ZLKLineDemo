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
#import "ZLQuoteNode.h"
#import "KLineModel.h"

@interface ZLPaintView()<QuoteListener>

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
        [[ZLQuoteDataCenter shareInstance] addQuoteListener:self];
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

- (void)recQuoteData:(ZLQuoteNode *)quoteNode {
    // 异步转同步
    dispatch_async(dispatch_get_main_queue(), ^{
        // TODO 这里需要判断 是否是该商品， 周期判断，行情是否是在这个节点中，是否要新建节点 等处理
        KLineModel *lastModel = [[self.paintCore.drawDataArray objectAtIndex:self.paintCore.drawDataArray.count - 1] copy];
        if (!lastModel) return;
        
        // 这里只做了模拟处理，实际上需要 判断周期(分线，时线，日线，周线等),判断时间断
        if ([lastModel.date isEqualToString:quoteNode.tradeDay]) {
            // 同一个时间段 做融合处理
            if (lastModel.high < quoteNode.bid) {
                lastModel.high = quoteNode.bid;
            }
            
            if (lastModel.low > quoteNode.bid) {
                lastModel.low = quoteNode.bid;
            }
            
            lastModel.close = quoteNode.bid;
            [self.paintCore.drawDataArray setObject:lastModel atIndexedSubscript:self.paintCore.drawDataArray.count - 1];
        } else {
            // 不是一个时间段 新建节点
            KLineModel *newModel = [[KLineModel alloc] init];
            newModel.low = quoteNode.bid;
            newModel.high = quoteNode.bid;
            newModel.open = quoteNode.bid;
            newModel.close = quoteNode.bid;
            newModel.date = quoteNode.tradeDay;
            
            NSMutableArray *tArray = self.paintCore.drawDataArray.mutableCopy;
            [tArray addObject:newModel];
            self.paintCore.drawDataArray = tArray;
        }
        
        // 新增节点时才需要绘制
        if (self.paintCore.isShowLast) {
            [self draw];
        }
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
