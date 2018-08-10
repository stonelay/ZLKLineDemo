//
//  MainViewCell.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
