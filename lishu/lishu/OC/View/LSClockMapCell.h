//
//  LSClockMapCell.h
//  lishu
//
//  Created by xueping on 2024/1/10.
//

#import <UIKit/UIKit.h>
#import "LSTimeZoneMapView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSClockMapCell : UITableViewCell

@property(nonatomic,strong)LSTimeZoneMapView * mapview;

@property(nonatomic,strong)UIButton *fullButton;

@end

NS_ASSUME_NONNULL_END
