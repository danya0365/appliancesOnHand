//
//  TVBrandListViewController.m
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "TVBrandListViewController.h"
#import "Brand.h"

#import "TVModelListViewController.h"

@interface TVBrandListViewController ()

@end

@implementation TVBrandListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Brand *brand = [self.tableData objectAtIndex:indexPath.row];
    
    if ( [brand.varname isEqualToString:@"lg"] ) {
        
        [self presentTVModelListViewControllerWithBrand:brand];
    }
    else
    {
        [self presentAttentionToastAnimationDirectionTopWithMessage:@"Comming soon"];
    }
}

-(void)presentTVModelListViewControllerWithBrand: (Brand *) brand
{
    TVModelListViewController *tvModelListViewController = [TVModelListViewController defaultNib];
    tvModelListViewController.brand = brand;
    [self.navigationController pushViewController:tvModelListViewController animated:YES];
}


@end
