//
//  SettingTableViewCell.h
//  Hera
//
//  Created by Andreas Lordos on 7/29/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *settingName;
- (void)setName:(NSString*)name;
@end

NS_ASSUME_NONNULL_END
