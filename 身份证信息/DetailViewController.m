//
//  DetailViewController.m
//  身份证信息
//
//  Created by 苏秋东 on 16/4/5.
//  Copyright © 2016年 com.hyde.carelink. All rights reserved.
//

#import "DetailViewController.h"
#import "MartinCustomLabel.h"
#import "UIImage+QD.h"
#import "UIImageView+WebCache.h"

@interface DetailViewController ()

@property (nonatomic, strong) UIImageView* baseView;

@property (nonatomic, strong) UIImageView* iconView;

@property (nonatomic, strong) UILabel* nameLab;
@property (nonatomic, strong) UILabel* sexLab;
@property (nonatomic, strong) UILabel* nationLab;
@property (nonatomic, strong) UILabel* yearLab;
@property (nonatomic, strong) UILabel* monthLab;
@property (nonatomic, strong) UILabel* dayLab;
@property (nonatomic, strong) UILabel* addressLab;
@property (nonatomic, strong) UILabel* idnoLab;
@property (nonatomic, strong) UIButton* saveBtn;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUserModel:(UserModel*)userModel
{
    _userModel = userModel;

    [self loadImage];
}

- (void)loadImage
{

    if (self.userModel.photo) {
        NSString* urlStr = [NSString stringWithFormat:@"data:image/png;base64,%@", self.userModel.photo];
        NSURL* url = [NSURL URLWithString:urlStr];
        NSData* data = [NSData dataWithContentsOfURL:url];
        UIImage* img = [[UIImage imageWithData:data] imageToTransparent:[UIImage imageWithData:data]];
//        [self.iconView sd_setImageWithURL:url];
        self.iconView.image = img;

        [self loadBaseViewWithSuccess:YES];
    }
    else {
        [self loadBaseViewWithSuccess:NO];
    }
}

- (void)loadLable
{
    /**
     *  name
     */
    self.nameLab.text = self.userModel.name;
    [self.baseView addSubview:self.nameLab];
    /**
     *  sex
     */
    self.sexLab.text = [self.userModel.sex isEqualToString:@"M"] ? @"男" : @"女";
    [self.baseView addSubview:self.sexLab];
    /**
     *  nation
     */
    self.nationLab.text = self.userModel.nation;
    [self.baseView addSubview:self.nationLab];
    /**
     *  year
     */
    self.yearLab.text = [self.userModel.birthday substringWithRange:NSMakeRange(0, 4)];
    [self.baseView addSubview:self.yearLab];
    /**
     *  month
     */
    self.monthLab.text = [self.userModel.birthday substringWithRange:NSMakeRange(4, 2)];
    [self.baseView addSubview:self.monthLab];
    /**
     *  day
     */
    self.dayLab.text = [self.userModel.birthday substringWithRange:NSMakeRange(6, 2)];
    [self.baseView addSubview:self.dayLab];
    /**
     *  address
     */
    self.addressLab.text = self.userModel.addr;
    [self.baseView addSubview:self.addressLab];
    /**
     *  idno
     */
    self.idnoLab.text = self.userModel.idNo;
    [self.baseView addSubview:self.idnoLab];
}

- (void)loadBaseViewWithSuccess:(BOOL)success
{
    if (success) {
        [self.view addSubview:self.baseView];
        [self.baseView addSubview:self.iconView];
        [self loadLable];
        [self.view addSubview:self.saveBtn];
    }
    else {
        self.nameLab.text = @"证件号码和姓名与实名库中信息不符";
        self.nameLab.frame = CGRectMake(0, TopBarHeight + 50, Main_Screen_Width, 30);
        self.nameLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.nameLab];
    }
}

- (UIImageView*)baseView
{
    if (!_baseView) {

        UIImageView* baseView = [[UIImageView alloc] initWithFrame:CGRectMake(Main_Screen_Width / 2 - 320 / 2, TopBarHeight + 20, 320, 320 * 540 / 856)];
        baseView.image = [UIImage imageNamed:@"123.jpg"];
        _baseView = baseView;
    }
    return _baseView;
}

- (UIImageView*)iconView
{
    if (!_iconView) {
        UIImageView* iconView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 30, 100, 120)];
        _iconView = iconView;
    }
    return _iconView;
}

- (UILabel*)nameLab
{
    if (!_nameLab) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 100, 30)];
        lab.text = @"正在加载";
        lab.font = [UIFont systemFontOfSize:12];
        _nameLab = lab;
    }
    return _nameLab;
}

- (UILabel*)sexLab
{
    if (!_sexLab) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLab.left, 45, 100, 30)];
        lab.text = @"正在加载";
        lab.font = [UIFont systemFontOfSize:12];
        _sexLab = lab;
    }
    return _sexLab;
}

- (UILabel*)nationLab
{
    if (!_nationLab) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(130, self.sexLab.top, 100, 30)];
        lab.text = @"正在加载";
        lab.font = [UIFont systemFontOfSize:12];
        _nationLab = lab;
    }
    return _nationLab;
}

- (UILabel*)yearLab
{
    if (!_yearLab) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLab.left, 68, 100, 30)];
        lab.text = @"正在加载";
        lab.font = [UIFont systemFontOfSize:12];
        _yearLab = lab;
    }
    return _yearLab;
}

- (UILabel*)monthLab
{
    if (!_monthLab) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(110, self.yearLab.top, 100, 30)];
        lab.text = @"正在加载";
        lab.font = [UIFont systemFontOfSize:12];
        _monthLab = lab;
    }
    return _monthLab;
}

- (UILabel*)dayLab
{
    if (!_dayLab) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(140, self.yearLab.top, 100, 30)];
        lab.text = @"正在加载";
        lab.font = [UIFont systemFontOfSize:12];
        _dayLab = lab;
    }
    return _dayLab;
}

- (UILabel*)addressLab
{
    if (!_addressLab) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLab.left, 85, 140, 60)];
        lab.text = @"正在加载";
        lab.font = [UIFont systemFontOfSize:12];
        lab.numberOfLines = 0;
        _addressLab = lab;
    }
    return _addressLab;
}

- (UILabel*)idnoLab
{
    if (!_idnoLab) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(110, 155, 200, 30)];
        lab.text = @"正在加载";
        lab.font = [UIFont systemFontOfSize:16];
        _idnoLab = lab;
    }
    return _idnoLab;
}

- (UIButton*)saveBtn
{
    if (!_saveBtn) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(Main_Screen_Width / 2 - 40, self.baseView.bottom + 30, 80, 30);
        [btn setTitle:@"保存图片" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(checkBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor orangeColor];
        _saveBtn = btn;
    }
    return _saveBtn;
}

- (void)checkBtnClick
{
    [self saveImageToPhotos:[self captureView:self.baseView]];
}

- (UIImage*)captureView:(UIView*)theView
{
    CGRect rect = theView.frame;
    if ([theView isKindOfClass:[UIScrollView class]]) {
        rect.size = ((UIScrollView*)theView).contentSize;
    }

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    NSString* msg = nil;
    if (error != NULL) {
        msg = @"保存图片失败";
    }
    else {
        msg = @"保存图片成功";
    }
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
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
