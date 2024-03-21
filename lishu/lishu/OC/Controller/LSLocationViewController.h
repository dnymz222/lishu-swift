//
//  LSLocationViewController.h
//  lishu
//
//  Created by xueping on 2021/3/16.
//

#import <UIKit/UIKit.h>
#import "LSLocation.h"

NS_ASSUME_NONNULL_BEGIN


@protocol LSLocationViewControllerDelegate <NSObject>

- (void)lslocationViewControllerSelectLocation:(LSLocation *)location;

@end


@interface LSLocationViewController : UIViewController


@property(nonatomic,weak)id <LSLocationViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
