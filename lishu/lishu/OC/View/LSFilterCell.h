//
//  LSFilterCell.h
//  lishu
//
//  Created by xueping on 2021/10/13.
//

#import <UIKit/UIKit.h>
#import "LSWorkingDayConfig.h"
#import "LSCalendarTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LSFilterCellDelegate <NSObject>

@optional

- (void)filtercellButtonClick:(UIButton *)button config:(LSWorkingDayConfig *)config;

- (void)filtercellButtonClick:(UIButton *)button calendar:(LSCalendarTypeModel *)calendar;

@end

@interface LSFilterCell : UITableViewCell

- (void)configWorkingDay:(LSWorkingDayConfig *)config ;

- (void)configCalendarType:(LSCalendarTypeModel*)calendar ;

@property(nonatomic,weak)id <LSFilterCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
