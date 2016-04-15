//
//  CircumHospitalViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/8.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "CircumHospitalViewController.h"
#import "MyAnnotation.h"
#import "CircumHospitalTableViewCell.h"
#import "HospitalMapKitViewController.h"

#import "HospitalModel.h"

#import <AFNetworking.h>

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)

//周边医院url
#define URL @"http://apis.baidu.com/tngou/hospital/location"

@interface CircumHospitalViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property(nonatomic,strong)NSMutableArray * hospitalArray;/**<医院信息数组*/


@property (strong,nonatomic)CLLocationManager *locationManager;
@property (nonatomic,strong) CLGeocoder *geo;
@end

static NSString * const identify = @"hospitalcell";

@implementation CircumHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self positionCurrentCity];
}

#pragma mark -
#pragma mark 懒加载
-(NSMutableArray *)hospitalArray{
    if (!_hospitalArray) {
        _hospitalArray = [[NSMutableArray alloc] init];
    }
    return _hospitalArray;
}

#pragma mark -
#pragma mark 初始化UI
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.myTable registerNib:[UINib nibWithNibName:@"CircumHospitalTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    self.myTable.tableFooterView = [[UIView alloc] init];
}



#pragma mark -
#pragma mark 获取周边医院信息
-(void)getCircumHospitalInfo:(CLLocation*)location{
    __block CircumHospitalViewController * BlockSelf = self;
    //创建http会话管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSDictionary * paramet = @{@"x":@(location.coordinate.longitude),@"y":@(location.coordinate.latitude),@"page":@1,@"rows":@20};
    [manager.requestSerializer setValue:API_KEY forHTTPHeaderField:@"apikey"];
    [manager GET:URL parameters:paramet progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary * dict in [responseObject objectForKey:@"tngou"]) {
            HospitalModel * model = [[HospitalModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [BlockSelf.hospitalArray addObject:model];
        }
//        NSLog(@"%@",BlockSelf.hospitalArray);
        [BlockSelf.myTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark -
#pragma mark 定位
/** 定位当前城市 */
-(void)positionCurrentCity{
    //定位当前城市
    [UIApplication sharedApplication].idleTimerDisabled = TRUE;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100.0f;
    if (IS_IOS8) {
        [self.locationManager requestAlwaysAuthorization];//iOS8新增API，，始终允许访问位置信息
    }
    [self.locationManager startUpdatingLocation];
}

//定位代理
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *currLocation = [locations lastObject];
    [self getCircumHospitalInfo:currLocation];
    // 关闭定位
    [self.locationManager stopUpdatingLocation];
    // 根据经纬度 反向编码  获取详细地址
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error){
        for (CLPlacemark *place in placemarks) {
            self.navigationItem.title = [NSString stringWithFormat:@"%@-%@",place.locality,place.subLocality];
        }
    }];
    //停止定位
    [self.locationManager stopUpdatingLocation];
}


#pragma mark -
#pragma mark 表格代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hospitalArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CircumHospitalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HospitalModel * model = self.hospitalArray[indexPath.row];
    cell.index = indexPath.row+1;
    cell.userLocation = self.locationManager.location;
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HospitalMapKitViewController * mapView = [[HospitalMapKitViewController alloc] init];
    HospitalModel * model = self.hospitalArray[indexPath.row];
    CLLocation * otherLocation = [[CLLocation alloc] initWithLatitude:model.y longitude:model.x];
    mapView.userLocaton = self.locationManager.location;
    mapView.otherLocation = otherLocation;
    mapView.model = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapView animated:NO];
//    self.hidesBottomBarWhenPushed = NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

@end
