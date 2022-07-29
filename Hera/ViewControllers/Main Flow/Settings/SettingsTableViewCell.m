//
//  SettingsTableViewCell.m
//  Hera
//
//  Created by Andreas Lordos on 7/28/22.
//

#import "SettingsTableViewCell.h"

@implementation SettingsTableViewCell

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
