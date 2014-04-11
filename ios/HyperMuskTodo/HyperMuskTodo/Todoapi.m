// Generated by github.com/hypermusk/hypermusk
// DO NOT EDIT


#import "todoapi.h"

static Todoapi * _todoapi;
static NSDateFormatter * _dateFormatter;

@implementation Todoapi : NSObject
+ (Todoapi *) get {
	if(!_todoapi) {
		_todoapi = [[Todoapi alloc] init];
		if ([_todoapi requestTimeoutInterval] == 0) {
			[_todoapi setRequestTimeoutInterval:10];
		}
	}
	return _todoapi;
}

+ (NSDateFormatter *) dateFormatter {
	if(!_dateFormatter) {
		_dateFormatter = [[NSDateFormatter alloc] init];
		[_dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
	}
	return _dateFormatter;
}

+ (NSDate *) dateFromString:(NSString *)dateString {
	if(!dateString) {
		return nil;
	}

	NSError *error;
	NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"\\.[0-9]*" options:0 error:&error];
	NSAssert(!error, @"Error in regexp");

	NSRange range = NSMakeRange(0, [dateString length]);
	dateString = [regexp stringByReplacingMatchesInString:dateString options:0 range:range withTemplate:@""];

	NSDate *date;
	[[Todoapi dateFormatter] getObjectValue:&date forString:dateString range:nil error:&error];
	if(error) {
		if ([[Todoapi get] verbose]) NSLog(@"Error formatting date %@: %@ (%@)", dateString, [error localizedDescription], error);
		return nil;
	}
	return date;
}

+ (NSString *) stringFromDate:(NSDate *) date {
	if(!date) {
		return nil;
	}
	NSString * dateString = [[Todoapi dateFormatter] stringFromDate:date];
	dateString = [[[dateString substringToIndex:(dateString.length - 3)] stringByAppendingString:@":"] stringByAppendingString:[dateString substringFromIndex:(dateString.length - 2)]];
	return dateString;
}



+ (NSDictionary *) request:(NSURL*)url
		params:(NSDictionary *)params
		stream:(NSInputStream*)stream
		error:(NSError **)error
		completionHandler:(void (^)(NSDictionary *results, NSError *error))completionHandler
{

	Todoapi * _api = [Todoapi get];
	NSMutableURLRequest *httpRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:[_api requestTimeoutInterval]];

	[httpRequest setHTTPMethod:@"POST"];
	NSData *requestBody;
	if (stream == nil) {
		[httpRequest setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
		requestBody = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:error];
		[httpRequest setHTTPBody:requestBody];
	} else {
		[httpRequest setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
		requestBody = [NSJSONSerialization dataWithJSONObject:params options:0 error:error];
		NSString *paramBase64 = [NSString stringWithUTF8String:[[requestBody base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed] bytes]];
		[httpRequest setValue:paramBase64 forHTTPHeaderField:@"X-HyperMuskStreamParams"];
		[httpRequest setHTTPBodyStream:stream];
	}

	if([_api verbose]) {
		NSLog(@"Request: %@", [NSString stringWithUTF8String:[requestBody bytes]]);
	}

	if(*error != nil) {
		return nil;
	}

	if (completionHandler == nil) {
		NSURLResponse  *response = nil;
		NSData *returnData = [NSURLConnection sendSynchronousRequest:httpRequest returningResponse:&response error:error];
		if(*error != nil || returnData == nil) {
			return nil;
		}
		if([_api verbose]) {
			NSLog(@"Response: %@", [NSString stringWithUTF8String:[returnData bytes]]);
		}
		return [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingAllowFragments error:error];
	}

	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	[NSURLConnection sendAsynchronousRequest:httpRequest
				queue:queue
				completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
					NSError *blockError = nil;
					if([_api verbose]) {
						NSLog(@"Response: %@", [NSString stringWithUTF8String:[data bytes]]);
					}

					NSDictionary *results = nil;

					if (connectionError) {
					    NSLog(@"Connection Error: %@", connectionError);
					    blockError = connectionError;
					} else if (data) {
					    results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&blockError];
					    if (blockError) NSLog(@"Error decoding JSON: %@", blockError);
					}

					dispatch_async(dispatch_get_main_queue(), ^{
					    completionHandler(results, blockError);
					});
				}];
	return nil;

}



