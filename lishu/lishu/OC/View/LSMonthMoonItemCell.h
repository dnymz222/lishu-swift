//
//  MLMonthMoonItemCell.h
//  lishu
//
//  Created by xueping on 2021/5/19.
//

#import <UIKit/UIKit.h>
#import "LSMonth.h"
#import "LSLunarTermItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSMonthMoonItemCell : UICollectionViewCell

- (void)configLunarItemModel:(LSLunarTermItemModel *)lunarItem month:(LSMonth *)month;




@end

NS_ASSUME_NONNULL_END
