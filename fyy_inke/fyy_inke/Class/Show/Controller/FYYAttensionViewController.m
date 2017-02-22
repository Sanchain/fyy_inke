//
//  FYYAttensionViewController.m
//  fyy_inke
//
//  Created by 冯亚运 on 17/2/17.
//  Copyright © 2017年 冯亚运. All rights reserved.
//

#import "FYYAttensionViewController.h"
#import "FYYHotCell.h"
#import "FYYLive.h"
#import "FYYCreator.h"
#import "FYYPlayerViewController.h"
static NSString *hotCellIdentifer = @"FYYHotCell";
@interface FYYAttensionViewController ()<UITableViewDataSource,UITableViewDelegate>
//*    */
@property (nonatomic, strong) NSMutableArray *dataSource;

//*    */
@property (nonatomic, strong) UITableView *myTab;

@end

@implementation FYYAttensionViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (UITableView *)myTab {
    if (!_myTab) {
        _myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _myTab.tableFooterView = [UIView new];
        _myTab.delegate = self;
        _myTab.dataSource = self;
        [_myTab registerNib:[UINib nibWithNibName:@"FYYHotCell" bundle:nil] forCellReuseIdentifier:hotCellIdentifer];
        
    }
    return _myTab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self loadData];
}

- (void)initUI {
    [self.view addSubview:self.myTab];
}
- (void)loadData {
    [self.dataSource removeAllObjects];
    FYYLive * live = [[FYYLive alloc] init];
    FYYCreator * creator = [[FYYCreator alloc] init];
    live.creator = creator;
    
    live.streamAddr = Live_FYY;
    live.city = @"北京";
    live.onlineUsers = 100;
    live.creator.nick = @"自己人";
    [self.dataSource addObject:live];
    [self.myTab reloadData];
    
}

#pragma mark-UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYYHotCell *cell = [tableView dequeueReusableCellWithIdentifier:hotCellIdentifer forIndexPath:indexPath];
    FYYLive *live = self.dataSource[indexPath.row];
    cell.live = live;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70+SCREEN_WIDTH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    FYYPlayerViewController * playerVC = [[FYYPlayerViewController alloc] init];
    
    playerVC.live = self.dataSource[indexPath.row];
    
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
