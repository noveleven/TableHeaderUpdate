//
//  ViewController.m
//  TableHeaderUpdate
//
//  Created by lijinyang on 16/7/30.
//  Copyright © 2016年 noveleven. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController (){
    NSArray *_dataSouce;
    NSArray *_textArray;
    CustomView *_view;
    NSInteger _iTag;
}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    _iTag = -1;
    
    _dataSouce = @[@"ABC",@"DEF",@"GHI",@"JKL",@"MNO",@"PQR",@"STU",@"VWX",@"YZ"];
    
    _textArray = @[@"还有个别网友声称为了爱国“要砸烂苹果手机”。",
                   @"而关于中国电影市场的拐点已至，“票补”的热钱退潮，无疑也是其重要原因之一。",
                   @"近日，越南电视台公布了越南军队进行岛屿登陆作战演练的画面，出动了两栖登陆舰、水上坦克、装甲车、冲锋舟等多种武器装备。",
                   @"40年励精图治，唐山凤凰涅槃、浴火重生。习近平总书记走进唐山，走进这座焕然一新的现代都市。他说，这次来唐山，主要是看一看这座英雄的城市，看一看这里英雄的人民。"];
    
    _view = [[NSBundle mainBundle] loadNibNamed:@"Header" owner:nil options:nil].lastObject;
    self.view.backgroundColor = _view.backgroundColor;
    _tableView.tableFooterView = [UIView new];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateHeaderView) userInfo:nil repeats:YES];
}

- (void)updateHeaderView{
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:_textArray];
    if (_iTag+1) {
        [array removeObject:[_textArray objectAtIndex:_iTag]];
    }
    else{
        _tableView.tableHeaderView = _view;
    }
    NSInteger i = arc4random()%array.count;
    _iTag = [_textArray indexOfObject:[array objectAtIndex:i]];
    _view.label.text = array[i];
    
    
    [_view setNeedsLayout];
    [_view layoutIfNeeded];
    CGFloat height = [_view.label systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = _view.frame;
    frame.size.height = height;
    
    
    [_tableView beginUpdates];
    [UIView animateWithDuration:.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _view.frame = frame;
    } completion:^(BOOL finished) {
    }];
    _tableView.tableHeaderView = _view;
    [_tableView endUpdates];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleCell"];
    cell.textLabel.text = _dataSouce[indexPath.row];
    return cell;
}

@end
