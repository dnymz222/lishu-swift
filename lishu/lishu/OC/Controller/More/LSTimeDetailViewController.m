//
//  LSTimeDetailViewController.m
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import "LSTimeDetailViewController.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"

@interface LSTimeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation LSTimeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
    
    
    LSDate *date = [[LSDate alloc] initWithDate:[NSDate date]];
    [self.location calcualteAstronomicalTime:date.JD];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  =[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate  =self;
        _tableView.dataSource = self;
 
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
        cell.textLabel.textColor = UIColorFromRGB(TextDarkColor);
        
        cell.detailTextLabel .textColor = UIColorFromRGB(TextNormalColor);
        
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text  = @"恒星时";
            cell.detailTextLabel .text = [NSString stringWithFormat:@"%02d:%02d",(int)self.location.apparentSiderealTime,(int)((int)(self.location.apparentSiderealTime*60)%60)];
            break;
            
        case 1:
            cell.textLabel.text  = @"太阳时";
            cell.detailTextLabel .text = [NSString stringWithFormat:@"%02d:%02d",(int)self.location.trueSolarTime,(int)((int)(self.location.trueSolarTime*60)%60)];
            break;
        case 2:
            cell.textLabel.text  = @"太阴时";
            cell.detailTextLabel .text = [NSString stringWithFormat:@"%02d:%02d",(int)self.location.lunarTime,(int)((int)(self.location.lunarTime*60)%60)];
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
