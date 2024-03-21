//
//  LSDatePickerView.h
//  lishu
//
//  Created by xueping on 2021/12/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LSDatePickerViewDelegate <NSObject>

- (void)datePickerViewSelectDate:(NSDate *)date;

@end

@interface LSDatePickerView : UIView

@property(nonatomic,weak)id <LSDatePickerViewDelegate>delegate;

+ (void)showInView:(UIView *)view delegate:(id<LSDatePickerViewDelegate>) delegate date:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
