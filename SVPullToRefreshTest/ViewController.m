//
//  ViewController.m
//  SVPullToRefreshTest
//
//  Created by lijun on 16/8/2.
//
//

#import "ViewController.h"
#import <SVPullToRefresh.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSInteger i = 0; i < 20; i++) {
        [self.dataSource addObject:@(i)];
    }
    
    [self.view addSubview:self.tableView];
    
    
    __weak typeof (self) wSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        __strong typeof (wSelf) strongSelf = wSelf;
        
        NSLog(@"self.tableView pullToRefresh");
        
        for (NSInteger i = 0; i < 20; i++) {
            [strongSelf.dataSource addObject:@(i)];
        }

        [strongSelf.tableView reloadData];
        
        [strongSelf.tableView.pullToRefreshView stopAnimating];
        
    }];
}

-(void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark-delegate

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = ((NSNumber *)(self.dataSource[indexPath.row])).stringValue;
    return cell;
}

#pragma mark-getter

-(UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *) dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end













































