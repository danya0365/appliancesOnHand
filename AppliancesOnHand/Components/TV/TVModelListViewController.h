//
//  TVModelListViewController.h
//  AppliancesOnHand
//
//  Created by DEVTAB_006 on 1/30/2559 BE.
//  Copyright © 2559 DEVTAB_006. All rights reserved.
//

#import "BaseViewController.h"
@class Brand;

@interface TVModelListViewController : BaseViewController

@property (nonatomic, strong) Brand *brand;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
