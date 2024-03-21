//
//  LSMonthRiseSetCell.h
//  lishu
//
//  Created by xueping on 2021/9/21.
//

#import <UIKit/UIKit.h>

#import "LSRiseSetTime.h"
#import "LSDay.h"


NS_ASSUME_NONNULL_BEGIN

@interface LSMonthRiseSetCell : UITableViewCell

- (void)configRisetSetTime:(LSRiseSetTime *)risesetTime day:(LSDay *)day;

- (void)configPlanetRisetSetTime:(LSRiseSetTime *)risesetTime day:(LSDay *)day;

@end

NS_ASSUME_NONNULL_END
