//
//  LSYearMoonViewController.m
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import "LSYearMoonViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSMoonGridItemCell.h"
#import "LSYearMoonCell.h"

@interface LSYearMoonViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,assign)CGFloat screenwidth;

@property(nonatomic,strong)LSYear *lsyear;

@property(nonatomic,strong)UITableView *tableView;



@end

@implementation LSYearMoonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
    self.screenwidth     = [UIScreen mainScreen].bounds.size.width;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    // Do any additional setup after loading the view.
}

- (void)configYear:(LSYear *)year {
    
    
//    for (LSMonth *month in year.monthArray) {
//        for (LSDay *day in month.daysArray) {
//            [day calulateSolunar];
//        }
//    }
    
    [year calculateLunarTerm];
    
    
   
    self.lsyear = year;
    
//    [self.collectionView reloadData];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1), dispatch_get_main_queue(), ^{
//        [self saveImage];
//    });
    
    [self.tableView reloadData];
    
    
}

//- (UICollectionView *)collectionView {
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
//        _collectionView.dataSource = self;
//        _collectionView.delegate = self;
//        _collectionView.backgroundColor = UIColorFromRGB(0X222222);
//        [_collectionView registerClass:[LSMoonGridItemCell class] forCellWithReuseIdentifier:@"cell"];
//
//
//    }
//
//    return _collectionView;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSInteger count =   self.lsyear? 13*32:0;
//
//    return count;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 1;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 1;
//}
//
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//
//
//    return CGSizeMake((self.screenwidth  -12)/13.f,(self.screenwidth  -12)/13.f );
//
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeZero;
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeZero;
//}



//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    LSMoonGridItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//
//    NSInteger row = indexPath.row/13;
//    NSInteger col = indexPath.row%13;
//    if (row ==0 && col == 0) {
//        [cell configNull];
//    } else if (0 == row){
//
//        [cell configMonth:indexPath.row];
//    } else if (0 == col){
//        [cell configDay:indexPath.row/13];
//    } else {
//        LSMonth *month = self.lsyear.monthArray[col-1];
//        if (row-1 < month.days) {
//            LSDay *day = month.daysArray[row-1];
//            [cell configPhase:day];
//        } else {
//            [cell configNull];
//        }
//
//    }
//
//
//
//    return cell;
//}




//- (void)saveImage
//{
//
//
//    UIGraphicsBeginImageContext(_collectionView.frame.size);
//    [_collectionView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
//
//
//
//    UIGraphicsEndImageContext();
//
//
//
//
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//
//
//    NSString *imagename = @"moon_grid.png";
//
//    path = [path stringByAppendingPathComponent:imagename];
//
//    NSLog(@"imagename:%@",path);
//
//    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
//
//
//
//
//}




//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//
//
//
//        return CGSizeMake(self.screenwidth, 30);
//
//
//
//}



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
        
    }
    
    return _tableView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.lsyear.lunarItermArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSYearMoonCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[LSYearMoonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    LSLunarTermModel *termmodel = self.lsyear.lunarItermArray[indexPath.row];
    [cell configIndex:indexPath.row+1 lunarTerm:termmodel];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
