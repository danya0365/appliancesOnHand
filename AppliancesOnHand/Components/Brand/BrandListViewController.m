//
//  BrandListViewController.m
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "define.h"
#import "BrandListViewController.h"
#import "Brand.h"
#import "BrandListTableViewCell.h"

@interface BrandListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BrandListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupView];
    [self initTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTransclucentView];
    self.navigationController.navigationBar.translucent = NO;
    [self setTabBarHidden:YES withAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup view

-(void) setupView
{
    self.title = NSLocalizedString(@"brand_title", nil);
}



- (void)setNavigationBarRightButton {
    
}



#pragma mark - tableView

- (void) initTableView
{
    self.tableData = [[NSMutableArray alloc] init];
    
    
    [self addRefreshControlToTableView:self.tableView];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xe5e5e5);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BrandListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BrandListTableViewCell"];
    
    [self getTableData];
}

-(void)getTableData
{
    if ( self.tableDataOffset == 0) {
        if ( self.tableData == nil ) {
            self.tableData = [[NSMutableArray alloc] init];
        }
        [self.tableData removeAllObjects];
    }
    
    for (Brand *brand in [Brand getTVBrandObjects]) {
        [self.tableData addObject:brand];
    }
    
    [self.tableView reloadData];
}

-(void)refreshTableView
{
    [self getTableData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger dataCount = [self.tableData count];
    
    return dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"BrandListTableViewCell";
    BrandListTableViewCell *cell = (BrandListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Brand *brand = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = brand.name;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.imageView.image = [UIImage imageNamed:brand.image];
    
    cell.alpha = 0.0f;
    [UIView animateWithDuration:0.3f animations:^{
        cell.alpha = 1.0f;
    }];
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"";
}

/*
 -(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 return nil;
 }
 */

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
