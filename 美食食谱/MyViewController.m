//
//  MyViewController.m
//  食客天下
//
//  Created by qianfeng on 15/11/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyViewController.h"
#define IOS8 [[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTabView;
@property (nonatomic,strong)UILabel *contentMode;
@property (nonatomic,strong)UIImageView *imagev;
@property (nonatomic,strong)UIImagePickerController *PickerC;
@property (nonatomic,strong)UIImageView *messageDetail;
@property (nonatomic,strong)UIImageView *touchMe;
@property (nonatomic,strong)UIImageView *remove;
@property (nonatomic,strong)UILabel *deleteYou;
@property (nonatomic,strong)TCUSViewController *tcc;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSHomeDirectory());
    // Do any additional setup after loading the view.
    _myTabView.delegate=self;
    _myTabView.dataSource=self;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.054 green:0.606 blue:1.000 alpha:1.000];
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT-300)];
//    view.backgroundColor=[UIColor orangeColor];
    _myTabView.tableFooterView=[[UIView alloc] init];
    NSLog(@"%@",NSHomeDirectory());
    [self folderSizeAtPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]];
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        //用户图片
        _imagev=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        _imagev.userInteractionEnabled=YES;
        _imagev.image=[UIImage imageNamed:@"ic_mine_normal"];
        [cell.contentView addSubview:_imagev];
        UITapGestureRecognizer *tapone=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageChage:)];
        [_imagev addGestureRecognizer:tapone];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        //显示当前状态：
        _contentMode=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.frame)-200, 10, 200, 40)];
        _contentMode.text=@"请点击登陆";
        _contentMode.font=[UIFont systemFontOfSize:18];
        cell.userInteractionEnabled=YES;
        _contentMode.userInteractionEnabled=YES;
        _contentMode.textColor=[UIColor redColor];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentModeTap:)];
        [_contentMode addGestureRecognizer:tap];
        [cell.contentView addSubview:_contentMode];
        return cell;
       
    }
    else if(indexPath.section==1)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _messageDetail=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        _messageDetail.userInteractionEnabled=YES;
        _messageDetail.image=[UIImage imageNamed:@"icon_feedback"];
        [cell.contentView addSubview:_messageDetail];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        //显示当前状态：
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.frame)-200, 10, 200, 40)];
        lab.text=@"意见反馈";
        lab.font=[UIFont systemFontOfSize:18];
        cell.userInteractionEnabled=YES;
        lab.userInteractionEnabled=YES;
        lab.textColor=[UIColor redColor];
        [cell.contentView addSubview:lab];
        return cell;
    }
    if (indexPath.section==2) {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _touchMe=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40,40)];
        _touchMe.userInteractionEnabled=YES;
        _touchMe.image=[UIImage imageNamed:@"icon_contact_us"];
        [cell.contentView addSubview:_touchMe];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        //显示当前状态：
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.frame)-200, 10, 200, 40)];
        lab.text=@"联系我们";
        lab.font=[UIFont systemFontOfSize:18];
        cell.userInteractionEnabled=YES;
        lab.userInteractionEnabled=YES;
        lab.textColor=[UIColor redColor];
        
        [cell.contentView addSubview:lab];
        return cell;
 
    }
    if (indexPath.section==3) {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        _remove=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        _remove.userInteractionEnabled=YES;
        _remove.image=[UIImage imageNamed:@"icon_clear_cache"];
        [cell.contentView addSubview:_remove];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        //显示当前状态：
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.frame)-200, 10, 200, 40)];
        lab.text=@"清除缓存";
        lab.font=[UIFont systemFontOfSize:18];
        cell.userInteractionEnabled=YES;
        lab.userInteractionEnabled=YES;
        lab.textColor=[UIColor redColor];
        [cell.contentView addSubview:lab];
        return cell;
        
    }
    if (indexPath.section==4) {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        iv.userInteractionEnabled=YES;
        iv.image=[UIImage imageNamed:@"s_detail_share_normal_blue"];
        [cell.contentView addSubview:iv];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        //显示当前状态：
        _deleteYou=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.frame)-200, 10, 200, 40)];
        _deleteYou.text=@"分享我的应用";
        _deleteYou.font=[UIFont systemFontOfSize:18];
        cell.userInteractionEnabled=YES;
        _deleteYou.userInteractionEnabled=YES;
        _deleteYou.textColor=[UIColor redColor];
        [cell.contentView addSubview:_deleteYou];
        return cell;
    }
    if (indexPath.section==5) {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        iv.userInteractionEnabled=YES;
        iv.image=[UIImage imageNamed:@"tab_user_checked"];
        [cell.contentView addSubview:iv];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        //显示当前状态：
        _deleteYou=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.frame)-200, 10, 200, 40)];
        _deleteYou.text=@"注销登录";
        _deleteYou.font=[UIFont systemFontOfSize:18];
        cell.userInteractionEnabled=YES;
        _deleteYou.userInteractionEnabled=YES;
        _deleteYou.textColor=[UIColor redColor];
        [cell.contentView addSubview:_deleteYou];
        return cell;

    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

}


