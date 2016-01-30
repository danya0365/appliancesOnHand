//
//  TVModelListViewController.m
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "define.h"
#import "TVModelListViewController.h"
#import "TVModel.h"
#import "Brand.h"
#import "BaseNavigationController.h"


#pragma mark - Present new view
#import "LGTVRemoteViewController.h"


@interface TVModelListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation TVModelListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSAssert(self.brand != nil, @"Brand can not be nil");
    
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
    self.title = self.brand.name;
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
    
    if ( self.brand.varname) {
        
        for (TVModel *tvModel in [TVModel getLGTVModelObjects]) {
            [self.tableData addObject:tvModel];
        }
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
    static NSString *cellIdentifier = @"TableViewCell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    TVModel *tvModel = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = tvModel.name;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.imageView.image = [UIImage imageNamed:tvModel.image];
    
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
    
    TVModel *tvModel = [self.tableData objectAtIndex:indexPath.row];
    
    if ( [tvModel.brand.varname isEqualToString:@"lg"]) {
        
        LGTVRemoteViewController *lgTVRemoteViewController = [LGTVRemoteViewController defaultNib];
        lgTVRemoteViewController.tvModel = tvModel;
        BaseNavigationController *baseNavigationController = [[BaseNavigationController alloc] initWithRootViewController:lgTVRemoteViewController];
        [self presentViewController:baseNavigationController animated:YES completion:^{
            
        }];
        
    }
}


@end
