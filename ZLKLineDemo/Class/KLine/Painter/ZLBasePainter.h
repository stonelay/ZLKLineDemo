//
//  ZLBasePainter.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/17.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLKLinePainter.h"
#import "KLineModel.h"
#import "ZLGuideDataPack.h"

static const CGFloat kHScale = 1.009;
static const CGFloat kLScale = 0.991;
static const CGFloat kSpaceCellScale = 0.75;// 蜡烛宽度 和 cell 的比例

static CGFloat inline candleWidth(CGFloat cellWidth) {
    return cellWidth * kSpaceCellScale;
}
static CGFloat inline candleLeftAdge(CGFloat cellWidth) {
    return cellWidth * (1 - kSpaceCellScale);
}

@protocol PaintViewDataSource;
@protocol PaintViewDelegate;

@interface ZLBasePainter : NSObject<ZLKLinePainter>

@property (nonatomic, weak) id<PaintViewDataSource> dataSource;
@property (nonatomic, weak) id<PaintViewDelegate> delegate;

- (instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

- (instancetype)initWithPaintView:(UIView *)paintView;


#pragma mark - private
/**
 abstract
 初始化
 **/
- (void)p_initDefault;

- (void)p_clear;

// 实际的
- (CGRect)s_bounds;
- (CGRect)s_frame;

// 画布的 在 paintview 中的frame
- (CGFloat)p_left;
- (CGFloat)p_top;
- (CGFloat)p_bottom;
- (CGFloat)p_right;

- (CGFloat)p_height;
- (CGFloat)p_width;
- (CGRect)p_frame;
- (CGRect)p_bounds;
- (void)p_addSublayer:(CALayer *)sublayer;

#pragma mark - data

@end

#pragma mark - datasource
@protocol PaintViewDataSource<NSObject>

// 最多有多少数据 需要 显示
- (NSUInteger)maxNumberInPainter:(ZLBasePainter *)painter;

// 当前页面 需要显示的count
- (NSUInteger)showNumberInPainter:(ZLBasePainter *)painter;

// 当前页面 需要显示 数据(无参数)
- (NSArray *)showArrayInPainter:(ZLBasePainter *)painter;

// 当前页面的 单个数据 (index 是showArray index)
- (KLineModel *)painter:(ZLBasePainter *)painter dataAtIndex:(NSUInteger)index;

// 第一条线的x, 防止滑动时 画面抖动
- (CGFloat)firstCandleXInPainter:(ZLBasePainter *)painter;

// 所有数据是否已显示
- (BOOL)isShowAllInPainter:(ZLBasePainter *)painter;

// longpress
- (CGPoint)longPressPointInPainter:(ZLBasePainter *)painter;
- (NSInteger)longPressIndexInPainter:(ZLBasePainter *)painter;

@optional
// main guide
- (ZLGuideDataPack *)painter:(ZLBasePainter *)painter dataPackByMA:(NSString *)ma; // ma
- (ZLGuideDataPack *)bollDataPackInPainter:(ZLBasePainter *)painter; // boll

// assist guide
- (ZLGuideDataPack *)kdjDataPackInPainter:(ZLBasePainter *)painter; // kdj
- (ZLGuideDataPack *)rsiDataPackInPainter:(ZLBasePainter *)painter; // rsi

@end


#pragma mark - delegate
@protocol PaintViewDelegate<NSObject>
// 屏幕周边
- (UIEdgeInsets)edgeInsetsInPainter:(ZLBasePainter *)painter;

// 单个蜡烛线的宽度
- (CGFloat)cellWidthInPainter:(ZLBasePainter *)painter;

@optional
// main
// 当前屏幕 最高最低价 (有缩放 预留空间)
- (CGFloat)sHigherPriceInPainter:(ZLBasePainter *)painter;
- (CGFloat)sLowerPriceInPainter:(ZLBasePainter *)painter;

// 价格 和 屏幕 像素的单位比
- (CGFloat)painter:(ZLBasePainter *)painter sunitByDValue:(CGFloat)dValue;

// assist
// 当前屏幕 最高最低 (有缩放 预留空间)
- (CGFloat)aHigherValueInPainter:(ZLBasePainter *)painter;
- (CGFloat)aLowerValueInPainter:(ZLBasePainter *)painter;

// 辅助技术指标 单位比
- (CGFloat)painter:(ZLBasePainter *)painter aunitByDValue:(CGFloat)dValue;

@end


