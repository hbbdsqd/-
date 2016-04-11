//
//  ViewController.m
//  身份证信息
//
//  Created by 苏秋东 on 16/3/31.
//  Copyright © 2016年 com.hyde.carelink. All rights reserved.
//

#import "AFNetworking.h"
#import "DetailViewController.h"
#import "MJExtension.h"
#import "UserModel.h"
#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel* idnoLab;

@property (nonatomic, strong) UITextField* idnotext;

@property (nonatomic, strong) UILabel* nameLab;

@property (nonatomic, strong) UITextField* nameText;

@property (nonatomic, strong) UIButton* checkBtn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];

    self.title = @"查询身份证号码";

    [self loadInfo];

    [self loadHttp];
}

/**
 *  加载视图
 */
- (void)loadInfo
{
    [self.view addSubview:self.nameLab];
    [self.view addSubview:self.nameText];
    [self.view addSubview:self.idnoLab];
    [self.view addSubview:self.idnotext];
    [self.view addSubview:self.checkBtn];
}

/**
 *  请求数据
 */
- (void)loadHttp
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];

    //    //申明返回的结果是json类型
    //
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //
    //    //申明请求的数据是json类型
    //
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    //传入的参数

    NSString* province = [self.idnotext.text substringWithRange:NSMakeRange(0, 2)];
    NSString* city = [self.idnotext.text substringWithRange:NSMakeRange(0, 2)];
    NSString* urlPath = @"http://20.1.31.54/aops/cert/userCert.php";

    NSMutableDictionary* mulDic = [[NSMutableDictionary alloc] init];
    [mulDic setValue:province forKey:@"province"];
    [mulDic setValue:city forKey:@"city"];
    [mulDic setValue:self.idnotext.text forKey:@"idNo"];
    [mulDic setValue:self.nameText.text forKey:@"name"];

    [manager POST:urlPath parameters:mulDic success:^(NSURLSessionDataTask* task, id responseObject) {
        //        NSLog(@"responseObject\n%@", responseObject);

        UserModel* model = [UserModel mj_objectWithKeyValues:responseObject[@"data"]];

        //        NSLog(@"%@", model);

        DetailViewController* detailVC = [[DetailViewController alloc] init];
        detailVC.userModel = model;

        [self.navigationController pushViewController:detailVC animated:YES];

        //        data:image/png;base64,

        /**
         *  苏秋东
         
            130621199208225175
         *
         *  @param task  <#task description#>
         *  @param error <#error description#>
         *
         *  @return <#return value description#>
         */
    }
        failure:^(NSURLSessionDataTask* task, NSError* error) {
            NSLog(@"error\n%@", error);
        }];
}

- (UILabel*)nameLab
{
    if (!_nameLab) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20 + TopBarHeight, 80, 30)];
        lab.text = @"姓名";
        _nameLab = lab;
    }
    return _nameLab;
}

- (UITextField*)nameText
{
    if (!_nameText) {
        UITextField* text = [[UITextField alloc] initWithFrame:CGRectMake(self.nameLab.right, self.nameLab.top, Main_Screen_Width - self.nameLab.right - self.nameLab.left, self.nameLab.height)];
        text.placeholder = @"请输入要查询的姓名";
        //        text.text = @"何晔鑫";
        text.text = @"苏秋东";
        _nameText = text;
    }
    return _nameText;
}

- (UILabel*)idnoLab
{
    if (!_idnoLab) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(20, self.nameText.bottom + 30, self.nameLab.width, self.nameLab.height)];
        lab.text = @"身份证号";
        _idnoLab = lab;
    }
    return _idnoLab;
}

- (UITextField*)idnotext
{
    if (!_idnotext) {
        UITextField* text = [[UITextField alloc] initWithFrame:CGRectMake(self.nameLab.right, self.idnoLab.top, Main_Screen_Width - self.nameLab.right - self.nameLab.left, self.nameLab.height)];
        text.placeholder = @"请输入要查询的身份证号";
        //        text.text = @"360302199007180537";
        text.text = @"130621199208225175";
        _idnotext = text;
    }
    return _idnotext;
}

- (UIButton*)checkBtn
{
    if (!_checkBtn) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(Main_Screen_Width / 2 - 25, self.idnotext.bottom + 30, 50, 30);
        [btn setTitle:@"查询" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(checkBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _checkBtn = btn;
    }
    return _checkBtn;
}

- (void)checkBtnClick
{
    [self loadHttp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
