//
//  LSDayHeaderView.h
//  lishu
//
//  Created by xueping on 2021/5/16.
//

#import <UIKit/UIKit.h>
#import "LSAstroSectionModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol LSDayHeaderViewDelegate <NSObject>

- (void)lsDayheaderFilterButtonClickSection:(NSInteger)section;

@end

@interface LSDayHeaderView : UITableViewHeaderFooterView

@property(nonatomic,weak)id <LSDayHeaderViewDelegate>delegate;

@property(nonatomic,strong,readonly)UIButton *filterButton;

@property(nonatomic,strong,readonly)UILabel *titleLabel;


- (void)configAstroSection:(LSAstroSectionModel *)section;
@end

NS_ASSUME_NONNULL_END
