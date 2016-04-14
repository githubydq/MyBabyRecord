//
//  LeftDrawerRemindViewController.m
//  MyBabyRecord
//
//  Created by youdingquan on 16/4/10.
//  Copyright © 2016年 youdingquan. All rights reserved.
//

#import "LeftDrawerRemindViewController.h"
#import "RemindTableViewCell.h"

#import "RemindModel.h"

@interface LeftDrawerRemindViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property(nonatomic,strong)NSMutableArray * listArray;
@end

static NSString * const identify = @"remindcell";

@implementation LeftDrawerRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self initUI];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 懒加载
-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc] init];
    }
    return _listArray;
}

#pragma mark -
#pragma mark UI
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.myTable registerNib:[UINib nibWithNibName:@"RemindTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(saveData)];
}

#pragma mark -
#pragma mark 加载数据
-(void)loadData{
    self.listArray = [NSMutableArray arrayWithArray:[[UIApplication sharedApplication] scheduledLocalNotifications]];
//    for (UILocalNotification * notification in self.listArray) {
//        if (notification.repeatInterval == kCFCalendarUnitEra) {
//            NSDate * date = [NSDate date];
//            if ([date compare:notification.fireDate] == NSOrderedDescending) {
//                [[UIApplication sharedApplication]cancelLocalNotification:notification];
//                [self.listArray removeObject:notification];
//            }
//        }
//    }
}

#pragma mark -
#pragma mark 保存数据
-(void)saveData{
    NSLog(@"%@",[[UIApplication sharedApplication] scheduledLocalNotifications]);
    [self scheduleLoacl];
    [self.myTable reloadData];
}

#pragma mark -
#pragma mark 推送本地通知
-(void)scheduleLoacl{
    UILocalNotification * notification = [[UILocalNotification alloc] init];
    if (notification != nil) {
        //提醒时间
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
        //提醒时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        //提醒重复间隔
        notification.repeatInterval = kCFCalendarUnitEra;
        //提醒声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        //提醒
        notification.alertTitle = @"alertTitle";
        //提醒
        notification.alertBody = @"alertBody";
        //提醒
        notification.applicationIconBadgeNumber = 0;
        //提醒
        NSDictionary * info = [NSDictionary dictionaryWithObject:@"test" forKey:@"name"];
        notification.userInfo = info;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        [self.listArray addObject:notification];
    }
}

#pragma mark -
#pragma mark 表格代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemindTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    UILocalNotification * model = self.listArray[indexPath.row];
    cell.title.text = model.alertTitle;
    cell.date.text = model.alertBody;
    return cell;
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
