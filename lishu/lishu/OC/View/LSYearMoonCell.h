//
//  LSYearMoonCell.h
//  lishu
//
//  Created by xueping on 2021/12/7.
//

#import <UIKit/UIKit.h>
#import "LSLunarTermModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSYearMoonCell : UITableViewCell

- (void)configIndex:(NSInteger)index lunarTerm:(LSLunarTermModel *)lunarTerm;

@end

NS_ASSUME_NONNULL_END
