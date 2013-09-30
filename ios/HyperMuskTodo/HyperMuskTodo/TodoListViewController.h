//
//  TodoListViewController.h
//  HyperMuskTodo
//
//  Created by Felix Sun on 9/30/13.
//  Copyright (c) 2013 Felix Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todoapi.h"

@interface TodoListViewController : UITableViewController

@property (strong, nonatomic) UserService *userService;

@end
