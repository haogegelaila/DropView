//
//  PopupTableViewCell.m
//  GreenLand
//
//  Created by 浩哥哥 on 2017/3/22.
//  Copyright © 2017年 chy. All rights reserved.
//

#import "PopupTableViewCell.h"

@implementation PopupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
