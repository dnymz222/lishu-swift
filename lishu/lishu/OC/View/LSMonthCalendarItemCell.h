//
//  LSMonthCalendarItemCell.h
//  lishu
//
//  Created by xueping on 2021/5/30.
//

#import <UIKit/UIKit.h>
#import "LSDay.h"
#import "LSWorkingdayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSMonthCalendarItemCell : UICollectionViewCell

//-(void)configLsday:(nullable LSDay *)day;

- (void)configLsday:(LSDay *)day calendar:(NSInteger)calendarIndex ;


- (void)configWorkingDayModel:(LSWorkingdayModel *)workingDayModel  ;


@end

NS_ASSUME_NONNULL_END
