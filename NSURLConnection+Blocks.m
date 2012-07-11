//
//  NSURLRequest+NSURLRequest_Blocks.m
//  Black Magic
//
//  Created by Rui Peres on 7/11/12.
//

#import "NSURLConnection+Blocks.h"

@implementation NSURLConnection (NSURLConnection_Blocks)

static CompletionBlock _completionBlock;
static FailBlock _failBlock;
static CleanBlock _cleanBlock;
static NSMutableData *webData;

#pragma mark - Public Methods

+ (NSURLConnection*)connectionWithRequest:(NSURLRequest*)request onCompletion:(CompletionBlock)completionBlock onFail:(FailBlock)failBlock
{
    _cleanBlock = [^{
        [_failBlock autorelease];
        [_completionBlock autorelease];
        [_cleanBlock autorelease];
        [webData autorelease];
    } copy];
    
    [_completionBlock release];
    [_failBlock release];
    
    _completionBlock = [completionBlock copy];
    _failBlock = [failBlock copy];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:[self class]];
    
    return connection;
}

#pragma mark - NSURLConnectionDelegate Implementation

+ (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _failBlock(error);
    _cleanBlock();
}

+ (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _completionBlock([NSData dataWithData:webData]);
    _cleanBlock();
}

+ (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{    
    webData = [[NSMutableData dataWithLength:1024] retain];
	[webData setLength: 0];
}

+ (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}

@end