+ (NSError *)errorWithDictionary:(NSDictionary *)dict {
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	if ([[dict allKeys] count] == 0) {
		return nil;
	}
	NSMutableDictionary *userInfo = [NSMutableDictionary alloc];
	id reason = [dict valueForKey:@"Reason"];
	if ([reason isKindOfClass:[NSDictionary class]]) {
		userInfo = [userInfo initWithDictionary:reason];
	} else {
		userInfo = [userInfo init];
	}
	[userInfo setObject:[dict valueForKey:@"Message"] forKey:NSLocalizedDescriptionKey];

	NSString *code = [dict valueForKey:@"Code"];
	NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *codeNumber = [f numberFromString:code];
	NSInteger intCode = -1;
	if (codeNumber != nil) {
		intCode = [codeNumber integerValue];
	}
	NSError *err = [NSError errorWithDomain:@"TodoapiError" code:intCode userInfo:userInfo];
	return err;
}

@end


// --- TodoList ---
@implementation TodoList

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setId:[dict valueForKey:@"Id"]];
	[self setName:[dict valueForKey:@"Name"]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.id forKey:@"Id"];
	[dict setValue:self.name forKey:@"Name"];

	return dict;
}

@end

// --- TodoItem ---
@implementation TodoItem

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setId:[dict valueForKey:@"Id"]];
	[self setListId:[dict valueForKey:@"ListId"]];
	[self setContent:[dict valueForKey:@"Content"]];
	[self setDone:[[dict valueForKey:@"Done"] boolValue]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.id forKey:@"Id"];
	[dict setValue:self.listId forKey:@"ListId"];
	[dict setValue:self.content forKey:@"Content"];
	[dict setValue:[NSNumber numberWithBool:self.done] forKey:@"Done"];

	return dict;
}

@end


// === Interfaces ===



// --- GetTodoListsParams ---
@implementation UserServiceGetTodoListsParams : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];

	return dict;
}

@end

// --- GetTodoListsResults ---
@implementation UserServiceGetTodoListsResults : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}

	NSMutableArray * mList = [[NSMutableArray alloc] init];
	NSArray * lList = [dict valueForKey:@"List"];
	if ([lList isKindOfClass:[NSArray class]]) {
		for (NSDictionary * d in lList) {
			[mList addObject: [[TodoList alloc] initWithDictionary:d]];
		}
		[self setList:mList];
	}
	[self setErr:[Todoapi errorWithDictionary:[dict valueForKey:@"Err"]]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];

	NSMutableArray * mList = [[NSMutableArray alloc] init];
	for (TodoList * p in self.list) {
		[mList addObject:[p dictionary]];
	}
	[dict setValue:mList forKey:@"List"];
	
	[dict setValue:self.err forKey:@"Err"];

	return dict;
}

@end

// --- GetTodoItemsParams ---
@implementation UserServiceGetTodoItemsParams : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setListId:[dict valueForKey:@"ListId"]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.listId forKey:@"ListId"];

	return dict;
}

@end

// --- GetTodoItemsResults ---
@implementation UserServiceGetTodoItemsResults : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}

	NSMutableArray * mList = [[NSMutableArray alloc] init];
	NSArray * lList = [dict valueForKey:@"List"];
	if ([lList isKindOfClass:[NSArray class]]) {
		for (NSDictionary * d in lList) {
			[mList addObject: [[TodoItem alloc] initWithDictionary:d]];
		}
		[self setList:mList];
	}
	[self setErr:[Todoapi errorWithDictionary:[dict valueForKey:@"Err"]]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];

	NSMutableArray * mList = [[NSMutableArray alloc] init];
	for (TodoItem * p in self.list) {
		[mList addObject:[p dictionary]];
	}
	[dict setValue:mList forKey:@"List"];
	
	[dict setValue:self.err forKey:@"Err"];

	return dict;
}

@end

// --- PutTodoListParams ---
@implementation UserServicePutTodoListParams : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setName:[dict valueForKey:@"Name"]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.name forKey:@"Name"];

	return dict;
}

@end

// --- PutTodoListResults ---
@implementation UserServicePutTodoListResults : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setErr:[Todoapi errorWithDictionary:[dict valueForKey:@"Err"]]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.err forKey:@"Err"];

	return dict;
}

@end

