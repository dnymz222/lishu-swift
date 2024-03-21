//
//  LSLocationManagerCell.h
//  lishu
//
//  Created by xueping on 2021/5/29.
//

#import <UIKit/UIKit.h>
#import "LSLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSLocationManagerCell : UITableViewCell

- (void)configWithLocation:(LSLocation *)location ;

@end

NS_ASSUME_NONNULL_END
