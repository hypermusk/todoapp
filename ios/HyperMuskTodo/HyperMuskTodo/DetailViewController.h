//
//  DetailViewController.h
//  HyperMuskTodo
//
//  Created by Felix Sun on 9/27/13.
//  Copyright (c) 2013 Felix Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
