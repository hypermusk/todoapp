//
//  MasterViewController.m
//  HyperMuskTodo
//
//  Created by Felix Sun on 9/27/13.
//  Copyright (c) 2013 Felix Sun. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "TodoListViewController.h"
#import "AddTodoViewController.h"


@interface MasterViewController () {
    NSArray *_objects;
    UserService *userService;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)refillRows
{
    
    [[self navigationItem] setTitle:[self selectedList].name];
    UserServiceGetTodoItemsResults *itemsResult = [userService getTodoItems:[self selectedList].id];
    
    if (itemsResult.err != NULL) {
        NSLog(@"GetTodoItems Err: %@", itemsResult.err);
    }
    
    _objects = itemsResult.list;
    [[self tableView] reloadData];
}

- (IBAction)done:(UIStoryboardSegue *)segue
{
    NSLog(@"[segue identifier] = %@", [segue identifier]);
 
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        AddTodoViewController *addController = [segue sourceViewController];
        NSString *newTodoContent = [addController todoContent].text;
        [userService createTodo:[self selectedList].id content:newTodoContent];
    }
    
    //[userService uploadFile:@"111" stream:[NSInputStream inputStreamWithFileAtPath:@"/Users/sunfmin/Downloads/Qortex-card-CN-Felix_Sun.pdf"]];
    
//    if ([[segue identifier] isEqualToString:@"selectTodoList"]) {
//    }
    
    [userService uploadFile:@"222" file:[NSInputStream inputStreamWithFileAtPath:@"/Users/sunfmin/Downloads/Qortex-card-CN-Felix_Sun.pdf"] success: ^(NSError *error) {
        NSLog(@"Success! %@", error);
    }
    failure:^(NSError *error) {
        NSLog(@"Failure! %@", error);
    }];
    
    NSLog(@"Must Before Success!");

    [self refillRows];

}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    NSLog(@"[segue identifier] = %@", [segue identifier]);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[Todoapi get] setBaseURL:@"http://localhost:9000/api"];
    [[Todoapi get] setVerbose:YES];
    AppService *appService = [AppService alloc];
    userService = [appService getUserService:@"admin@example.com" password:@"nimda"];
    
    UserServiceGetTodoListsResults *r = [userService getTodoLists];
    
    if (r.err != NULL) {
        NSLog(@"GetTodoLists Err: %@", r.err);
        return;
    }
    
    if ([r.list count] == 0) {
        NSLog(@"List size is zero.");
        return;
    }
    
    [self setSelectedList:[r.list objectAtIndex:0]];
    
    [self refillRows];
    

    
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender
//{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    TodoItem *object = _objects[indexPath.row];
    cell.textLabel.text = object.content;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
    
    if ([[segue identifier] isEqualToString:@"showTodoList"]) {
        NSLog(@"[segue destinationViewController] = %@", [segue destinationViewController]);
        TodoListViewController *todoListViewController = (TodoListViewController *)[[segue destinationViewController] topViewController];
        [todoListViewController setUserService:userService];
    }
    

}

@end
