//
//  AddTodoViewController.h
//  HyperMuskTodo
//
//  Created by Felix Sun on 9/30/13.
//  Copyright (c) 2013 Felix Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTodoViewController : UITableViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *todoContent;

@end
