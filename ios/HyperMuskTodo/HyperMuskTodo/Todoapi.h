// Generated by github.com/hypermusk/hypermusk
// DO NOT EDIT

#import <Foundation/Foundation.h>


@interface Todoapi : NSObject
@property (nonatomic, strong) NSString * BaseURL;
@property (nonatomic, assign) BOOL Verbose;
+ (Todoapi *) get;

@end



// --- TodoList ---
@interface TodoList : NSObject

@property (nonatomic, strong) NSString * Id;
@property (nonatomic, strong) NSString * Name;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- TodoItem ---
@interface TodoItem : NSObject

@property (nonatomic, strong) NSString * Id;
@property (nonatomic, strong) NSString * ListId;
@property (nonatomic, strong) NSString * Content;
@property (nonatomic, assign) BOOL Done;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end


// === Interfaces ===


// --- GetTodoListsParams ---
@interface UserServiceGetTodoListsParams : NSObject


- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- GetTodoListsResults ---
@interface UserServiceGetTodoListsResults : NSObject

@property (nonatomic, strong) NSArray * List;
@property (nonatomic, strong) NSError * Err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- GetTodoItemsParams ---
@interface UserServiceGetTodoItemsParams : NSObject

@property (nonatomic, strong) NSString * ListId;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- GetTodoItemsResults ---
@interface UserServiceGetTodoItemsResults : NSObject

@property (nonatomic, strong) NSArray * List;
@property (nonatomic, strong) NSError * Err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- PutTodoListParams ---
@interface UserServicePutTodoListParams : NSObject

@property (nonatomic, strong) NSString * Name;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- PutTodoListResults ---
@interface UserServicePutTodoListResults : NSObject

@property (nonatomic, strong) NSError * Err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- CreateTodoParams ---
@interface UserServiceCreateTodoParams : NSObject

@property (nonatomic, strong) NSString * ListId;
@property (nonatomic, strong) NSString * Content;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- CreateTodoResults ---
@interface UserServiceCreateTodoResults : NSObject

@property (nonatomic, strong) NSError * Err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- DoneTodoParams ---
@interface UserServiceDoneTodoParams : NSObject

@property (nonatomic, strong) NSString * TodoItemId;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- DoneTodoResults ---
@interface UserServiceDoneTodoResults : NSObject

@property (nonatomic, strong) NSError * Err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- UndoneTodoParams ---
@interface UserServiceUndoneTodoParams : NSObject

@property (nonatomic, strong) NSString * TodoItemId;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- UndoneTodoResults ---
@interface UserServiceUndoneTodoResults : NSObject

@property (nonatomic, strong) NSError * Err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end


@interface UserService : NSObject

@property (nonatomic, strong) NSString * Email;
@property (nonatomic, strong) NSString * Password;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;



- (UserServiceGetTodoListsResults *) GetTodoLists;

- (UserServiceGetTodoItemsResults *) GetTodoItems:(NSString *)listId;

- (NSError *) PutTodoList:(NSString *)name;

- (NSError *) CreateTodo:(NSString *)listId content:(NSString *)content;

- (NSError *) DoneTodo:(NSString *)todoItemId;

- (NSError *) UndoneTodo:(NSString *)todoItemId;
@end



@interface AppService : NSObject
- (NSDictionary*) dictionary;


- (UserService *) GetUserService:(NSString *)email password:(NSString *)password;
@end

