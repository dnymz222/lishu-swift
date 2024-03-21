//
//  LSCalendarFooterView.m
//  lishu
//
//  Created by xueping on 2021/11/10.
//

#import "LSCalendarFooterView.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"


@interface LSCalendarFooterView ()

@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *calendarLabel;
@property(nonatomic,strong)UILabel *workingdaysLabel;


@end

@implementation LSCalendarFooterView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.dateLabel];
        [self addSubview:self.calendarLabel];
        [self addSubview:self.workingdaysLabel];
        [self.dateLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(5);
            make.height.equalTo(@20);
        }];
        

        
        [self.calendarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
            make.height.greaterThanOrEqualTo(@0);
        }];
        [self.workingdaysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.calendarLabel.mas_bottom).offset(5);
            make.height.greaterThanOrEqualTo(@0);
        }];
        
    }
    return self;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _dateLabel = label;
    }
    return _dateLabel;
}


- (UILabel *)calendarLabel {
    if (!_calendarLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.numberOfLines = 0;
        _calendarLabel = label;
    }
    return _calendarLabel;
}

- (UILabel *)workingdaysLabel {
    if (!_workingdaysLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.numberOfLines= 0;
        _workingdaysLabel = label;
    }
    return _workingdaysLabel;
}


- (void)configDay:(LSDay *)day calendarIndex:(int)calendarIndex workingDayModel:(LSWorkingdayModel *)daymodel {
    
    if (day) {
        self.dateLabel.text = [NSString stringWithFormat:@"%d-%02d-%02d",day.lsdate.localYear,day.lsdate.localMonth,day.lsdate.localDay];
        LSCalendarTypeModel *model  = day.clanedarArray[calendarIndex];
        NSString *calendarString= model.fullString;
        if (model.isFestival) {
            calendarString = [calendarString stringByAppendingFormat:@"\n%@", model.festivalString];
            if (LSCalendarTypeZangli == model.type) {
                if (model.zangli && model.zangli.extraInfo2.length > 0) {
                    calendarString= [calendarString stringByAppendingString:[NSString stringWithFormat:@"\n%@",model.zangli.extraInfo2]];
                }
            }
            
        }
        self.calendarLabel.text  = calendarString;
        
        
    } else {
        self.dateLabel .text  =@"";
        self.calendarLabel.text = @"";
    }
    
    if (daymodel) {
        self.workingdaysLabel.text  =[[NSBundle mainBundle] localizedStringForKey:daymodel.public_holiday_description value:@"" table:@"lish"];
    } else {
        self.workingdaysLabel.text  =@"";
    }
    
    
    
}



@end
