//
//  LSMonthMoonViewController.m
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import "LSMonthMoonViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSMonthMoonHeaderView.h"
#import "LSMonthMoonItemCell.h"
#import "LSMonthMoonCell.h"


@interface LSMonthMoonViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,assign)CGFloat screenwidth;


@property(nonatomic,strong)LSMonth *selectMonth;

@end

@implementation LSMonthMoonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  UIColorFromRGB(ViewBackGroundColor);
    
    self.screenwidth  = [UIScreen   mainScreen].bounds.size.width;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = UIColorFromRGB(cellbackGroundColor);
        [_collectionView registerClass:[LSMonthMoonItemCell class] forCellWithReuseIdentifier:@"cell"];
        
        
    }
    
    return _collectionView;
}

- (void)configMonth:(LSMonth *)month location:(LSLocation *)location {
    
    
    for (LSDay *day in month.daysArray) {
        [day calulateMoonWithLocation:location.GeoPosition];
        [day calulateSolunar];
    }
    
    [month caculateLunarTermodel];
    
    
    
    self.selectMonth =  month;
    
    [self.tableView reloadData];
    
    [self.collectionView reloadData];
  
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.selectMonth) {
        return self.selectMonth.lunarTermModel.lunarArray.count;
    } else {
        return 0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return CGSizeMake((self.screenwidth  -4)/5,100 );
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeZero;
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeZero;
//}



- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LSMonthMoonItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.selectMonth) {
        LSLunarTermItemModel *itemModel =  self.selectMonth.lunarTermModel.lunarArray[indexPath.row];
        [cell configLunarItemModel:itemModel month:self.selectMonth];
    }
    

    return cell;
}







- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.backgroundColor  = UIColorFromRGB(ViewBackGroundColor);
        _tableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorInset  = UIEdgeInsetsZero;
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = UIColorFromRGB(0xeeeeee);
        _tableView.delegate  = self;
        _tableView.dataSource  = self;
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        
    }
    
    return _tableView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.selectMonth) {
        return self.selectMonth.daysArray.count;
    } else {
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSMonthMoonCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[LSMonthMoonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if (self.selectMonth) {
        LSDay *day = self.selectMonth.daysArray[indexPath.row];
        [cell configDay:day];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LSMonthMoonHeaderView *moonheaderView =  [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (moonheaderView == nil) {
        moonheaderView = [[LSMonthMoonHeaderView alloc] initWithReuseIdentifier:@"header"];
    }
    return moonheaderView;
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
