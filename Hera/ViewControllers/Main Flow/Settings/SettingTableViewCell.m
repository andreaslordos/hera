//
//  SettingTableViewCell.m
//  Hera
//
//  Created by Andreas Lordos on 7/29/22.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString*)name {
    self.settingName.text = name;
}

@end
