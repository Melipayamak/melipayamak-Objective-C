//
//  soapClient.m
//  MeliPayamak
//
//  Created by Amirhossein Mehrvarzi on 4/24/18.
//  Copyright © 2018 MeliPayamak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoapClient.h"

@implementation SoapClient

-(void)SendSimpleSMS2: (NSString *) to
               sender: (NSString *) from
                  msg: (NSString *) message
                flash: (BOOL) isFlash
{
    
    //copy related soap request structure here
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><SendSimpleSMS2 xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><to>%@</to><from>%@</from><text>%@</text><isflash>%@</isflash></SendSimpleSMS2></soap:Body></soap:Envelope>", _username, _password, to, from, message, @"false"];
    //use related webservice url here
    NSString *urlString = @"http://api.payamak-panel.com/post/send.asmx";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    long msgLength = soapMessage.length;
    
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:[NSString stringWithFormat:@"%ld", msgLength] forHTTPHeaderField:@"Content-Length"];
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
    }
    return self;
}


// NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_responseData setLength:0];
}
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"something very bad happened here");
}

// NSXMLParserDelegate
-(void)parser: (NSXMLParser *)parser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict{
    _currentElementName = elementName;
}

-(void)parser: (NSXMLParser *)parser foundCharacters:(nonnull NSString *)string{
    if ([_currentElementName  isEqual: @"SendSimpleSMS2Result"]) { //name of inner <tag> in soap response
        _response = string;
    }
}


- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
//    [connection release]; // setting 'Objective-C Automatic Reference Counting' to YES
    
    NSString* responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    NSLog(@"the response is %@", responseString);
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:_responseData];
    [xmlParser setDelegate:self];
    [xmlParser parse];
    [xmlParser setShouldResolveExternalEntities:true];
    
//    [responseString release]; // setting 'Objective-C Automatic Reference Counting' to YES
}

@end
