//
//  LSFilterHeaderView.h
//  lishu
//
//  Created by xueping on 2021/10/15.
//

#import <UIKit/UIKit.h>
#import "LSWorkingDayConfig.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LSFilterHeaderViewDelegate <NSObject>

- (void)filterHeaderViewButtonClick:(UIButton *)button buttonIndex:(NSInteger)buttonIndex config:(LSWorkingDayConfig *)config;

@end

@interface LSFilterHeaderView : UITableViewHeaderFooterView

- (void)configWorkingDay:(LSWorkingDayConfig *)config;

@property(nonatomic,weak)id <LSFilterHeaderViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
