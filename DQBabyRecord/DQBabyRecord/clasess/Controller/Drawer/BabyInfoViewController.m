//
//  BabyInfoViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/12.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "BabyInfoViewController.h"
#import "BabyModel.h"
#import <MJRefresh.h>

@interface BabyInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property(nonatomic,strong)NSMutableArray * listArray;
@property(nonatomic,strong)UIImageView * imgView;
@end

@implementation BabyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark 懒加载
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

#pragma mark -
#pragma mark UI初始化
-(void)configUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"宝贝信息修改";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(babyInfoRightClick)];
    
    self.myTable.backgroundColor = BACK_COLOR;
    //设置下拉刷新
    __block BabyInfoViewController * blockSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [blockSelf choiceImage];
        [blockSelf.myTable.mj_header endRefreshing];
    }];
    [header setTitle:@"下拉进行设置图像" forState:MJRefreshStateIdle];
    [header setTitle:@"松开开始设置图像" forState:MJRefreshStatePulling];
    [header setTitle:@"正在设置图像" forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.myTable.mj_header = header;
}

-(void)babyInfoRightClick{
    BabyModel * model = [[BabyModel alloc] init];
    model.image = [TimeHelper getNowTime];
    [ImageHelper saveIconImag:self.imgView.image withName:model.image];
    [self.delegate saveModel:model];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 数据初始化
-(void)loadData{
    self.listArray = [NSMutableArray arrayWithArray:@[@[@"姓名",@"性别",@"年龄"]]];
}

#pragma mark -
#pragma mark 表格视图代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listArray[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identify = @"babyinfocell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row != 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = self.model.name;
        }else if (indexPath.row == 1) {
            cell.detailTextLabel.text = self.model.sex;
        }else if (indexPath.row == 2) {
            cell.detailTextLabel.text = [TimeHelper getNowAge:self.model.birthday];
        }
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return @"下拉设置iCon";
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    if (!self.imgView.image) {
        return nil;
    }
    self.imgView.center = view.center;
    self.imgView.bounds = CGRectMake(0, 0, 60, 60);
    [view addSubview:self.imgView];
    return view;
}

#pragma mark -
#pragma mark 表格头视图

#pragma mark -
#pragma mark 拍照
//添加
-(void)choiceImage{
    __block BabyInfoViewController * blockSelf = self;
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
    __block BabyInfoViewController * blockSelf = self;
    UIImagePickerControllerSourceType type = isCamera ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = blockSelf;
        picker.sourceType = type;
        picker.allowsEditing = YES;
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
        UIImage * image = info[UIImagePickerControllerEditedImage];
        NSData * data = UIImageJPEGRepresentation(image, 0.2);
        self.imgView.image = [UIImage imageWithData:data];
        [self.myTable reloadData];
    }
    [picker dismissViewControllerAnimated:NO completion:^{
    }];
    
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
