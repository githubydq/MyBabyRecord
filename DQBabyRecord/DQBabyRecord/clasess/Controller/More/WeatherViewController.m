//
//  WeatherViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/12.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherView.h"

#import <CoreLocation/CoreLocation.h>

#import <AFNetworking.h>
#import <MJRefresh.h>

#import "DQRemindView.h"


#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define WEATHER_URL @"http://apis.baidu.com/heweather/weather/free"

@interface WeatherViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)UIScrollView * scroll;
@property(nonatomic,strong)WeatherView * wv;
@property(nonatomic,strong)NSMutableArray * HightArray;
@property(nonatomic,strong)NSMutableArray * LowArray;

@property(nonatomic,strong)CLLocationManager * locationmanager;
@property(nonatomic,copy)NSString * city;

@property(nonatomic,strong)DQRemindView * remind;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self positionCurrentCity];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 懒加载
-(NSMutableArray *)HightArray{
    if (!_HightArray) {
        _HightArray = [[NSMutableArray alloc] init];
    }
    return _HightArray;
}

-(NSMutableArray *)LowArray{
    if (!_LowArray) {
        _LowArray = [[NSMutableArray alloc] init];
    }
    return _LowArray;
}

-(NSString *)city{
    if (!_city) {
        _city = [[NSString alloc] init];
    }
    return _city;
}

#pragma mark -
#pragma mark 初始化UI
-(void)configUI{
    //天气温度视图
    _wv = [[WeatherView alloc] initWithFrame:CGRectMake(0, 0, 60*9, SCREEN_HEIGHT-64)];
    _wv.backgroundColor = BACK_COLOR;
    _wv.HightArray = self.HightArray;
    _wv.LowArray = self.LowArray;
    //滚动视图
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scroll.contentSize = CGSizeMake(60*9, SCREEN_HEIGHT);
    self.scroll.contentOffset = CGPointZero;
    self.scroll.bounces = NO;
    [self.scroll addSubview:_wv];
    [self.view addSubview:self.scroll];
    //导航栏
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(WeatherRightClick)];
}

-(void)WeatherRightClick{
    [self weatherBeginLoad];
    [self.HightArray removeAllObjects];
    [self.LowArray removeAllObjects];
    if (self.city.length > 0) {
        [self loadData:self.city];
    }else{
        [self positionCurrentCity];
    }
}

#pragma mark -
#pragma mark 加载数据
-(void)loadData:(NSString *)city{
    NSLog(@"22%@",city);
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //设置请求的格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //设置响应的格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置请求的header
    [manager.requestSerializer setValue:API_KEY forHTTPHeaderField:@"apikey"];
    NSDictionary * parame = @{@"city":[city substringToIndex:city.length-1]};
    [manager GET:WEATHER_URL parameters:parame progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"11%@",[[responseObject objectForKey:@"HeWeather data service 3.0"] firstObject][@"daily_forecast"]);
        NSArray * array = [[responseObject objectForKey:@"HeWeather data service 3.0"] firstObject][@"daily_forecast"];
        for (NSDictionary * dict in array) {
            NSLog(@"%@",dict[@"tmp"][@"max"]);
            [self.HightArray addObject:[NSNumber numberWithInteger:[dict[@"tmp"][@"max"] floatValue]]];
            [self.LowArray addObject:[NSNumber numberWithFloat:[dict[@"tmp"][@"min"] floatValue]]];
        }
        [_wv setNeedsDisplay];
        if (self.remind) {
            [self.remind removeFromSuperview];
            self.remind = nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self weatherfailedLoad];
    }];
    
}


#pragma mark -
#pragma mark 定位
/** 定位当前城市 */
-(void)positionCurrentCity{
    [self weatherBeginLoad];
    //定位当前城市
    [UIApplication sharedApplication].idleTimerDisabled = TRUE;
    self.locationmanager = [[CLLocationManager alloc] init];
    self.locationmanager.delegate = self;
    self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationmanager.distanceFilter = 100.0f;
    if (IS_IOS8) {
        [self.locationmanager requestAlwaysAuthorization];//iOS8新增API，，始终允许访问位置信息
    }
    [self.locationmanager startUpdatingLocation];
}

//定位代理
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *currLocation = [locations lastObject];
    // 关闭定位
    [self.locationmanager stopUpdatingLocation];
    // 根据经纬度 反向编码  获取详细地址
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error){
        for (CLPlacemark *place in placemarks) {
            self.navigationItem.title = [NSString stringWithFormat:@"%@-%@",place.locality,place.subLocality];
            self.city = place.locality;
            [self loadData:place.locality];
        }
    }];
    //停止定位
    [self.locationmanager stopUpdatingLocation];
}


#pragma mark -
#pragma mark 加载信息
-(void)weatherBeginLoad{
    //提醒
    if (!self.remind) {
        self.remind = [[NSBundle mainBundle] loadNibNamed:@"DQRemindView" owner:nil options:nil].lastObject;
        self.remind.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
        self.remind.title.text = @"信息加载中.....";
        [[UIApplication sharedApplication].keyWindow addSubview:self.remind];
        [self performSelector:@selector(weatherfailedLoad) withObject:nil afterDelay:10];
    }
}

-(void)weatherfailedLoad{
    if (self.remind) {
        self.remind.title.text = @"加载失败";
        [UIView animateWithDuration:1 animations:^{
            self.remind.alpha = 0.1;
        } completion:^(BOOL finished) {
            [self.remind removeFromSuperview];
            self.remind = nil;
        }];
    }
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
