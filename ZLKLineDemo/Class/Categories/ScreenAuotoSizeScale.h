//
//  ScreenAuotoSizeScale.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/18.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScreenAuotoSizeScale : NSObject

+ (id)getInstance;

@property float autoSizeScaleX;
@property float autoSizeScaleY;

+ (CGRect)CGAutoMakeRect:(CGRect)rect;

+ (CGSize)CGAutoMakeSize:(CGSize)size;

+ (CGFloat)CGAutoMakeFloat:(CGFloat)_float;

+ (void)printRect:(CGRect)rect;

@end
