//
//  RestClientAsync.m
//  mp_objC
//
//  Created by Amirhossein Mehrvarzi on 11/26/19.
//  Copyright © 2019 Amirhossein Mehrvarzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestClientAsync.h"
#import "RestResponse.h"



@implementation RestClientAsync


-(void)makeRequest:(NSString *)endpoint msg:(NSString *)message {
    
    NSURL *url = [NSURL URLWithString:endpoint];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [theRequest addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[message dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:theRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if(error)
            NSLog(@"error is : %@", error);
        else NSLog(@"response is : %@", response);
    }];
    
}


-(void)Send:(NSString *)to sender:(NSString *)from msg:(NSString *)message flash:(BOOL)isFlash
{
    
    //set parameters
    NSString *msgData = [NSString stringWithFormat:@"username=%@&password=%@&to=%@&from=%@&text=%@&isFlash=%@", _username, _password, to, from, message, isFlash ? @"true" : @"false"];

    [self makeRequest:[_endpoint stringByAppendingString:_sendOp] msg:msgData];
    
}


-(void)SendByBaseNumber:(NSString *)text to:(NSString *)toNum bodyId:(NSInteger)bId
{
    
    //set parameters
    NSString *msgData = [NSString stringWithFormat:@"username=%@&password=%@&text=%@&to=%@&bodyId=%@", _username, _password, text, toNum, bId];
    
    [self makeRequest:[_endpoint stringByAppendingString:_sendByBaseNumberOp] msg:msgData];
}


-(void)GetDelivery: (NSInteger) recId
{
    //set parameters
    NSString *msgData = [NSString stringWithFormat:@"username=%@&password=%@&recID=%@", _username, _password, recId];
    
    [self makeRequest:[_endpoint stringByAppendingString:_getDeliveryOp] msg:msgData];
}


-(void)GetMessages: (NSInteger) location sender: (NSString *) from index: (NSString *) indx count: (NSInteger) cnt
{
    //set parameters
    NSString *msgData = [NSString stringWithFormat:@"username=%@&password=%@&Location=%@&From=%@&Index=%@&Count=%@", _username, _password, location, from, indx, cnt];
    
    [self makeRequest:[_endpoint stringByAppendingString:_getMessagesOp] msg:msgData];
}


-(void)GetCredit
{
    //set parameters
    NSString *msgData = [NSString stringWithFormat:@"username=%@&password=%@", _username, _password];
    
    [self makeRequest:[_endpoint stringByAppendingString:_getCreditOp] msg:msgData];
}


-(void)GetBasePrice
{
    //set parameters
    NSString *msgData = [NSString stringWithFormat:@"username=%@&password=%@", _username, _password];
    
    [self makeRequest:[_endpoint stringByAppendingString:_getBasePriceOp] msg:msgData];
}


-(void)GetUserNumbers
{
    //set parameters
    NSString *msgData = [NSString stringWithFormat:@"username=%@&password=%@", _username, _password];
    
    [self makeRequest:[_endpoint stringByAppendingString:_getUserNumbersOp] msg:msgData];
}

-(id)initCred:(NSString *)aUsername password:(NSString *)aPassword{
    if(self = [super init]){
        _username = aUsername;
        _password = aPassword;
        _responseData = [NSMutableData new];
        //enumerate operation values
        _endpoint = @"https://rest.payamak-panel.com/api/SendSMS/";
        _sendOp = @"SendSMS";
        _sendByBaseNumberOp = @"BaseServiceNumber";
        _getDeliveryOp = @"GetDeliveries2";
        _getMessagesOp = @"GetMessages";
        _getCreditOp = @"GetCredit";
        _getBasePriceOp = @"GetBasePrice";
        _getUserNumbersOp = @"GetUserNumbers";
    }
    return self;
}


@end
