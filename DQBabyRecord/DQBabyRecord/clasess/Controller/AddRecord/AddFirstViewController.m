//
//  AddFirstViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/5.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "AddFirstViewController.h"
#import "FirstDao.h"
#import "FirstModel.h"

@interface AddFirstViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UITextView *firstTitle;
@property (weak, nonatomic) IBOutlet UITextView *detaeil;
@property (weak, nonatomic) IBOutlet UIView *firstImageView;

//图片按钮
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImage;
//删除按钮
@property (weak, nonatomic) IBOutlet UIButton *firstDelete;
@property (weak, nonatomic) IBOutlet UIButton *secondDelete;
@property (weak, nonatomic) IBOutlet UIButton *thirdDelete;

@property(nonatomic,copy)NSMutableString * imageString;
@property(nonatomic,strong)NSMutableArray * imageArray;

@property(nonatomic,strong)FirstModel * model;
@end

@implementation AddFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACK_COLOR;
    [self loadData];
    [self initNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.firstTitle resignFirstResponder];
    [self.detaeil resignFirstResponder];
}
#pragma mark -
#pragma mark 懒加载
-(FirstModel *)model{
    if (!_model) {
        _model = [[FirstModel alloc] init];
    }
    return _model;
}

-(NSMutableString *)imageString{
    if (!_imageString) {
        _imageString = [[NSMutableString alloc]init];
    }
    return _imageString;
}
-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

#pragma mark 初始化

-(void)initNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 返回" style:UIBarButtonItemStylePlain target:self action:@selector(addFirslLeftClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(addFirslRightClick)];
    
    self.firstImage.userInteractionEnabled = YES;
//    self.secondImage.userInteractionEnabled = YES;
//    self.thirdImage.userInteractionEnabled = YES;
    [self.firstDelete setHidden:YES];
    [self.secondDelete setHidden:YES];
    [self.thirdDelete setHidden:YES];
}

-(void)addFirslLeftClick{
    UIViewController * vc = self.navigationController.viewControllers.firstObject;
    [vc removeFromParentViewController];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addFirslRightClick{
    self.model = [[FirstModel alloc] init];
    self.model.title = self.firstTitle.text;
    self.model.name = [[NSUserDefaults standardUserDefaults] objectForKey:NOW_BABY];
    self.model.date = [TimeHelper getNowTime];
    self.model.detail = self.detaeil.text;
    self.model.image = self.imageString;
    for (int i = 0 ; i < self.imageArray.count; i++) {
        [ImageHelper saveImage:self.imageArray[i] withName:[self.imageString substringWithRange:NSMakeRange(14*i, 14)]];
    }
    [FirstDao save:self.model];
    [[Singleton shareInstance].firstModelArray insertObject:self.model atIndex:0];
    [self addFirslLeftClick];
}

#pragma mark 加载数据
-(void)loadData{
    self.firstTitle.text = nil;
    self.model.date = [TimeHelper getNowTime];
    self.date.text = [TimeHelper getNowTimeWithTime:self.model.date];
    self.detaeil.text = nil;
}

#pragma mark -
#pragma mark 拍照
//添加
-(void)choiceImage{
    __block AddFirstViewController * blockSelf = self;
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [blockSelf openCamera:YES];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [blockSelf openCamera:NO];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{
    }];
}

//打开相机
-(void)openCamera:(BOOL)isCamera{
    __block AddFirstViewController * blockSelf = self;
    UIImagePickerControllerSourceType type = isCamera ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = blockSelf;
        picker.sourceType = type;
        dispatch_async(dispatch_get_main_queue(), ^{
            [blockSelf presentViewController:picker animated:YES completion:^{
            }];
        });
    }
}

//相机
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //    NSLog(@"%@",info);
    //判断资源类型
    if ([mediaType isEqualToString:@"public.image"]){
        //如果是图片
        UIImage * image = info[UIImagePickerControllerOriginalImage];
        [self.imageString appendString:[TimeHelper getNowTime]];
        [self.imageArray addObject:image];
        NSData * data = UIImageJPEGRepresentation(image, 0.1);
        if (self.imageString.length == 14) {
            [self.firstImage setImage:[UIImage imageWithData:data]];
            self.secondImage.image = [UIImage imageNamed:@"add_image80x80"];
            self.secondImage.userInteractionEnabled = YES;
            [self.firstDelete setHidden:NO];
        }else if (self.imageString.length == 14*2){
            [self.secondImage setImage:[UIImage imageWithData:data]];
            self.thirdImage.image = [UIImage imageNamed:@"add_image80x80"];
            self.thirdImage.userInteractionEnabled = YES;
            [self.secondDelete setHidden:NO];
        }else if (self.imageString.length == 14*3){
            [self.thirdImage setImage:[UIImage imageWithData:data]];
            [self.thirdDelete setHidden:NO];
        }
    }
    [picker dismissViewControllerAnimated:NO completion:^{
    }];
    
}

#pragma mark -
#pragma mark 点击事件
- (IBAction)firstImageClick:(id)sender {
    [self choiceImage];
}
- (IBAction)secondImageClick:(id)sender {
    [self choiceImage];
}
- (IBAction)thirdImageClick:(id)sender {
    [self choiceImage];
}
- (IBAction)firstDeleteClick:(id)sender {
    if (self.imageString.length == 14) {
        [self.firstDelete setHidden:YES];
        self.firstImage.image = [UIImage imageNamed:@"add_image80x80"];
        self.secondImage.image = nil;
        self.secondImage.userInteractionEnabled = NO;
    }else if (self.imageString.length == 14*2){
        self.firstImage.image = self.secondImage.image;
        self.secondImage.image = [UIImage imageNamed:@"add_image80x80"];
        self.thirdImage.image = nil;
        self.thirdImage.userInteractionEnabled = NO;
        [self.secondDelete setHidden:YES];
    }else if (self.imageString.length == 14*3){
        self.firstImage.image = self.secondImage.image;
        self.secondImage.image = self.thirdImage.image;
        [self.thirdDelete setHidden:YES];
        self.thirdImage.image = [UIImage imageNamed:@"add_image80x80"];
    }
    [self.imageString deleteCharactersInRange:NSMakeRange(0, 14)];
    [self.imageArray removeObjectAtIndex:0];
}
- (IBAction)secondDeleteClick:(id)sender {
    if (self.imageString.length == 14*2){
        self.secondImage.image = [UIImage imageNamed:@"add_image80x80"];
        self.thirdImage.image = nil;
        self.thirdImage.userInteractionEnabled = NO;
        [self.secondDelete setHidden:YES];
    }else if (self.imageString.length == 14*3){
        self.secondImage.image = self.thirdImage.image;
        [self.thirdDelete setHidden:YES];
        self.thirdImage.image = [UIImage imageNamed:@"add_image80x80"];
    }
    [self.imageString deleteCharactersInRange:NSMakeRange(14, 14)];
    [self.imageArray removeObjectAtIndex:1];
}
- (IBAction)thirdDeleteClick:(id)sender {
    if (self.imageString.length == 14*3){
        [self.thirdDelete setHidden:YES];
        self.thirdImage.image = [UIImage imageNamed:@"add_image80x80"];
    }
    [self.imageString deleteCharactersInRange:NSMakeRange(28, 14)];
    [self.imageArray removeObjectAtIndex:2];
}


@end
