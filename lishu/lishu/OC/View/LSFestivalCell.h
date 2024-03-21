//
//  LSFestivalCell.h
//  lishu
//
//  Created by xueping on 2021/11/7.
//

#import <UIKit/UIKit.h>
#import "LSFestival.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSFestivalCell : UITableViewCell

- (void)configFestivalItem:(id<LSFetivalItem>)festival;

@end

NS_ASSUME_NONNULL_END