-(void)imageChage:(UITapGestureRecognizer *)tap
{
    if (![_contentMode.text isEqualToString:@"请点击登陆"])
    {
//        UIImageView *iamgev=(UIImageView *)tap.view;
        UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
        [sheet showInView:self.view];
        _PickerC=[[UIImagePickerController alloc] init];
        _PickerC.delegate=self;
        
        
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        _PickerC.sourceType=UIImagePickerControllerSourceTypeCamera;
    
    }
    else if(buttonIndex==1)
    {
        _PickerC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else
    {
        return;
    }
     [self presentViewController:_PickerC animated:YES completion:^{
         
     }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   // NSLog(@"%@",info);
    UIImage * image = info[@"UIImagePickerControllerOriginalImage"] ;
   _imagev.image = image ;
    _imagev.layer.cornerRadius=20;
    _imagev.layer.masksToBounds=YES;

    NSLog(@"%@",info) ;
    
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
- (float) folderSizeAtPath:(NSString*)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
    {
        return 0;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
 folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    NSLog(@"===%lf",folderSize/1024.0/1024.0);
    
    return folderSize/(1024.0*1024.0);
 
}
- (long long) fileSizeAtPath:(NSString*)filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath])
    {
    long long size = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    NSLog(@"---%lf",size/1024.0/1024.0);
    return size/1024.0/1024.0;
    }
    return 0;
}
-(void)contentModeTap:(UITapGestureRecognizer *)tap
{
    if ([_contentMode.text isEqualToString:@"请点击登陆"]) {
        EnterViewController *enter=[[EnterViewController alloc] init];
        enter.backBlock=^(NSDictionary *mydic)
        {
            _contentMode.text=[NSString stringWithFormat:@"欢迎登陆%@",mydic[@"email"]];
            
        };
        [self.navigationController pushViewController:enter animated:YES];

    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        UIApplication *app=[UIApplication sharedApplication];
        if(IOS8)
        {
            //定义通知类型
            //很多app为了避免多次麻烦用户,在一开始就将3种权限都注册好
            UIUserNotificationType type = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
            //设置选项
            UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:type categories:nil];
            //注册
            [app registerUserNotificationSettings:setting];
        }

        [app openURL:[NSURL URLWithString:@"mailto://likangailulu@icloud.com"]];
        NSLog(@"%@",app);
    }
    else if(indexPath.section==2)
    {
        
        _tcc=[[TCUSViewController alloc] initWithNibName:@"TCUSViewController" bundle:nil];
        [self.navigationController pushViewController:_tcc animated:YES];
    }
    else if (indexPath.section==3)
    {
      
        long long mysize=0;
        NSString *CachesPath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"%@",CachesPath);
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:CachesPath];
        
        for (NSString *p in files)
        {
            NSString *path = [CachesPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path])
            {
                //获取文件大小
                long long size = [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileSize];
                mysize+=size;
                NSLog(@"---==%lf",size/1024.0/1024.0);
                
            }
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"当前缓存为%.2lfM,点击确定清除缓存",mysize/1024.0/1024.0] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
    NSString *CachesPath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:CachesPath];
         for (NSString *p in files) {
          NSError *error;
         NSString *path = [CachesPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
         [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        //获取文件大小
        long long size = [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileSize];
            
            NSLog(@"---==%lf",size/1024.0/1024.0);

      }
           
 }
    });
    
        
    }
    else if (indexPath.section==4)

    {
        [UMSocialSnsService presentSnsIconSheetView:self
       appKey:@"565fde64e0f55adda6001a7b"
        shareText:@"我正在使用生活小当家,这款软件真是太棒了！！！！"
       shareImage:[UIImage imageNamed:@"icon"]
       shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,nil]
   delegate:self];
        
       
    }
    else if (indexPath.section==5)
    {
         [self deleteYourId];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"清除成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert1 show];
    NSLog(@"清理成功");
}

-(void)deleteYourId
{
    if(![_contentMode.text isEqualToString:@"请点击登录"])
    {
        
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"退出成功" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action)
                      {
                        _contentMode.text=@"请点击登陆";
                          _imagev.image=[UIImage imageNamed:@"tab_user_normal"];
                      }]];
    [self presentViewController:alert animated:YES completion:nil];
    }
    
}

//遍历文件夹libory获取缓存大小

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
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
