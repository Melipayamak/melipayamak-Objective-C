//
//  RestClient.m
//  mp_objC
//
//  Created by Amirhossein Mehrvarzi on 4/25/18.
//  Copyright © 2018 Amirhossein Mehrvarzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestClient.h"

@implementation RestClient

-(void)Send:(NSString *)to sender:(NSString *)from msg:(NSString *)message flash:(BOOL)isFlash
{
    
    //set parameters
    NSString *soapMessage = [NSString stringWithFormat:@"username=%@&password=%@&to=%@&from=%@&text=%@&isFlash=%@", _username, _password, to, from, message, isFlash ? @"true" : @"false"];
    
    NSURL *url = [NSURL URLWithString:[_endpoint stringByAppendingString:_sendOp]];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [theRequest addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [connection start];
    
}

-(id)initCred:(NSString *)aUsername password:(NSString *)aPassword{
    if(self = [super init]){
        _username = aUsername;
        _password = aPassword;
        _responseData = [NSMutableData new];
        //enumerate operation values
        _endpoint = @"https://rest.payamak-panel.com/api/SendSMS/";
        
        _sendOp = @"SendSMS";
        _getDeliveryOp = @"GetDeliveries2";
        _getMessagesOp = @"GetMessages";
        _getCreditOp = @"GetCredit";
        _getBasePriceOp = @"GetBasePrice";
        _getUserNumbersOp = @"GetUserNumbers";
    }
    return self;
}


// NSURLConnectionDelegate
// NSURL

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_responseData setLength:0];
}
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"something very bad happened here");
}


- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    //    [connection release]; // setting 'Objective-C Automatic Reference Counting' to YES
    
//    NSString* responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"the response is %@", responseString);
    RestResponse *response = [[RestResponse alloc] init: _responseData];
    NSLog(@"response memeber is : %@", response.RetStatus);
  
    //    [responseString release]; // setting 'Objective-C Automatic Reference Counting' to YES
}

@end



@implementation RestResponse


-(id)init:(NSData *)mutableData{
    
    self = [super init];
    
//    let JSONDictionary = try? JSONSerialization.jsonObject(with: mutableData as Data, options: []) as! Dictionary<String, AnyObject>
    NSError *error;
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:mutableData options:NSJSONReadingAllowFragments error:&error] ;
    
    [self setValuesForKeysWithDictionary:JSONDictionary];
    // Loop
//    for (key, value) in JSONDictionary! {
//        let keyName = key as String
//        
//        let keyValue: String = String(describing: value)
//        
//        // If property exists
//        if (self.responds(to: NSSelectorFromString(keyName))) {
//            self.setValue(keyValue, forKey: keyName)
//        }
//    }
    // Or you can do it with using
    // self.setValuesForKeysWithDictionary(JSONDictionary)
    // instead of loop method above
    return self;
}

@end