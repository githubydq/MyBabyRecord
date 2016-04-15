//
//  AddImageRecordViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/5.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "AddImageRecordViewController.h"
#import "RecordDao.h"
#import "RecordModel.h"

@interface AddImageRecordViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *textHoldplace;
@property (weak, nonatomic) IBOutlet UILabel *dateTitle;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UIButton *delete;


@property(nonatomic,strong)RecordModel * model;
@property(nonatomic,copy)NSString * dateString;
@property(nonatomic,strong)UIImage * img;

@end

@implementation AddImageRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BACK_COLOR;
    
    [self initUI];
    [self initNav];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
}

#pragma mark 初始化导航栏

-(void)initNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 返回" style:UIBarButtonItemStylePlain target:self action:@selector(addImageRecordLeftClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(addImageRecordRightClick)];
}

-(void)addImageRecordLeftClick{
    UIViewController * vc = self.navigationController.viewControllers.firstObject;
    [vc removeFromParentViewController];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addImageRecordRightClick{
    self.model = [[RecordModel alloc] init];
    self.model.name = [[NSUserDefaults standardUserDefaults] objectForKey:NOW_BABY];
    self.model.date = self.dateString;
    self.model.detail = self.textView.text;
    self.model.image = self.dateString;
    [RecordDao save:self.model];
    [ImageHelper saveImage:self.img withName:self.dateString];
    [ImageHelper saveSmallImage:self.img withName:self.dateString];
    [[Singleton shareInstance].recordModelArray insertObject:self.model atIndex:0];
    [self addImageRecordLeftClick];
}

#pragma mark 初始化UI
-(void)initUI{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageRecordImageClick)];
    self.image.userInteractionEnabled = YES;
    [self.image addGestureRecognizer:tap];
    [self.delete setHidden:YES];
}

-(void)addImageRecordImageClick{
    [self choiceImage];
}
- (IBAction)deleteImage:(id)sender {
    self.image.image = [UIImage imageNamed:@"add_image80x80"];
    [self.delete setHidden:YES];
}

#pragma mark 加载数据
-(void)loadData{
    self.textView.text = nil;
    self.textHoldplace.text = @"宝宝在干什么呢？";
    self.dateTitle.text = @"记录时间：";
    self.dateString = [TimeHelper getNowTime];
    self.date.text = [TimeHelper getNowTimeWithTime:self.dateString];
}

#pragma mark 拍照
//添加
-(void)choiceImage{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera:YES];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera:NO];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{
    }];
}

//打开相机
-(void)openCamera:(BOOL)isCamera{
    __block AddImageRecordViewController * blockSelf = self;
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
        NSData * data = UIImageJPEGRepresentation(image, 0.1);
        self.img = [UIImage imageWithData:data];
        [self.image setImage:[UIImage imageWithData:data]];
        [self.delete setHidden:NO];
    }
    [picker dismissViewControllerAnimated:NO completion:^{
    }];
    
}


@end
