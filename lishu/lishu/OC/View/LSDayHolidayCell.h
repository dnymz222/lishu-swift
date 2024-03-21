//
//  LSDayHolidayCell.h
//  lishu
//
//  Created by xueping on 2021/5/15.
//

#import <UIKit/UIKit.h>

#import "LSWorkingdayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSDayHolidayCell : UITableViewCell


- (void)configWorkingDayFromDay:(LSWorkingdayModel *)workingday;

- (void)configWorkingDayFromYear:(LSWorkingdayModel *)workingday;

@end

NS_ASSUME_NONNULL_END
