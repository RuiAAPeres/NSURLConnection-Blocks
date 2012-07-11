//
//  NSURLRequest+NSURLRequest_Blocks.h
//  Black Magic
//
//  Created by Rui Peres on 7/11/12.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(NSData *data);
typedef void(^FailBlock)(NSError *error);
typedef void(^CleanBlock)();

/**
  
 Instead of calling:
 
 [NSURLConnection connectionWithRequest:aRequest delegate:self];
 
 You can instead call: 
 
 [NSURLConnection connectionWithRequest:urlRequest onCompletion:^(NSData* data)
 {
    // Success case
 } onFail:^ (NSError *error){
    // Fail case
 
 }];

 This allow a much cleaner solution and less code.
 **/
@interface NSURLConnection (NSURLConnection_Blocks)

/**
 It will receive a request, a onCompletion block and a onFail block. One of them will be executed
 according to the request's response
 @param request a NSURLRequest
 @param completionBlock Block executed on success
 @param failBlock executed when the connection failed
 @return NSURLConnection* a pointer a NSURLConnection object
 */
+(NSURLConnection*)connectionWithRequest:(NSURLRequest*)request onCompletion:(CompletionBlock)completionBlock onFail:(FailBlock)failBlock;

@end
