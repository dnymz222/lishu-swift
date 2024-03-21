//
//  LSSoulnarView.h
//  lishu
//
//  Created by xueping on 2021/4/4.
//

#import <UIKit/UIKit.h>
#import "LSAstroPostion.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSSoulnarView : UIView


- (void)configSolunarWithSunPosition:(LSAstroPostion *)sunPosition moonPosition:(LSAstroPostion *)moonPostion;





@end

NS_ASSUME_NONNULL_END
