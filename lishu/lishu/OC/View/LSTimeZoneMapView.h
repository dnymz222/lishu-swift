//
//  LSTimeZoneMapView.h
//  lishu
//
//  Created by xueping on 2021/3/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSTimeZoneMapView : UIView


- (void)configLocationArray:(NSArray *)locations scale:(double)scale fix:(int)fix ;

- (void)configTwilightLocationArray:(NSArray *)locations scale:(double)scale fix:(int)fix ;

@end

NS_ASSUME_NONNULL_END
