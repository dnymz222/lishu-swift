//
//  LSLocationAddFooter.h
//  lishu
//
//  Created by xueping on 2021/4/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN\


@protocol LSLocationAddFooterDelegate <NSObject>

- (void)locationAddFooterViewClick:(UIView*)view;

@end

@interface LSLocationAddFooter : UITableViewHeaderFooterView

@property(nonatomic,weak)id <LSLocationAddFooterDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