// --- CreateTodoParams ---
@implementation UserServiceCreateTodoParams : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setListId:[dict valueForKey:@"ListId"]];
	[self setContent:[dict valueForKey:@"Content"]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.listId forKey:@"ListId"];
	[dict setValue:self.content forKey:@"Content"];

	return dict;
}

@end

// --- CreateTodoResults ---
@implementation UserServiceCreateTodoResults : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setErr:[Todoapi errorWithDictionary:[dict valueForKey:@"Err"]]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.err forKey:@"Err"];

	return dict;
}

@end

// --- DoneTodoParams ---
@implementation UserServiceDoneTodoParams : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setTodoItemId:[dict valueForKey:@"TodoItemId"]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.todoItemId forKey:@"TodoItemId"];

	return dict;
}

@end

// --- DoneTodoResults ---
@implementation UserServiceDoneTodoResults : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setErr:[Todoapi errorWithDictionary:[dict valueForKey:@"Err"]]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.err forKey:@"Err"];

	return dict;
}

@end

// --- UndoneTodoParams ---
@implementation UserServiceUndoneTodoParams : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setTodoItemId:[dict valueForKey:@"TodoItemId"]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.todoItemId forKey:@"TodoItemId"];

	return dict;
}

@end

// --- UndoneTodoResults ---
@implementation UserServiceUndoneTodoResults : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setErr:[Todoapi errorWithDictionary:[dict valueForKey:@"Err"]]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.err forKey:@"Err"];

	return dict;
}

@end

// --- UploadFileParams ---
@implementation UserServiceUploadFileParams : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setTodoItemId:[dict valueForKey:@"TodoItemId"]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.todoItemId forKey:@"TodoItemId"];

	return dict;
}

@end

// --- UploadFileResults ---
@implementation UserServiceUploadFileResults : NSObject

- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setErr:[Todoapi errorWithDictionary:[dict valueForKey:@"Err"]]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.err forKey:@"Err"];

	return dict;
}

@end




@implementation UserService : NSObject


- (id) initWithDictionary:(NSDictionary*)dict{
	self = [super init];
	if (!self) {
		return self;
	}
	if (![dict isKindOfClass:[NSDictionary class]]) {
		return self;
	}
	[self setEmail:[dict valueForKey:@"Email"]];
	[self setPassword:[dict valueForKey:@"Password"]];

	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSDictionary *dict = [decoder decodeObjectForKey:@"dict"];

    self = [self initWithDictionary:dict];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self dictionary] forKey:@"dict"];
}

- (NSDictionary*) dictionary {
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setValue:self.email forKey:@"Email"];
	[dict setValue:self.password forKey:@"Password"];

	return dict;
}



// --- GetTodoLists ---
- (UserServiceGetTodoListsResults *) getTodoLists {
	
	UserServiceGetTodoListsResults *results = [UserServiceGetTodoListsResults alloc];
	UserServiceGetTodoListsParams *params = [[UserServiceGetTodoListsParams alloc] init];
	
	Todoapi * _api = [Todoapi get];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/GetTodoLists.json", [_api baseURL]]];
	if([_api verbose]) {
		NSLog(@"Requesting URL: %@", url);
	}
	NSError *error;
	NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};

	NSDictionary * dict = [Todoapi request:url params:paramsDict stream:nil error:&error completionHandler:nil];

	if(error != nil) {
		if([_api verbose]) {
			NSLog(@"Error: %@", error);
		}
		results = [results init];
		[results setErr:error];
		return results;
	}
	results = [results initWithDictionary: dict];
	
	return results;
}

- (void) getTodoLists:(void (^)(UserServiceGetTodoListsResults *results))successBlock failure:(void (^)(NSError *error))failureBlock {
	
		UserServiceGetTodoListsParams *params = [[UserServiceGetTodoListsParams alloc] init];
		

		Todoapi * _api = [Todoapi get];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/GetTodoLists.json", [_api baseURL]]];
		if([_api verbose]) {
			NSLog(@"Requesting URL: %@", url);
		}
		NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};
		NSError *nilerror = nil;

		[Todoapi request:url params:paramsDict stream:nil error:&nilerror completionHandler:^(NSDictionary *data, NSError *error) {;

			if (error && failureBlock) {
				if([_api verbose]) {
					NSLog(@"Error: %@", error);
				}

				failureBlock(error);
			}

			if (successBlock) {
				UserServiceGetTodoListsResults *results = [UserServiceGetTodoListsResults alloc];
				results = [results initWithDictionary: data];
				successBlock(results);
			}
		}];
	
}

