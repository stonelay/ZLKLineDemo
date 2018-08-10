//
//  ViewController.m
//  OpenGLDemo
//
//  Created by LayZhang on 2018/1/18.
//  Copyright © 2018年 Zhanglei. All rights reserved.
//

#import "ViewController.h"
#import "MainViewCell.h"
#import "NSObject+ZLEX.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *groups;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (NSString *)controllerTitle {
    return @"MainView";
}

- (UIImage *)leftImage {
    return nil;
}

- (NSArray *)groups {
    if (!_groups) {
        NSMutableArray *tArray = [[NSMutableArray alloc] init];
        NSArray *classes = [ZLViewController zl_subclasses];
        classes = [classes sortedArrayUsingComparator:^(Class obj1, Class obj2){
            NSString *class1 = NSStringFromClass(obj1);
            NSString *class2 = NSStringFromClass(obj2);
            return (NSComparisonResult)[class1 compare:class2 options:NSNumericSearch];
        }];
        
        for (Class subclass in classes) {
            NSString *className = NSStringFromClass(subclass);
            if (![className isEqualToString:@"ViewController"]) {
                ZLViewController *con = [subclass alloc];
                NSString *title = con.controllerTitle ? con.controllerTitle : [className stringByReplacingOccurrencesOfString:@"Controller" withString:@""];
                [tArray addObject:@{@"controllerName": className, @"title":title}];
            }
        }
        _groups = [tArray copy];
        NSLog(@"%@", _groups);
    }
    return _groups;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ZLGray(240);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainViewCell *cell = [MainViewCell cellWithTableView:tableView];
    cell.item = self.groups[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.groups count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *controllerName = self.groups[indexPath.row][@"controllerName"];
    [self.navigationController pushViewController:[[NSClassFromString(controllerName) alloc] init]
                                         animated:YES];
}

@end
