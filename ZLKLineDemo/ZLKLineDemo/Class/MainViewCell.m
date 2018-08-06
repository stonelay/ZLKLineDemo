//
//  MainViewCell.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "MainViewCell.h"
#import "UIImage+ZLEX.h"
#import "ZLPreMacro.h"


@implementation MainViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"SDEleSignatureCell";
    
    MainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[MainViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:[UIColor whiteColor]]];
        
        cell.textLabel.textColor = ZLRGB(39, 39, 39);
        cell.textLabel.font = [UIFont systemFontOfSize:28 * SCALE];
    }
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    
    return self;
}



#pragma mark - 设置数据
- (void)setItem:(NSDictionary *)item{
    
    self.textLabel.text = item[@"title"];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