// --- GetTodoItems ---
- (UserServiceGetTodoItemsResults *) getTodoItems:(NSString *)listId {
	
	UserServiceGetTodoItemsResults *results = [UserServiceGetTodoItemsResults alloc];
	UserServiceGetTodoItemsParams *params = [[UserServiceGetTodoItemsParams alloc] init];
	[params setListId:listId];
	
	Todoapi * _api = [Todoapi get];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/GetTodoItems.json", [_api baseURL]]];
	if([_api verbose]) {
		NSLog(@"Requesting URL: %@", url);
	}
	NSError *error;
	NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};

	NSDictionary * dict = [Todoapi request:url params:paramsDict stream:nil error:&error completionHandler:nil];

	if(error != nil) {
		if([_api verbose]) {
			NSLog(@"Error: %@", error);
		}
		results = [results init];
		[results setErr:error];
		return results;
	}
	results = [results initWithDictionary: dict];
	
	return results;
}

- (void) getTodoItems:(NSString *)listId success:(void (^)(UserServiceGetTodoItemsResults *results))successBlock failure:(void (^)(NSError *error))failureBlock {
	
		UserServiceGetTodoItemsParams *params = [[UserServiceGetTodoItemsParams alloc] init];
		[params setListId:listId];
		

		Todoapi * _api = [Todoapi get];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/GetTodoItems.json", [_api baseURL]]];
		if([_api verbose]) {
			NSLog(@"Requesting URL: %@", url);
		}
		NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};
		NSError *nilerror = nil;

		[Todoapi request:url params:paramsDict stream:nil error:&nilerror completionHandler:^(NSDictionary *data, NSError *error) {;

			if (error && failureBlock) {
				if([_api verbose]) {
					NSLog(@"Error: %@", error);
				}

				failureBlock(error);
			}

			if (successBlock) {
				UserServiceGetTodoItemsResults *results = [UserServiceGetTodoItemsResults alloc];
				results = [results initWithDictionary: data];
				successBlock(results);
			}
		}];
	
}

// --- PutTodoList ---
- (NSError *) putTodoList:(NSString *)name {
	
	UserServicePutTodoListResults *results = [UserServicePutTodoListResults alloc];
	UserServicePutTodoListParams *params = [[UserServicePutTodoListParams alloc] init];
	[params setName:name];
	
	Todoapi * _api = [Todoapi get];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/PutTodoList.json", [_api baseURL]]];
	if([_api verbose]) {
		NSLog(@"Requesting URL: %@", url);
	}
	NSError *error;
	NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};

	NSDictionary * dict = [Todoapi request:url params:paramsDict stream:nil error:&error completionHandler:nil];

	if(error != nil) {
		if([_api verbose]) {
			NSLog(@"Error: %@", error);
		}
		results = [results init];
		[results setErr:error];
		return results.err;
	}
	results = [results initWithDictionary: dict];
	
	return results.err;
}

- (void) putTodoList:(NSString *)name success:(void (^)(NSError *error))successBlock failure:(void (^)(NSError *error))failureBlock {
	
		UserServicePutTodoListParams *params = [[UserServicePutTodoListParams alloc] init];
		[params setName:name];
		

		Todoapi * _api = [Todoapi get];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/PutTodoList.json", [_api baseURL]]];
		if([_api verbose]) {
			NSLog(@"Requesting URL: %@", url);
		}
		NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};
		NSError *nilerror = nil;

		[Todoapi request:url params:paramsDict stream:nil error:&nilerror completionHandler:^(NSDictionary *data, NSError *error) {;

			if (error && failureBlock) {
				if([_api verbose]) {
					NSLog(@"Error: %@", error);
				}

				failureBlock(error);
			}

			if (successBlock) {
				UserServicePutTodoListResults *results = [UserServicePutTodoListResults alloc];
				results = [results initWithDictionary: data];
				successBlock(results.err);
			}
		}];
	
}

