//
//  HospitalMapKitViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/9.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "HospitalMapKitViewController.h"

#import <MapKit/MapKit.h>

@interface HospitalMapKitViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property(nonatomic,strong)CLLocationManager * lmanager;/**<位置管理*/
@end

@implementation HospitalMapKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self initOtherLocation];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

#pragma mark -
#pragma mark 懒加载
-(CLLocationManager *)lmanager{
    if (!_lmanager) {
        _lmanager = [[CLLocationManager alloc] init];
        if ([_lmanager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [_lmanager requestAlwaysAuthorization];
        }
    }
    return _lmanager;
}

#pragma mark -
#pragma mark 初始化Map
-(void)initMap{
    //显示用户位置
    self.myMapView.showsUserLocation = YES;
    
    
}

-(void)initOtherLocation{
    MKPointAnnotation *annotation0 = [[MKPointAnnotation alloc] init];
    [annotation0 setCoordinate:self.otherLocation.coordinate];
    [annotation0 setTitle:@"重庆理工大学"];
    [annotation0 setSubtitle:@"重庆市巴南区红光大道69号"];
    [self.myMapView addAnnotation:annotation0];
}

#pragma mark -
#pragma mark 用户位置代理
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    /**
     *  MKUserLocation (大头针模型)
     */
    userLocation.title = @"重庆";
    userLocation.subtitle = @"西永软件园";
    // 设置地图显示中心
    [self.myMapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    // 设置地图显示区域
    MKCoordinateSpan span = MKCoordinateSpanMake(0.051109, 0.034153);
    //设置显示位置
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [self.myMapView setRegion:region animated:YES];
    
}

#pragma mark -
#pragma mark 点击事件
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
