//
//  LSCalendarFooterView.h
//  lishu
//
//  Created by xueping on 2021/11/10.
//

#import <UIKit/UIKit.h>
#import "LSDay.h"
#import "LSWorkingdayModel.h"



NS_ASSUME_NONNULL_BEGIN

@interface LSCalendarFooterView : UICollectionReusableView

- (void)configDay:(LSDay *)day  calendarIndex:(int)calendarIndex workingDayModel:(LSWorkingdayModel *)daymodel;

@end

NS_ASSUME_NONNULL_END