// --- CreateTodo ---
- (NSError *) createTodo:(NSString *)listId content:(NSString *)content {
	
	UserServiceCreateTodoResults *results = [UserServiceCreateTodoResults alloc];
	UserServiceCreateTodoParams *params = [[UserServiceCreateTodoParams alloc] init];
	[params setListId:listId];
	[params setContent:content];
	
	Todoapi * _api = [Todoapi get];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/CreateTodo.json", [_api baseURL]]];
	if([_api verbose]) {
		NSLog(@"Requesting URL: %@", url);
	}
	NSError *error;
	NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};

	NSDictionary * dict = [Todoapi request:url params:paramsDict stream:nil error:&error completionHandler:nil];

	if(error != nil) {
		if([_api verbose]) {
			NSLog(@"Error: %@", error);
		}
		results = [results init];
		[results setErr:error];
		return results.err;
	}
	results = [results initWithDictionary: dict];
	
	return results.err;
}

- (void) createTodo:(NSString *)listId content:(NSString *)content success:(void (^)(NSError *error))successBlock failure:(void (^)(NSError *error))failureBlock {
	
		UserServiceCreateTodoParams *params = [[UserServiceCreateTodoParams alloc] init];
		[params setListId:listId];
		[params setContent:content];
		

		Todoapi * _api = [Todoapi get];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/CreateTodo.json", [_api baseURL]]];
		if([_api verbose]) {
			NSLog(@"Requesting URL: %@", url);
		}
		NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};
		NSError *nilerror = nil;

		[Todoapi request:url params:paramsDict stream:nil error:&nilerror completionHandler:^(NSDictionary *data, NSError *error) {;

			if (error && failureBlock) {
				if([_api verbose]) {
					NSLog(@"Error: %@", error);
				}

				failureBlock(error);
			}

			if (successBlock) {
				UserServiceCreateTodoResults *results = [UserServiceCreateTodoResults alloc];
				results = [results initWithDictionary: data];
				successBlock(results.err);
			}
		}];
	
}

// --- DoneTodo ---
- (NSError *) doneTodo:(NSString *)todoItemId {
	
	UserServiceDoneTodoResults *results = [UserServiceDoneTodoResults alloc];
	UserServiceDoneTodoParams *params = [[UserServiceDoneTodoParams alloc] init];
	[params setTodoItemId:todoItemId];
	
	Todoapi * _api = [Todoapi get];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/DoneTodo.json", [_api baseURL]]];
	if([_api verbose]) {
		NSLog(@"Requesting URL: %@", url);
	}
	NSError *error;
	NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};

	NSDictionary * dict = [Todoapi request:url params:paramsDict stream:nil error:&error completionHandler:nil];

	if(error != nil) {
		if([_api verbose]) {
			NSLog(@"Error: %@", error);
		}
		results = [results init];
		[results setErr:error];
		return results.err;
	}
	results = [results initWithDictionary: dict];
	
	return results.err;
}

- (void) doneTodo:(NSString *)todoItemId success:(void (^)(NSError *error))successBlock failure:(void (^)(NSError *error))failureBlock {
	
		UserServiceDoneTodoParams *params = [[UserServiceDoneTodoParams alloc] init];
		[params setTodoItemId:todoItemId];
		

		Todoapi * _api = [Todoapi get];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/DoneTodo.json", [_api baseURL]]];
		if([_api verbose]) {
			NSLog(@"Requesting URL: %@", url);
		}
		NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};
		NSError *nilerror = nil;

		[Todoapi request:url params:paramsDict stream:nil error:&nilerror completionHandler:^(NSDictionary *data, NSError *error) {;

			if (error && failureBlock) {
				if([_api verbose]) {
					NSLog(@"Error: %@", error);
				}

				failureBlock(error);
			}

			if (successBlock) {
				UserServiceDoneTodoResults *results = [UserServiceDoneTodoResults alloc];
				results = [results initWithDictionary: data];
				successBlock(results.err);
			}
		}];
	
}

// --- UndoneTodo ---
- (NSError *) undoneTodo:(NSString *)todoItemId {
	
	UserServiceUndoneTodoResults *results = [UserServiceUndoneTodoResults alloc];
	UserServiceUndoneTodoParams *params = [[UserServiceUndoneTodoParams alloc] init];
	[params setTodoItemId:todoItemId];
	
	Todoapi * _api = [Todoapi get];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/UndoneTodo.json", [_api baseURL]]];
	if([_api verbose]) {
		NSLog(@"Requesting URL: %@", url);
	}
	NSError *error;
	NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};

	NSDictionary * dict = [Todoapi request:url params:paramsDict stream:nil error:&error completionHandler:nil];

	if(error != nil) {
		if([_api verbose]) {
			NSLog(@"Error: %@", error);
		}
		results = [results init];
		[results setErr:error];
		return results.err;
	}
	results = [results initWithDictionary: dict];
	
	return results.err;
}

