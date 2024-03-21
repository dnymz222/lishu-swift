//
//  LSWorldClockCell.h
//  lishu
//
//  Created by xueping on 2021/3/2.
//

#import <UIKit/UIKit.h>
#import "LSLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSWorldClockCell : UITableViewCell

-(void)configLocation:(LSLocation *)location isMetric:(BOOL)ismertric;

@end

NS_ASSUME_NONNULL_END
