//
//  LSHourWeatherItemView.h
//  lishu
//
//  Created by xueping on 2021/4/2.
//

#import <UIKit/UIKit.h>
#import "LSAccuWeatherHourModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface LSHourWeatherItemView : UICollectionViewCell


- (void)configModel:(LSAccuWeatherHourModel *)model isMertric:(BOOL)ismertric;



@end

NS_ASSUME_NONNULL_END
