//
//  LSDayWeatherCell.h
//  lishu
//
//  Created by xueping on 2021/4/2.
//

#import <UIKit/UIKit.h>
#import "LSAccuDayWeatherModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSDayWeatherCell : UITableViewCell


- (void)configModel:(LSAccuDayWeatherModel *)daymodel is_mertric:(BOOL)is_mertric;

@end

NS_ASSUME_NONNULL_END
