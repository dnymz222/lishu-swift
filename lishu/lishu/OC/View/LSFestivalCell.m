//
//  LSFestivalCell.m
//  lishu
//
//  Created by xueping on 2021/11/7.
//

#import "LSFestivalCell.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"
#import "LSCalendarTypeModel.h"


@interface LSFestivalCell  ()


@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *calendarLabel;
@property(nonatomic,strong)UILabel *nameLabel;

@end

@implementation LSFestivalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self  =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor =  UIColorFromRGB(cellbackGroundColor);
        
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.calendarLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.dateLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.width.equalTo(@100);
            make.top.equalTo(self.contentView).offset(10);
            make.height.equalTo(@20);
       
        }];
        
        [self.calendarLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dateLabel.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView).offset(3);
            make.height.equalTo(@34);
        
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.dateLabel.mas_bottom).offset(9);
            make.height.equalTo(@36);
            
        }];
        
        
    }
    return self;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:16.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _dateLabel = label;
    }
    return _dateLabel;
}


- (UILabel *)calendarLabel {
    if (!_calendarLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.numberOfLines = 0;
        _calendarLabel = label;
    }
    return _calendarLabel;
}


- (UILabel *)nameLabel  {
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.numberOfLines = 0;
        _nameLabel = label;
    }
    return _nameLabel;
}



- (void)configFestivalItem:(id<LSFetivalItem>)festival {
    
    self.dateLabel.text = [NSString stringWithFormat:@"%ld-%02d-%02d",festival.lsdate.localYear,festival.lsdate.localMonth,festival.lsdate.localDay];
    
    
    self.nameLabel.text = festival.name;
    
    switch (festival.calendarModel.type) {
        case LSCalendarTypeChristianHolidays:
            self.calendarLabel.text = @"";
            break;
        case LSCalendarTypeWorldDay:
            self.calendarLabel.text  =@"";
            
            break;
        case LSCalendarTypeOrthodoxHolidays:
            self.calendarLabel.text = [NSString stringWithFormat:@"%@:%@",NSLocalizedStringFromTable(@"calendar_julian",@"lish" ,nil) ,festival.calendarModel.fullString];
            break;
            
        case LSCalendarTypeChinese:
            
        case LSCalendarTypeHebrew:
            
        case LSCalendarTypeIslamic:
            self.calendarLabel.text = [NSString stringWithFormat:@"%@:%@",festival.calendarModel.name,festival.calendarModel.fullString];
            
            break;
            
        default:
            self.calendarLabel.text = @"";
            break;
    }
    
    self.nameLabel.text = festival.name;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
