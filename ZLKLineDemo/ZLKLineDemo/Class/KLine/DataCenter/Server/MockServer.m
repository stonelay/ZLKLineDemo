//
//  MockServer.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/7/25.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "MockServer.h"
#import "KLineModel.h"


@interface MockServer()<NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic, strong) NSArray *mockHisData;

@end

@implementation MockServer

+ (instancetype)shareInstance {
    static MockServer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MockServer alloc] init];
    });
    return instance;
}

+ (NSArray *)getMockHisData {
    // 模拟服务器
    [[MockServer shareInstance] loadData];
    return [MockServer shareInstance].mockHisData;
}

static int moreCount = 0;
static int const maxCount = 2;
+ (BOOL)isLastData {
    return moreCount >= maxCount;
}

+ (NSArray *)getMoreMockHisData {
    // 模拟获取更多
    if ([self isLastData]) return nil;
    moreCount++;
    return [MockServer shareInstance].mockHisData;
}

#pragma mark - parsedelegate
- (void)loadData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"N225"
                                                         ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSXMLParser *parser = [[[NSXMLParser alloc] init] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"item"]) {
        KLineModel *data = [[KLineModel alloc] init];
        data.open = [[attributeDict objectForKey:@"open"] floatValue];
        data.high = [[attributeDict objectForKey:@"high"] floatValue];
        data.low =  [[attributeDict objectForKey:@"low"] floatValue];
        data.close = [[attributeDict objectForKey:@"close"] floatValue];
        data.date = [attributeDict objectForKey:@"date"];
        [self.tempArray addObject:data];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    self.mockHisData = [[self.tempArray reverseObjectEnumerator] allObjects];
}

- (NSMutableArray *)tempArray {
    if (!_tempArray) {
        _tempArray = [[NSMutableArray alloc] init];
    }
    return _tempArray;
}

@end
