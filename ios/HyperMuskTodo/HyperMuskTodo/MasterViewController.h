//
//  MasterViewController.h
//  HyperMuskTodo
//
//  Created by Felix Sun on 9/27/13.
//  Copyright (c) 2013 Felix Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todoapi.h"


@class DetailViewController;
@class TodoListViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) TodoListViewController *todoListViewController;
@property (strong, nonatomic) TodoList * selectedList;

- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;

@end
