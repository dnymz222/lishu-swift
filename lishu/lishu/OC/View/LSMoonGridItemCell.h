//
//  LSMoonGridItemCell.h
//  lishu
//
//  Created by xueping on 2021/9/20.
//

#import <UIKit/UIKit.h>
#import "LSDay.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSMoonGridItemCell : UICollectionViewCell

- (void)configNull;

- (void)configMonth:(NSInteger)month;

- (void)configDay:(NSInteger)day;

- (void)configPhase:(nullable LSDay *)phaseDay;

@end

NS_ASSUME_NONNULL_END