- (void) undoneTodo:(NSString *)todoItemId success:(void (^)(NSError *error))successBlock failure:(void (^)(NSError *error))failureBlock {
	
		UserServiceUndoneTodoParams *params = [[UserServiceUndoneTodoParams alloc] init];
		[params setTodoItemId:todoItemId];
		

		Todoapi * _api = [Todoapi get];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/UndoneTodo.json", [_api baseURL]]];
		if([_api verbose]) {
			NSLog(@"Requesting URL: %@", url);
		}
		NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};
		NSError *nilerror = nil;

		[Todoapi request:url params:paramsDict stream:nil error:&nilerror completionHandler:^(NSDictionary *data, NSError *error) {;

			if (error && failureBlock) {
				if([_api verbose]) {
					NSLog(@"Error: %@", error);
				}

				failureBlock(error);
			}

			if (successBlock) {
				UserServiceUndoneTodoResults *results = [UserServiceUndoneTodoResults alloc];
				results = [results initWithDictionary: data];
				successBlock(results.err);
			}
		}];
	
}

// --- UploadFile ---
- (NSError *) uploadFile:(NSString *)todoItemId file:(NSInputStream*)file {
	
	UserServiceUploadFileResults *results = [UserServiceUploadFileResults alloc];
	UserServiceUploadFileParams *params = [[UserServiceUploadFileParams alloc] init];
	[params setTodoItemId:todoItemId];
	
	Todoapi * _api = [Todoapi get];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/UploadFile.json", [_api baseURL]]];
	if([_api verbose]) {
		NSLog(@"Requesting URL: %@", url);
	}
	NSError *error;
	NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};

	NSDictionary * dict = [Todoapi request:url params:paramsDict stream:file error:&error completionHandler:nil];

	if(error != nil) {
		if([_api verbose]) {
			NSLog(@"Error: %@", error);
		}
		results = [results init];
		[results setErr:error];
		return results.err;
	}
	results = [results initWithDictionary: dict];
	
	return results.err;
}

- (void) uploadFile:(NSString *)todoItemId file:(NSInputStream*)file success:(void (^)(NSError *error))successBlock failure:(void (^)(NSError *error))failureBlock {
	
		UserServiceUploadFileParams *params = [[UserServiceUploadFileParams alloc] init];
		[params setTodoItemId:todoItemId];
		

		Todoapi * _api = [Todoapi get];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/UserService/UploadFile.json", [_api baseURL]]];
		if([_api verbose]) {
			NSLog(@"Requesting URL: %@", url);
		}
		NSDictionary *paramsDict = @{@"This": [self dictionary], @"Params": [params dictionary]};
		NSError *nilerror = nil;

		[Todoapi request:url params:paramsDict stream:file error:&nilerror completionHandler:^(NSDictionary *data, NSError *error) {;

			if (error && failureBlock) {
				if([_api verbose]) {
					NSLog(@"Error: %@", error);
				}

				failureBlock(error);
			}

			if (successBlock) {
				UserServiceUploadFileResults *results = [UserServiceUploadFileResults alloc];
				results = [results initWithDictionary: data];
				successBlock(results.err);
			}
		}];
	
}
@end

@implementation AppService : NSObject

- (NSDictionary*) dictionary {
	return [NSDictionary dictionaryWithObjectsAndKeys:nil];
}


// --- GetUserService ---
- (UserService *) getUserService:(NSString *)email password:(NSString *)password {
	
	UserService *results = [UserService alloc];
	[results setEmail:email];
	[results setPassword:password];
	
	return results;
}

- (void) getUserService:(NSString *)email password:(NSString *)password success:(void (^)(UserService* UserService))successBlock failure:(void (^)(NSError *error))failureBlock {
	
		UserService *results = [UserService alloc];
		
			[results setEmail:email];
		
			[results setPassword:password];
		
	
}
@end

