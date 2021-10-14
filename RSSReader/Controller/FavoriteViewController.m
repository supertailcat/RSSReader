//
//  FavoriteViewController.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import "FavoriteViewController.h"
#import "FavoriteManager.h"
#import "DetailViewController.h"
#import "STCRSSItem.h"

@interface FavoriteViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FavoriteViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        [self.view addSubview:_tableView];
        [self.view addConstraints:@[top, left, bottom, right]];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    self.navigationItem.leftBarButtonItem = editBtn;
    self.tableView;
    [self.view addSubview:_tableView];
//    [FavoriteManager sharedManager];
}

- (void)viewWillAppear:(BOOL)animated {
    [_tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    self.hidesBottomBarWhenPushed = NO;
}

- (void)edit:(UIButton *)btn {
    if (_tableView.isEditing == NO) {
        [_tableView setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"完成";
    } else {
        [_tableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"编辑";
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FavoriteManager sharedManager] getFavoriteItemsNumber];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"FavoriteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [[FavoriteManager sharedManager] getFavoriteItemWithIndex:indexPath.row].title;
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[FavoriteManager sharedManager] exchangeFavoriteItemAtIndex:sourceIndexPath.row withFavoriteItemAtIndex:destinationIndexPath.row];
    [tableView exchangeSubviewAtIndex:sourceIndexPath.row withSubviewAtIndex:destinationIndexPath.row];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
        {
            [[FavoriteManager sharedManager] removeFavoriteItemAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.item = [[FavoriteManager sharedManager] getFavoriteItemWithIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

@end
