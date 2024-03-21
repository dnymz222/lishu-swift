//
//  LSEraCell.m
//  lishu
//
//  Created by xueping on 2021/10/15.
//

#import "LSEraCell.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"


@interface LSEraCell ()

@property(nonatomic,strong)UILabel *yearLabel;
@property(nonatomic,strong)UILabel *startDateLabel;
@property(nonatomic,strong)UILabel *endDateLabel;

@property(nonatomic,strong)UILabel *startCalendarLabel;
@property(nonatomic,strong)UILabel *endCalendarLabel;

//@property(nonatomic,strong)UILabel *nameLabel;
//@property(nonatomic,strong)UILabel *signLabel;



@end

@implementation LSEraCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self.contentView addSubview:self.yearLabel];
        [self.contentView addSubview:self.startDateLabel];
        [self.contentView addSubview:self.endDateLabel];
        [self.contentView addSubview:self.startCalendarLabel];
        [self.contentView addSubview:self.endCalendarLabel];
//        [self.contentView addSubview:self.nameLabel];
//        [self.contentView addSubview:self.signLabel];
        self.contentView.backgroundColor = UIColorFromRGB(cellbackGroundColor);
        self.backgroundColor = UIColorFromRGB(cellbackGroundColor   );
        
        [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(5);
            make.height.equalTo(@20);
            make.width.equalTo(@80);
        }];
        
        
        
        [self.startDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.yearLabel.mas_bottom).offset(5);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
        }];
        [self.startCalendarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-13);
            make.left.equalTo(self.startDateLabel.mas_right).offset(13);
            make.top.equalTo(self.yearLabel.mas_bottom).offset(5);
            make.height.equalTo(@16);
            
        }];
        
        
        [self.endDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.startDateLabel.mas_bottom).offset(5);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
        }];
        [self.endCalendarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-13);
            make.left.equalTo(self.endDateLabel.mas_right).offset(13);
            make.top.equalTo(self.startCalendarLabel.mas_bottom).offset(5);
            make.height.equalTo(@16);
            
        }];
        
        
        
        
//        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.yearLabel.mas_right).offset(30);
//            make.top.bottom.equalTo(self.contentView);
//            make.width.greaterThanOrEqualTo(@100);
//        }];
//
//        [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView).offset(-10);
//            make.top.bottom.equalTo(self.contentView);
//            make.left.equalTo(self.nameLabel.mas_right).offset(10);
//        }];
        
    }
    return self;
}

- (UILabel *)yearLabel {
    if (!_yearLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:16.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _yearLabel = label;
    }
    return _yearLabel;
}

- (UILabel *)startDateLabel {
    if (!_startDateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _startDateLabel = label;
    }
    return _startDateLabel;
}

- (UILabel *)endDateLabel {
    if (!_endDateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _endDateLabel = label;
    }
    return _endDateLabel;
}

- (UILabel *)startCalendarLabel {
    if (!_startCalendarLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _startCalendarLabel= label;
    }
    return _startCalendarLabel;
}

- (UILabel *)endCalendarLabel {
    if (!_endCalendarLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _endCalendarLabel    = label;
    }
    return _endCalendarLabel;
}





//- (UILabel *)nameLabel {
//    if (!_nameLabel) {
//        UILabel *label = [[UILabel alloc] init];
//        label.textAlignment = NSTextAlignmentLeft;
//        label.font = [UIFont systemFontOfSize:15.f];
//        label.textColor  = UIColorFromRGB(TextFadeColor);
//        _nameLabel = label;
//    }
//    return _nameLabel;
//}
//
//- (UILabel *)signLabel {
//    if (!_signLabel) {
//        UILabel *label = [[UILabel alloc] init];
//        label.textAlignment = NSTextAlignmentLeft;
//        label.font = [UIFont systemFontOfSize:15.f];
//        label.textColor  = UIColorFromRGB(TextDarkColor);
//        _signLabel = label;
//    }
//    return _signLabel;
//}


- (void)configEraItemModel:(LSEra *)itemModel {
    self.yearLabel.text = [NSString stringWithFormat:@"%ld",itemModel.year];
    
    self.startDateLabel.text =[NSString stringWithFormat:@"%d-%02d-%02d",itemModel.startDate.localYear,itemModel.startDate.localMonth,itemModel.startDate.localDay];
    
    self.endDateLabel.text =[NSString stringWithFormat:@"%d-%02d-%02d",itemModel.endDate.localYear,itemModel.endDate.localMonth,itemModel.endDate.localDay];
    
    self.startCalendarLabel.text = itemModel.startCalendar.fullString;
    self.endCalendarLabel.text = itemModel.endCalendar.fullString;
    
//    self.nameLabel.text = itemModel.yearname;
//    
//    if (itemModel.signname) {
//        self.signLabel.text = itemModel.signname;
//    } else {
//        self.signLabel.text  =@"";
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
