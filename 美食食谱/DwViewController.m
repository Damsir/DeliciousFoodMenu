//
//  DwViewController.m
//  食客天下
//
//  Created by qianfeng on 15/12/7.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "DwViewController.h"

@interface DwViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong)MKMapView *map;
@property (nonatomic,strong)CLLocationManager *locationManager;

@property (nonatomic,strong)CLGeocoder *geocoder;
@end

@implementation DwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _map=[[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _map.mapType=MKMapTypeStandard;
    [_map setRotateEnabled:NO];
    [self.view addSubview:_map];
    _map.delegate=self;
   
    [self location];
    
    
}

-(void)location
{
   
    NSLog(@"vvvvvvvvvvvvvvvvvvvvv");
    if([CLLocationManager locationServicesEnabled]){
        
        // 创建一个定位的管理类
        self.locationManager=[[CLLocationManager alloc]init];
        
        // 验证提示用户是否开启定位功能
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
        // 开始刷新定位功能
        [self.locationManager startUpdatingLocation];
        
      self.locationManager.distanceFilter=100.0;
    }
    _locationManager.delegate=self;

}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    

   _map.showsUserLocation=YES;
    CLLocation *location=locations.firstObject;
    NSLog(@"经纬度＝＝＝＝＝:%f,%f",location.coordinate.latitude,location.coordinate.longitude);
    //    跨度:地图的缩放成度,也可以理解为当前地图View frame 能显示的地图大小
    CLLocationCoordinate2D  location1=CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    MKCoordinateRegion region=  MKCoordinateRegionMake(location1, MKCoordinateSpanMake(0.5, 0.5));
    // 把跨度添加到地图上去
    [_map setRegion:region];

    //把响应的地图经纬度转成地址
    //初始化一个地图经纬度转码器
    self.geocoder=[[CLGeocoder alloc]init];
    //转码经纬度为地址
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *  placemarks, NSError * error) {
        //转码后地址对像
        CLPlacemark *placeMark=placemarks.firstObject;
        NSLog(@"%@,%@",placeMark.name,placeMark.locality);
        NSString *str=placeMark.locality;
        [str writeToFile:[NSString stringWithFormat:@"%@/Documents/string.plist",NSHomeDirectory()] atomically:YES encoding:NSUTF8StringEncoding error:nil];
       
      
 
       
        
        
    }];
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *iden=@"1507";
    MKPinAnnotationView *view=(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:iden];
    // 如果没有取到,就自己创建一个
    if(!view)
    {
        //创建一个大头针的View
        view=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:iden];
        // 点击是否会显示详细信息
        //        [view setCanShowCallout:NO];
        // 设置大头针是否可以点击
        //        [view setEnabled:NO];
        // 大头针 是否有下落动画
        [view setAnimatesDrop:YES];
        // 设置大头针颜色
        //        MKPinAnnotationColorRed = 0,
        //        MKPinAnnotationColorGreen,
        //        MKPinAnnotationColorPurple
        [view setPinColor:MKPinAnnotationColorPurple];
        
    }
    return view;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
