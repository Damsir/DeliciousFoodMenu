//
//  SearchViewController.m
//  食客天下
//
//  Created by qianfeng on 15/12/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>
@property (nonatomic,assign)CGFloat lastFloat;
@property (nonatomic,assign)CGFloat contentWidth;
@property (nonatomic,assign)CGFloat contentHight;
@property (nonatomic,strong)UISearchBar *search;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
  _search=[[UISearchBar alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-50)/2, 7, 50, 30)];
    _search.delegate=self;
    self.navigationItem.titleView=_search;
    _search.showsCancelButton=YES;
//    _search.showsBookmarkButton=YES;
    _search.searchBarStyle= UIBarStyleBlackOpaque;
    _search.returnKeyType = UIReturnKeySearch;
//    _search.showsSearchResultsButton=YES;
    _lastFloat=0;
    _contentWidth=0;
    _contentHight=0;
    self.view.backgroundColor=[UIColor whiteColor];
    NSArray *array=@[@"充电宝",@"Eco Store",@"保健",@"sagaform",@"收纳",@"梳",@"生酵素",@"有机",@"餐盘"];
    for (int i=0 ; i<array.count; i++) {
        _lastFloat+=10;
        NSString *str=array[i];
        CGRect bound=[str boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:20]} context:nil];
        _contentWidth=bound.size.width+10;
        if (_lastFloat+_contentWidth>SCREEN_WIDTH-10) {
            _lastFloat=10;
            _contentHight+=1;
        }
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame=CGRectMake(_lastFloat, 64+10+40*_contentHight,_contentWidth , 30);
        _lastFloat+=_contentWidth;
        btn.layer.borderWidth=1.0;
        btn.layer.borderColor=[[UIColor blackColor]CGColor];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:20];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
   
}
-(void)btnClick:(UIButton *)btn
{
    _search.text=btn.titleLabel.text;
    SearchDetailViewController *sc=[[SearchDetailViewController alloc] init];
    [self.navigationController pushViewController:sc animated:YES];
    sc.tabBarController.tabBar.hidden=YES;
    
    sc.searchText=_search.text;
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;
{
    _search.text=nil;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    SearchDetailViewController *sc=[[SearchDetailViewController alloc] init];
    [self.navigationController pushViewController:sc animated:YES];
    sc.tabBarController.tabBar.hidden=YES;
    
    sc.searchText=_search.text;
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
