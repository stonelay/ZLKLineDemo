//
//  ZLDataParser.m
//  ZLKLineDemo
//
//  Created by LayZhang on 2018/8/8.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ZLDataParser.h"
#import "KLineModel.h"

@interface ZLDataParser()<NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *tempArray;

@end

@implementation ZLDataParser

- (NSMutableArray *)parseHisData {
    [self loadData];
    return [[self.tempArray reverseObjectEnumerator] allObjects];
}

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
//    [[self.tempArray reverseObjectEnumerator] allObjects];
}

- (NSMutableArray *)tempArray {
    if (!_tempArray) {
        _tempArray = [[NSMutableArray alloc] init];
    }
    return _tempArray;
}

@end
