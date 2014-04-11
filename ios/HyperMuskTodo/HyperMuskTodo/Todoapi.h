// Generated by github.com/hypermusk/hypermusk
// DO NOT EDIT

#import <Foundation/Foundation.h>


@interface Todoapi : NSObject
@property (nonatomic, strong) NSString * baseURL;
@property (nonatomic, assign) BOOL verbose;
@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;
+ (Todoapi *) get;

@end



// --- TodoList ---
@interface TodoList : NSObject<NSCoding>

@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * name;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- TodoItem ---
@interface TodoItem : NSObject<NSCoding>

@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * listId;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) BOOL done;

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

@property (nonatomic, strong) NSArray * list;
@property (nonatomic, strong) NSError * err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- GetTodoItemsParams ---
@interface UserServiceGetTodoItemsParams : NSObject

@property (nonatomic, strong) NSString * listId;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- GetTodoItemsResults ---
@interface UserServiceGetTodoItemsResults : NSObject

@property (nonatomic, strong) NSArray * list;
@property (nonatomic, strong) NSError * err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- PutTodoListParams ---
@interface UserServicePutTodoListParams : NSObject

@property (nonatomic, strong) NSString * name;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- PutTodoListResults ---
@interface UserServicePutTodoListResults : NSObject

@property (nonatomic, strong) NSError * err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- CreateTodoParams ---
@interface UserServiceCreateTodoParams : NSObject

@property (nonatomic, strong) NSString * listId;
@property (nonatomic, strong) NSString * content;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- CreateTodoResults ---
@interface UserServiceCreateTodoResults : NSObject

@property (nonatomic, strong) NSError * err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- DoneTodoParams ---
@interface UserServiceDoneTodoParams : NSObject

@property (nonatomic, strong) NSString * todoItemId;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- DoneTodoResults ---
@interface UserServiceDoneTodoResults : NSObject

@property (nonatomic, strong) NSError * err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- UndoneTodoParams ---
@interface UserServiceUndoneTodoParams : NSObject

@property (nonatomic, strong) NSString * todoItemId;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- UndoneTodoResults ---
@interface UserServiceUndoneTodoResults : NSObject

@property (nonatomic, strong) NSError * err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- UploadFileParams ---
@interface UserServiceUploadFileParams : NSObject

@property (nonatomic, strong) NSString * todoItemId;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end

// --- UploadFileResults ---
@interface UserServiceUploadFileResults : NSObject

@property (nonatomic, strong) NSError * err;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;

@end


@interface UserService : NSObject

@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * password;

- (id) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionary;



- (UserServiceGetTodoListsResults *) getTodoLists;
- (void) getTodoLists:(void (^)(UserServiceGetTodoListsResults *results))successBlock failure:(void (^)(NSError *error))failureBlock;

- (UserServiceGetTodoItemsResults *) getTodoItems:(NSString *)listId;
- (void) getTodoItems:(NSString *)listId success:(void (^)(UserServiceGetTodoItemsResults *results))successBlock failure:(void (^)(NSError *error))failureBlock;

- (NSError *) putTodoList:(NSString *)name;
- (void) putTodoList:(NSString *)name success:(void (^)(NSError *error))successBlock failure:(void (^)(NSError *error))failureBlock;

- (NSError *) createTodo:(NSString *)listId content:(NSString *)content;
- (void) createTodo:(NSString *)listId content:(NSString *)content success:(void (^)(NSError *error))successBlock failure:(void (^)(NSError *error))failureBlock;

- (NSError *) doneTodo:(NSString *)todoItemId;
- (void) doneTodo:(NSString *)todoItemId success:(void (^)(NSError *error))successBlock failure:(void (^)(NSError *error))failureBlock;

- (NSError *) undoneTodo:(NSString *)todoItemId;
- (void) undoneTodo:(NSString *)todoItemId success:(void (^)(NSError *error))successBlock failure:(void (^)(NSError *error))failureBlock;

- (NSError *) uploadFile:(NSString *)todoItemId file:(NSInputStream*)file;
- (void) uploadFile:(NSString *)todoItemId file:(NSInputStream*)file success:(void (^)(NSError *error))successBlock failure:(void (^)(NSError *error))failureBlock;
@end



@interface AppService : NSObject- (NSDictionary*) dictionary;

- (UserService *) getUserService:(NSString *)email password:(NSString *)password;
- (void) getUserService:(NSString *)email password:(NSString *)password success:(void (^)(UserService* UserService))successBlock failure:(void (^)(NSError *error))failureBlock;
@end

