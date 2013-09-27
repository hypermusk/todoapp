//
//  MasterViewController.h
//  HyperMuskTodo
//
//  Created by Felix Sun on 9/27/13.
//  Copyright (c) 2013 Felix Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
