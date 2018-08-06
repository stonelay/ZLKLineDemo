//
//  GLLoadTool.h
//  OpenGLDemo
//
//  Created by LayZhang on 2018/2/26.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLLoadTool : NSObject

+ (GLuint)setupTexture:(NSString *)fileName texure:(GLenum)texure;

@end
