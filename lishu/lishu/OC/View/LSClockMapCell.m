//
//  LSClockMapCell.m
//  lishu
//
//  Created by xueping on 2024/1/10.
//

#import "LSClockMapCell.h"
#import <Masonry/Masonry.h>

@implementation LSClockMapCell

- (LSTimeZoneMapView *) mapview {
    if(!_mapview){
        _mapview  = [[LSTimeZoneMapView alloc] init];
    }
    return  _mapview;
}

-(UIButton *)fullButton {
    if (!_fullButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        
        UIImage *image  =  [UIImage imageNamed:@"quanping"];
        [button setImage:image forState:UIControlStateNormal];
        
        _fullButton  = button;
    }
    return _fullButton;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if(self){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [self.contentView addSubview:self.mapview];
        [self.mapview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        [self.contentView addSubview:self.fullButton];
        
            [self.fullButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mapview.mas_top).offset(0);
                make.right.equalTo(self.mapview).offset(0);
                make.width.equalTo(@36);
                make.height.equalTo(@36);
            }];
            
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
