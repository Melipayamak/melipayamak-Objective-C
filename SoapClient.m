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

-(void)initAndSendRequest:(NSString *)endpoint msg:(NSString *)message {
   
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


-(id)initCred:(NSString *)aUsername password:(NSString *)aPassword {
    if(self = [super init]){
        _username = aUsername;
        _password = aPassword;
        _responseData = [NSMutableData new];
        //enumerate endpoints
        self._sendEndpoint = @"http://api.payamak-panel.com/post/send.asmx"
        self._receiveEndpoint = @"http://api.payamak-panel.com/post/receive.asmx"
        self._usersEndpoinself = @"http://api.payamak-panel.com/post/Users.asmx"
        self._contactsEndpoint = @"http://api.payamak-panel.com/post/contacts.asmx"
        self._actionsEndpoint = @"http://api.payamak-panel.com/post/actions.asmx"
        self._scheduleEndpoint = @"http://api.payamak-panel.com/post/Schedule.asmx"
    }
    return self;
}

//Send API Operations

-(void)SendSimpleSMS2: (NSString *) to
                 from: (NSString *) from
                  msg: (NSString *) message
                flash: (BOOL) isFlash {
    
    _sendingElementName = @"SendSimpleSMS2";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];
    //copy related soap request structure here
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><to>%@</to><from>%@</from><text>%@</text><isflash>%@</isflash></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, to, from, message, isFlash ? @"true" : @"false", _sendingElementName];
    
    //use related webservice url here
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)SendSimpleSMS: (NSArray *) to
                from: (NSString *) from
                message: (NSString *) msg
                isFlash: (BOOL) isFlash {

    NSString *sBegin = @"<string>";
    NSString *sEnd = @"</string>";
    NSString *joined_to = [to componentsJoinedByString:@"</string><string>"];
    NSString *_to = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_to, sEnd];

    _sendingElementName = @"SendSimpleSMS";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><to>%@</to><from>%@</from><text>%@</text><isflash>%@</isflash></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _to, from, msg, isFlash ? @"true" : @"false", _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)SendSms: (NSArray *) to
        from: (NSString *) from
        message: (NSString *) msg
        isFlash: (BOOL) isFlash 
        udh: (NSString *) udh
        recid: (NSArray *) recid {

    NSString *sBegin = @"<string>";
    NSString *sEnd = @"</string>";
    NSString *joined_to = [to componentsJoinedByString:@"</string><string>"];
    NSString *_to = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_to, sEnd];

    NSString *iBegin = @"<long>";
    NSString *iEnd = @"</long>";
    NSString *joined_recid = [recid componentsJoinedByString:@"</long><long>"];
    NSString *_recid = [NSString stringWithFormat:@"%@%@%@", iBegin, joined_recid, iEnd];


    _sendingElementName = @"SendSms";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><to>%@</to><from>%@</from><text>%@</text><isflash>%@</isflash><udh>%@</udh><recId>%@</recId><status></status></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _to, from, msg, isFlash ? @"true" : @"false", udh, _recid, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)SendWithDomain: (NSString *) to
        from: (NSString *) from
        message: (NSString *) msg
        isFlash: (BOOL) isFlash 
        domain: (NSString *) domain {

    _sendingElementName = @"SendWithDomain";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><to>%@</to><from>%@</from><text>%@</text><isflash>%@</isflash><domainName>%@</domainName></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, to, from, msg, isFlash ? @"true" : @"false", domain, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)getMessages: (NSInteger) location
        from: (NSString *) from
        index: (NSInteger) index
        count: (NSInteger) count {

    _sendingElementName = @"getMessages";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><from>%@</from><index>%@</index><count>%@</count></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, from, index, count, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)GetSmsPrice: (NSInteger) irancellCount
        from: (NSInteger) mtnCount
        index: (NSString *) from
        count: (NSString *) text {

    _sendingElementName = @"GetSmsPrice";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><irancellCount>%@</irancellCount><mtnCount>%@</mtnCount><from>%@</from><text>%@</text></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, irancellCount, mtnCount, from, text, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)GetMultiDelivery2: (NSString *) recId {

    _sendingElementName = @"GetMultiDelivery2";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><recId>%@</recId></%@></soap:Body></soap:Envelope>", _sendingElementName, recId, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)GetMultiDelivery: (NSString *) recId {

    _sendingElementName = @"GetMultiDelivery";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><recId>%@</recId></%@></soap:Body></soap:Envelope>", _sendingElementName, recId, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)GetInboxCount: (BOOL) isRead {

    _sendingElementName = @"GetInboxCount";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><isRead>%@</isRead></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, isRead ? @"true" : @"false", _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)GetDelivery2: (NSString *) recId {

    _sendingElementName = @"GetDelivery2";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><recId>%@</recId></%@></soap:Body></soap:Envelope>", _sendingElementName, recId, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)GetDelivery: (NSInteger) recId {

    _sendingElementName = @"GetDelivery";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><recId>%@</recId></%@></soap:Body></soap:Envelope>", _sendingElementName, recId, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)GetDeliveries3: (NSArray *) recId {

    NSString *sBegin = @"<string>";
    NSString *sEnd = @"</string>";
    NSString *joined_recId = [recId componentsJoinedByString:@"</string><string>"];
    NSString *_recId = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_recId, sEnd];

    _sendingElementName = @"GetDeliveries3";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><recId>%@</recId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _recId, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}

-(void)GetDeliveries2: (NSString *) recId {

    _sendingElementName = @"GetDeliveries2";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><recId>%@</recId></%@></soap:Body></soap:Envelope>", _sendingElementName, recId, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}   

-(void)GetDeliveries: (NSArray *) recIds {

    NSString *sBegin = @"<long>";
    NSString *sEnd = @"</long>";
    NSString *joined_recIds = [recIds componentsJoinedByString:@"</long><long>"];
    NSString *_recIds = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_recIds, sEnd];

    _sendingElementName = @"GetDeliveries";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><recIds>%@</recIds></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _recIds, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}   

-(void)GetCredit {

    _sendingElementName = @"GetCredit";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}   

//Receive API Operations

-(void)RemoveMessages2 : (NSInteger) location
                msgIds: (NSString *) msgIds {

    _sendingElementName = @"RemoveMessages2";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><msgIds>%@</msgIds></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, msgIds, _sendingElementName];
    [SoapClient initAndSendRequest:self._sendEndpoint msg:soapMessage];    
}
//use Received or Sent or Removed or Deleted for location in the next method
-(void)RemoveMessages : (NSString *) location
                msgIds: (NSString *) msgIds {

    _sendingElementName = @"RemoveMessages";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><msgIds>%@</msgIds></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, msgIds, _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}
-(void)GetUsersMessagesByDate : (NSInteger) location
                        from: (NSString *) from 
                        index: (NSInteger) index
                        count: (NSInteger) count
                        dateFrom: (NSDate *) dateFrom
                        dateTo: (NSDate *) dateTo {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringDateFrom = [formatter stringFromDate:dateFrom];
    NSString *stringDateTo = [formatter stringFromDate:dateTo];

    _sendingElementName = @"GetUsersMessagesByDate";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><from>%@</from><index>%@</index><count>%@</count><dateFrom>%@</dateFrom><dateTo>%@</dateTo></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, from, index, count, stringDateFrom, stringDateTo, _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}
-(void)RemoveMessages : (NSString *) location
                msgIds: (NSString *) msgIds {

    _sendingElementName = @"RemoveMessages";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><msgIds>%@</msgIds></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, msgIds, _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}
-(void)GetOutBoxCount {

    _sendingElementName = @"GetOutBoxCount";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}
-(void)GetMessagesWithChangeIsRead: (NSInteger) location
                                from: (NSString *) from
                                index: (NSInteger) index
                                count: (NSInteger) count
                                isRead: (BOOL) isRead
                                changeIsRead: (BOOL) changeIsRead {

    _sendingElementName = @"GetMessagesWithChangeIsRead";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><from>%@</from><index>%@</index><count>%@</count><isRead>%@</isRead><changeIsRead>%@</changeIsRead></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, from, index, count, isRead ? @"true" : @"false", changeIsRead ? @"true" : @"false", _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}    
-(void)GetMessagesReceptions: (NSInteger) msgId
                       fromRows: (NSInteger) fromRows {

    _sendingElementName = @"GetMessagesReceptions";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><msgId>%@</msgId><fromRows>%@</fromRows></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, from, index, count, isRead ? @"true" : @"false", changeIsRead ? @"true" : @"false", _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}    
-(void)GetMessagesFilterByDate: (NSInteger) location
                        from: (NSString *) from
                       index: (NSInteger) index
                       count: (NSInteger) count
                       dateFrom: (NSDate *) dateFrom
                       dateTo: (NSDate *) dateTo
                       isRead: (BOOL) isRead {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringDateFrom = [formatter stringFromDate:dateFrom];
    NSString *stringDateTo = [formatter stringFromDate:dateTo];

    _sendingElementName = @"GetMessagesFilterByDate";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><from>%@</from><index>%@</index><count>%@</count><dateFrom>%@</dateFrom><dateTo>%@</dateTo><isRead>%@</isRead></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, from, index, count, stringDateFrom, stringDateTo, isRead ? @"true" : @"false", _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}   
-(void)GetMessagesByDate: (NSInteger) location
                        from: (NSString *) from
                       index: (NSInteger) index
                       count: (NSInteger) count
                       dateFrom: (NSDate *) dateFrom
                       dateTo: (NSDate *) dateTo {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringDateFrom = [formatter stringFromDate:dateFrom];
    NSString *stringDateTo = [formatter stringFromDate:dateTo];

    _sendingElementName = @"GetMessagesByDate";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><from>%@</from><index>%@</index><count>%@</count><dateFrom>%@</dateFrom><dateTo>%@</dateTo></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, from, index, count, stringDateFrom, stringDateTo, _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}   
   
-(void)GetMessagesAfterIDJson: (NSInteger) location
                        from: (NSString *) from
                       count: (NSInteger) count
                       msgId: (NSInteger) msgId {

    _sendingElementName = @"GetMessagesAfterIDJson";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><from>%@</from><count>%@</count><msgId>%@</msgId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, from, count, msgId, _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}  
    
-(void)GetMessagesAfterID: (NSInteger) location
                        from: (NSString *) from
                       count: (NSInteger) count
                       msgId: (NSInteger) msgId {

    _sendingElementName = @"GetMessagesAfterID";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><from>%@</from><count>%@</count><msgId>%@</msgId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, from, count, msgId, _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}  
-(void)GetMessages: (NSInteger) location
                        from: (NSString *) from
                        index: (NSInteger) index
                       count: (NSInteger) count {

    _sendingElementName = @"GetMessages";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><from>%@</from><index>%@</index><count>%@</count></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, from, index, count, _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}  
  
-(void)GetMessageStr: (NSInteger) location
                        from: (NSString *) from
                        index: (NSInteger) index
                       count: (NSInteger) count {

    _sendingElementName = @"GetMessageStr";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><location>%@</location><from>%@</from><index>%@</index><count>%@</count></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, location, from, index, count, _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}    
-(void)GetInboxCount: (BOOL) isRead {

    _sendingElementName = @"GetInboxCount";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><isRead>%@</isRead></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, isRead ? @"true" : @"false", _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}  
-(void)ChangeMessageIsRead: (NSString *) msgIds {

    _sendingElementName = @"ChangeMessageIsRead";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><msgIds>%@</msgIds></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, msgIds, _sendingElementName];
    [SoapClient initAndSendRequest:self._receiveEndpoint msg:soapMessage];    
}  


//Users API Operations
-(void)AddPayment: (NSString *) name
                family: (NSString *) family
                bankName: (NSString *) bankName
                code: (NSString *) code
                amount: (NSInteger) amount
                cardNumber: (NSString *) cardNumber {

    _sendingElementName = @"AddPayment";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><name>%@</name><family>%@</family><bankName>%@</bankName><code>%@</code><amount>%@</amount><cardNumber>%@</cardNumber></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, name, family, bankName, code, amount, cardNumber, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  

-(void)AddUser: (NSInteger) productId
        descriptions: (NSString *) descriptions
        mobileNumber: (NSString *) mobileNumber
        emailAddress: (NSString *) emailAddress
        nationalCode: (NSString *) nationalCode
        name: (NSString *) name
        family: (NSString *) family
        corporation: (NSString *) corporation
        phone: (NSString *) phone
        fax: (NSString *) fax
        address: (NSString *) address
        postalCode: (NSString *) postalCode
        certificateNumber: (NSString *) certificateNumber {

    _sendingElementName = @"AddUser";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><productId>%@</productId><descriptions>%@</descriptions><mobileNumber>%@</mobileNumber><emailAddress>%@</emailAddress><nationalCode>%@</nationalCode><name>%@</name><family>%@</family><corporation>%@</corporation><phone>%@</phone><fax>%@</fax><address>%@</address><postalCode>%@</postalCode><certificateNumber>%@</certificateNumber></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, productId, descriptions, mobileNumber, emailAddress, nationalCode, name, family, corporation, phone, fax, address, postalCode, certificateNumber, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)AddUserComplete: (NSInteger) productId
        descriptions: (NSString *) descriptions
        mobileNumber: (NSString *) mobileNumber
        emailAddress: (NSString *) emailAddress
        nationalCode: (NSString *) nationalCode
        name: (NSString *) name
        family: (NSString *) family
        corporation: (NSString *) corporation
        phone: (NSString *) phone
        fax: (NSString *) fax
        address: (NSString *) address
        postalCode: (NSString *) postalCode
        certificateNumber: (NSString *) certificateNumber
        country: (NSInteger) country
        province: (NSInteger) province
        city: (NSInteger) city
        howFindUs: (NSString *) howFindUs
        commercialCode: (NSString *) commercialCode
        saleId: (NSString *) saleId
        recommanderId: (NSString *) recommanderId {

    _sendingElementName = @"AddUserComplete";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><productId>%@</productId><descriptions>%@</descriptions><mobileNumber>%@</mobileNumber><emailAddress>%@</emailAddress><nationalCode>%@</nationalCode><name>%@</name><family>%@</family><corporation>%@</corporation><phone>%@</phone><fax>%@</fax><address>%@</address><postalCode>%@</postalCode><certificateNumber>%@</certificateNumber><country>%@</country><province>%@</province><city>%@</city><howFindUs>%@</howFindUs><commercialCode>%@</commercialCode><saleId>%@</saleId><recommanderId>%@</recommanderId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, productId, descriptions, mobileNumber, emailAddress, nationalCode, name, family, corporation, phone, fax, address, postalCode, certificateNumber, country, province, city, howFindUs, commercialCode, saleId, recommanderId, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
} 
-(void)AddUserWithLocation: (NSInteger) productId
        descriptions: (NSString *) descriptions
        mobileNumber: (NSString *) mobileNumber
        emailAddress: (NSString *) emailAddress
        nationalCode: (NSString *) nationalCode
        name: (NSString *) name
        family: (NSString *) family
        corporation: (NSString *) corporation
        phone: (NSString *) phone
        fax: (NSString *) fax
        address: (NSString *) address
        postalCode: (NSString *) postalCode
        certificateNumber: (NSString *) certificateNumber
        country: (NSInteger) country
        province: (NSInteger) province
        city: (NSInteger) city {

    _sendingElementName = @"AddUserWithLocation";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><productId>%@</productId><descriptions>%@</descriptions><mobileNumber>%@</mobileNumber><emailAddress>%@</emailAddress><nationalCode>%@</nationalCode><name>%@</name><family>%@</family><corporation>%@</corporation><phone>%@</phone><fax>%@</fax><address>%@</address><postalCode>%@</postalCode><certificateNumber>%@</certificateNumber><country>%@</country><province>%@</province><city>%@</city></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, productId, descriptions, mobileNumber, emailAddress, nationalCode, name, family, corporation, phone, fax, address, postalCode, certificateNumber, country, province, city, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)AddUserWithMobileNumber: (NSInteger) productId
        mobileNumber: (NSString *) mobileNumber
        firstname: (NSString *) firstname
        lastname: (NSString *) lastname
        email: (NSString *) email {

    _sendingElementName = @"AddUserWithMobileNumber";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><productId>%@</productId><mobileNumber>%@</mobileNumber><firstName>%@</firstName><lastName>%@</lastName><email>%@</email></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, productId, mobileNumber, firstname, lastname, email, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  

-(void)AddUserWithUserNameAndPass: (NSString *) targetUserName
        targetUserPassword: (NSString *) targetUserPassword
        productId: (NSInteger) productId
        descriptions: (NSString *) descriptions
        mobileNumber: (NSString *) mobileNumber
        emailAddress: (NSString *) emailAddress
        nationalCode: (NSString *) nationalCode
        name: (NSString *) name
        family: (NSString *) family
        corporation: (NSString *) corporation
        phone: (NSString *) phone
        fax: (NSString *) fax
        address: (NSString *) address
        postalCode: (NSString *) postalCode
        certificateNumber: (NSString *) certificateNumber {

    _sendingElementName = @"AddUserWithUserNameAndPass";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><targetUserName>%@</targetUserName><targetUserPassword>%@</targetUserPassword><productId>%@</productId><descriptions>%@</descriptions><mobileNumber>%@</mobileNumber><emailAddress>%@</emailAddress><nationalCode>%@</nationalCode><name>%@</name><family>%@</family><corporation>%@</corporation><phone>%@</phone><fax>%@</fax><address>%@</address><postalCode>%@</postalCode><certificateNumber>%@</certificateNumber></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, targetUserName, targetUserPassword, productId, descriptions, mobileNumber, emailAddress, nationalCode, name, family, corporation, phone, fax, address, postalCode, certificateNumber, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)AuthenticateUser {

    _sendingElementName = @"AuthenticateUser";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)ChangeUserCredit: (NSInteger) amount
                description: (NSString *) description
                targetUsername: (NSString *) targetUsername
                GetTax: (BOOL) GetTax {

    _sendingElementName = @"ChangeUserCredit";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><amount>%@</amount><description>%@</description><targetUsername>%@</targetUsername><GetTax>%@</GetTax></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, amount, description, targetUsername, GetTax ? @"true" : @"false",_sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)ChangeUserCredit2: (NSInteger) amount
                description: (NSString *) description
                targetUsername: (NSString *) targetUsername
                GetTax: (BOOL) GetTax {

    _sendingElementName = @"ChangeUserCredit2";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><amount>%@</amount><description>%@</description><targetUsername>%@</targetUsername><GetTax>%@</GetTax></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, amount, description, targetUsername, GetTax ? @"true" : @"false" ,_sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)ChangeUserCreditBySeccondPass: (NSString *) ausername
                secondPassword: (NSString *) secondPassword
                amount: (NSInteger) amount
                description: (NSString *) description
                targetUsername: (NSString *) targetUsername
                GetTax: (BOOL) GetTax {

    _sendingElementName = @"ChangeUserCreditBySeccondPass";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><seccondPassword>%@</seccondPassword><amount>%@</amount><description>%@</description><targetUsername>%@</targetUsername><GetTax>%@</GetTax></%@></soap:Body></soap:Envelope>", _sendingElementName, ausername, secondPassword, amount, description, targetUsername, GetTax ? @"true" : @"false",_sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)DeductUserCredit: (NSString *) ausername
                apassword: (NSString *) apassword
                amount: (NSInteger) amount
                description: (NSString *) description {

    _sendingElementName = @"DeductUserCredit";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><amount>%@</amount><description>%@</description></%@></soap:Body></soap:Envelope>", _sendingElementName, ausername, apassword, amount, description,_sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)ForgotPassword: (NSString *) mobileNumber
                emailAddress: (NSString *) emailAddress
                targetUsername: (NSString *) targetUsername {

    _sendingElementName = @"ForgotPassword";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><mobileNumber>%@</mobileNumber><emailAddress>%@</emailAddress><targetUsername>%@</targetUsername></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, mobileNumber, emailAddress, targetUsername,_sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)GetCities: (NSInteger) provinceId {
    _sendingElementName = @"GetCities";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><provinceId>%@</provinceId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, provinceId, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
} 
-(void)GetEnExpireDate {
    _sendingElementName = @"GetEnExpireDate";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)GetExpireDate {
    _sendingElementName = @"GetExpireDate";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}
-(void)GetProvinces {
    _sendingElementName = @"GetProvinces";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}
-(void)GetUserBasePrice: (NSString *) targetUsername {
    _sendingElementName = @"GetUserBasePrice";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><targetUsername>%@</targetUsername></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, targetUsername, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}
   
-(void)GetUserByUserID: (NSString *) pass
                userId: (NSInteger) userId {
    _sendingElementName = @"GetUserByUserID";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><pass>%@</pass><userId>%@</userId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, pass, userId, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}
 
-(void)GetUserCredit: (NSString *) targetUsername {
    _sendingElementName = @"GetUserCredit";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><targetUsername>%@</targetUsername></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, targetUsername, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)GetUserCreditBySecondPass: (NSString *) secondPassword 
                targetUsername: (NSString *) targetUsername {
    _sendingElementName = @"GetUserCreditBySecondPass";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><secondPassword>%@</secondPassword><targetUsername>%@</targetUsername></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, secondPassword, targetUsername, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  

-(void)GetUserDetails: (NSString *) targetUsername {
    _sendingElementName = @"GetUserDetails";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><targetUsername>%@</targetUsername></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, targetUsername, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)GetUserIsExist: (NSString *) targetUsername {
    _sendingElementName = @"GetUserIsExist";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><targetUsername>%@</targetUsername></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, targetUsername, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}  
-(void)GetUserNumbers {
    _sendingElementName = @"GetUserNumbers";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
} 
-(void)GetUserTransactions: (NSString *) targetUsername
                    creditType: (NSString *) creditType
                    dateFrom: (NSDate *) dateFrom
                    dateTo: (NSDate *) dateTo
                    keyword: (NSString *) keyword {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringDateFrom = [formatter stringFromDate:dateFrom];
    NSString *stringDateTo = [formatter stringFromDate:dateTo];

    _sendingElementName = @"GetUserTransactions";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><targetUsername>%@</targetUsername><creditType>%@</creditType><dateFrom>%@</dateFrom><dateTo>%@</dateTo><keyword>%@</keyword></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, targetUsername, creditType, stringDateFrom, stringDateTo, keyword, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
}   
-(void)GetUserWallet {
    _sendingElementName = @"GetUserWallet";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
} 
-(void)GetUserWalletTransaction: (NSDate *) dateFrom
                    dateTo: (NSDate *) dateTo
                    count: (NSInteger) count
                    startIndex: (NSInteger) startIndex
                    payType: (NSString *) payType
                    payLoc: (NSString *) payLoc {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringDateFrom = [formatter stringFromDate:dateFrom];
    NSString *stringDateTo = [formatter stringFromDate:dateTo];

    _sendingElementName = @"GetUserWalletTransaction";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><dateFrom>%@</dateFrom><dateTo>%@</dateTo><count>%@</count><startIndex>%@</startIndex><payType>%@</payType><payLoc>%@</payLoc></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, stringDateFrom, stringDateTo, count, startIndex, payType, payLoc, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
} 
-(void)GetUsers {
    _sendingElementName = @"GetUsers";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
} 
-(void)HasFilter: (NSString *) text {
    _sendingElementName = @"HasFilter";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><text>%@</text></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, text, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
} 

-(void)RemoveUser: (NSString *) targetUsername {
    _sendingElementName = @"RemoveUser";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><targetUsername>%@</targetUsername></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, targetUsername, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
} 
-(void)RevivalUser: (NSString *) targetUsername {
    _sendingElementName = @"RevivalUser";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><targetUsername>%@</targetUsername></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, targetUsername, _sendingElementName];
    [SoapClient initAndSendRequest:self._usersEndpoint msg:soapMessage];    
} 


//Contact API Operations
-(void)AddContact: (NSString *) groupIds
                firstname: (NSString *) firstname
                lastname: (NSString *) lastname
                nickname: (NSString *) nickname
                corporation: (NSString *) corporation
                mobilenumber: (NSString *) mobilenumber
                phone: (NSString *) phone
                fax: (NSString *) fax
                birthdate: (NSDate *) birthdate
                email: (NSString *) email
                gender: (NSData *) gender
                province: (NSInteger) province
                city: (NSInteger) city
                address: (NSString *) address
                postalCode: (NSString *) postalCode
                additionaldate: (NSDate *) additionaldate
                additionaltext: (NSString *) additionaltext
                descriptions: (NSString *) descriptions {


    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *bdate = [formatter stringFromDate:birthdate];
    NSString *adddate = [formatter stringFromDate:additionaldate];

    _sendingElementName = @"AddContact";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><groupIds>%@</groupIds><firstname>%@</firstname><lastname>%@</lastname><nickname>%@</nickname><corporation>%@</corporation><mobilenumber>%@</mobilenumber><phone>%@</phone><fax>%@</fax><birthdate>%@</birthdate><email>%@</email><gender>%@</gender><province>%@</province><city>%@</city><address>%@</address><postalCode>%@</postalCode><additionaldate>%@</additionaldate><additionaltext>%@</additionaltext><descriptions>%@</descriptions></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, groupIds, firstname, lastname, nickname, corporation, mobilenumber, phone, fax, bdate, email, gender, province, city, address, postalCode, adddate, additionaltext, descriptions, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
-(void)AddContactEvents: (NSInteger) contactId
                    eventName: (NSString *) eventName
                    eventType: (NSData *) eventType
                    eventDate: (NSDate *) eventDate {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringEDate = [formatter stringFromDate:eventDate];

    _sendingElementName = @"AddContactEvents";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><contactId>%@</contactId><eventName>%@</eventName><eventDate>%@</eventDate><eventType>%@</eventType></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, contactId, eventName, stringEDate, eventType, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
-(void)AddGroup: (NSString *) groupName
                    Descriptions: (NSString *) Descriptions
                    showToChilds: (BOOL) showToChilds {
    _sendingElementName = @"AddGroup";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><groupName>%@</groupName><Descriptions>%@</Descriptions><showToChilds>%@</showToChilds></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, groupName, Descriptions, showToChilds ? @"true" : @"false", _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 

-(void)ChangeContact: (NSInteger) contactId
                    mobilenumber: (NSString *) mobilenumber
                    firstname: (NSString *) firstname
                    lastname: (NSString *) lastname
                    nickname: (NSString *) nickname
                    corporation: (NSString *) corporation
                    phone: (NSString *) phone
                    fax: (NSString *) fax
                    email: (NSString *) email
                    gender: (NSData *) gender
                    province: (NSInteger) province
                    city: (NSInteger) city
                    address: (NSString *) address
                    postalCode: (NSString *) postalCode
                    additionaltext: (NSString *) additionaltext
                    descriptions: (NSString *) descriptions
                    contactStatus: (NSInteger) contactStatus {
    _sendingElementName = @"ChangeContact";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><contactId>%@</contactId><mobilenumber>%@</mobilenumber><firstname>%@</firstname><lastName>%@</lastname><nickname>%@</nickname><corporation>%@</corporation><phone>%@</phone><fax>%@</fax><email>%@</email><gender>%@</gender><province>%@</province><city>%@</city><address>%@</address><postalCode>%@</postalCode><additionaltext>%@</additionaltext><descriptions>%@</descriptions><contactStatus>%@</contactStatus></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, contactId, mobilenumber, firstname, lastname, nickname, corporation, phone, fax, email,gender, province, city, address, postalCode, additionaltext, descriptions, contactStatus, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
    
-(void)ChangeGroup: (NSInteger) groupId
                    groupName: (NSString *) groupName
                    Descriptions: (NSString *) Descriptions
                    showToChilds: (BOOL) showToChilds
                    groupStatus: (NSData *) groupStatus {
    _sendingElementName = @"ChangeGroup";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><groupId>%@</groupId><groupName>%@</groupName><Descriptions>%@</Descriptions><showToChilds>%@</showToChilds><groupStatus>%@</groupStatus></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, groupId, groupName, Descriptions, showToChilds ? "true" : "false", groupStatus, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
-(void)CheckMobileExistInContact: (NSString *) mobileNumber {
    _sendingElementName = @"CheckMobileExistInContact";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><mobileNumber>%@</mobileNumber></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, mobileNumber, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
-(void)GetContactEvents: (NSInteger) contactId {
    _sendingElementName = @"GetContactEvents";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><contactId>%@</contactId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, contactId, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
-(void)GetContacts: (NSInteger) groupId
                keyword: (NSString *) keyword
                from: (NSInteger) from
                count: (NSInteger) count {
    _sendingElementName = @"GetContacts";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><groupId>%@</groupId><keyword>%@</keyword><from>%@</from><count>%@</count></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, groupId, keyword, from, count, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
-(void)GetContactsByID: (NSInteger) contactId
                status: (NSInteger) status {
    _sendingElementName = @"GetContactsByID";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><contactId>%@</contactId><status>%@</status></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, contactId, status, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
-(void)GetGroups {
    _sendingElementName = @"GetGroups";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
-(void)MergeGroups: (NSInteger) originGroupId
            destinationGroupId: (NSInteger) destinationGroupId
            deleteOriginGroup: (BOOL) deleteOriginGroup {
    _sendingElementName = @"MergeGroups";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><originGroupId>%@</originGroupId><destinationGroupId>%@</destinationGroupId><deleteOriginGroup>%@</deleteOriginGroup></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, originGroupId, destinationGroupId, deleteOriginGroup ? @"true" : @"false", _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
-(void)RemoveContact: (NSString *) mobilenumber {
    _sendingElementName = @"RemoveContact";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><mobilenumber>%@</mobilenumber></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, mobilenumber, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
-(void)RemoveContactByContactID: (NSInteger) contactId {
    _sendingElementName = @"RemoveContactByContactID";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><contactId>%@</contactId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, contactId, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 
-(void)RemoveGroup: (NSInteger) groupId {
    _sendingElementName = @"RemoveGroup";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><groupId>%@</groupId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, groupId, _sendingElementName];
    [SoapClient initAndSendRequest:self._contactsEndpoint msg:soapMessage];    
} 

//ACtions API Operations
-(void)AddBranch: (NSString *) branchName
                owner: (NSInteger) owner {
    _sendingElementName = @"AddBranch";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><branchName>%@</branchName><owner>%@</owner></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, branchName, owner, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
} 
-(void)AddBulk: (NSString *) from
            branch: (NSInteger) branch
            bulkType: (NSData *) bulkType
            title: (NSString *) title
            message: (NSString *) message
            rangeFrom: (NSString *) rangeFrom
            rangeTo: (NSString *) rangeTo
            DateToSend: (NSDate *) DateToSend
            requestCount: (NSInteger) requestCount
            rowFrom: (NSInteger) rowFrom {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringDateToSend = [formatter stringFromDate:DateToSend];

    _sendingElementName = @"AddBulk";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><from>%@</from><branch>%@</branch><bulkType>%@</bulkType><title>%@</title><message>%@</message><rangeFrom>%@</rangeFrom><rangeTo>%@</rangeTo><DateToSend>%@</DateToSend><requestCount>%@</requestCount><rowFrom>%@</rowFrom></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, from, branch, bulkType, title, message, rangeFrom, rangeTo, stringDateToSend, requestCount, rowFrom, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}     
-(void)AddBulk2: (NSString *) from
            branch: (NSInteger) branch
            bulkType: (NSData *) bulkType
            title: (NSString *) title
            message: (NSString *) message
            rangeFrom: (NSString *) rangeFrom
            rangeTo: (NSString *) rangeTo
            DateToSend: (NSString *) DateToSend
            requestCount: (NSInteger) requestCount
            rowFrom: (NSInteger) rowFrom {
    _sendingElementName = @"AddBulk2";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><from>%@</from><branch>%@</branch><bulkType>%@</bulkType><title>%@</title><message>%@</message><rangeFrom>%@</rangeFrom><rangeTo>%@</rangeTo><DateToSend>%@</DateToSend><requestCount>%@</requestCount><rowFrom>%@</rowFrom></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, from, branch, bulkType, title, message, rangeFrom, rangeTo, DateToSend, requestCount, rowFrom, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}  
-(void)AddNewBulk: (NSString *) from
            branch: (NSInteger) branch
            bulkType: (NSData *) bulkType
            title: (NSString *) title
            message: (NSString *) message
            rangeFrom: (NSString *) rangeFrom
            rangeTo: (NSString *) rangeTo
            DateToSend: (NSDate *) DateToSend
            requestCount: (NSInteger) requestCount
            rowFrom: (NSInteger) rowFrom {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringDateToSend = [formatter stringFromDate:DateToSend];

    _sendingElementName = @"AddNewBulk";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><from>%@</from><branch>%@</branch><bulkType>%@</bulkType><title>%@</title><message>%@</message><rangeFrom>%@</rangeFrom><rangeTo>%@</rangeTo><DateToSend>%@</DateToSend><requestCount>%@</requestCount><rowFrom>%@</rowFrom></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, from, branch, bulkType, title, message, rangeFrom, rangeTo, stringDateToSend, requestCount, rowFrom, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}  

-(void)AddNumber: (NSInteger) branchId
        mobileNumbers: (NSArray *) mobileNumbers {

    NSString *sBegin = @"<string>";
    NSString *sEnd = @"</string>";
    NSString *joined_numbers = [mobileNumbers componentsJoinedByString:@"</string><string>"];
    NSString *_mobileNumbers = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_numbers, sEnd];

    _sendingElementName = @"AddNumber";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><branchId>%@</branchId><mobileNumbers>%@</mobileNumbers></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, branchId, _mobileNumbers, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
} 
-(void)GetBranchs: (NSInteger) owner {
    _sendingElementName = @"GetBranchs";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><owner>%@</owner></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, owner, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)GetBulk {
    _sendingElementName = @"GetBulk";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)GetBulkCount: (NSInteger) branch
                rangeFrom: (NSString *) rangeFrom
                rangeTo: (NSString *) rangeTo {
    _sendingElementName = @"GetBulkCount";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><rangeFrom>%@</rangeFrom><rangeTo>%@</rangeTo></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, rangeFrom, rangeTo, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)GetBulkReceptions: (NSInteger) bulkId
                fromRows: (NSInteger) fromRows {
    _sendingElementName = @"GetBulkReceptions";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><bulkId>%@</bulkId><fromRows>%@</fromRows></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, bulkId, fromRows, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)GetBulkStatus: (NSInteger) bulkId
                sent: (NSInteger) sent
                failed: (NSInteger) failed
                status: (NSData *) status {
    _sendingElementName = @"GetBulkStatus";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><bulkId>%@</bulkId><sent>%@</sent><failed>%@</failed><status>%@</status></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, bulkId, sent, failed, status, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)GetMessagesReceptions: (NSInteger) msgId
                fromRows: (NSInteger) fromRows {
    _sendingElementName = @"GetMessagesReceptions";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><msgId>%@</msgId><fromRows>%@</fromRows></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, msgId, fromRows, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)GetMobileCount: (NSInteger) branch
                rangeFrom: (NSString *) rangeFrom
                rangeTo: (NSString *) rangeTo {
    _sendingElementName = @"GetMobileCount";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><branch>%@</branch><rangeFrom>%@</rangeFrom><rangeTo>%@</rangeTo></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, branch, rangeFrom, rangeTo, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)GetSendBulk {
    _sendingElementName = @"GetSendBulk";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)GetTodaySent {
    _sendingElementName = @"GetTodaySent";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)GetTotalSent {
    _sendingElementName = @"GetTotalSent";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)RemoveBranch: (NSInteger) branchId {
    _sendingElementName = @"RemoveBranch";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><branchId>%@</branchId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, branchId, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)RemoveBulk: (NSInteger) bulkId {
    _sendingElementName = @"RemoveBulk";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><bulkId>%@</bulkId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, bulkId, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
 
-(void)SendMultipleSMS: (NSArray *) to
                    from: (NSString *) from
                    text: (NSArray *) text
                    isflash: (BOOL) isflash
                    udh: (NSString *) udh
                    recId: (NSArray *) recId
                    status: (NSString *) status {
    NSString *sBegin = @"<string>";
    NSString *sEnd = @"</string>";

    NSString *iBegin = @"<long>";
    NSString *iEnd = @"</long>";
    
    NSString *joined_to = [to componentsJoinedByString:@"</string><string>"];
    NSString *_to = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_to, sEnd];

    NSString *joined_text = [text componentsJoinedByString:@"<string></string>"];
    NSString *_text = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_text, sEnd];

    NSString *joined_recid = [recId componentsJoinedByString:@"<long></long>"];
    NSString *_recId = [NSString stringWithFormat:@"%@%@%@", iBegin, joined_recid, iEnd];

    _sendingElementName = @"SendMultipleSMS";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><to>%@</to><from>%@</from><text>%@</text><isflash>%@</isflash><udh>%@</udh><recId>%@</recId><status>%@</status></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _to, from, _text, isflash ? @"true" : @"false", udh, _recId, status, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)SendMultipleSMS2: (NSArray *) to
                    from: (NSArray *) from
                    text: (NSArray *) text
                    isflash: (BOOL) isflash
                    udh: (NSString *) udh
                    recId: (NSArray *) recId
                    status: (NSString *) status {

    NSString *sBegin = @"<string>";
    NSString *sEnd = @"</string>";
    NSString *iBegin = @"<long>";
    NSString *iEnd = @"</long>";
    NSString *joined_to = [to componentsJoinedByString:@"</string><string>"];
    NSString *_to = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_to, sEnd];

    NSString *joined_from = [from componentsJoinedByString:@"</string><string>"];
    NSString *_from = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_from, sEnd];

    NSString *joined_text = [text componentsJoinedByString:@"</string><string>"];
    NSString *_text = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_text, sEnd];

    NSString *joined_recid = [recId componentsJoinedByString:@"</long><long>"];
    NSString *_recId = [NSString stringWithFormat:@"%@%@%@", iBegin, joined_recid, iEnd];


    _sendingElementName = @"SendMultipleSMS2";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><to>%@</to><from>%@</from><text>%@</text><isflash>%@</isflash><udh>%@</udh><recId>%@</recId><status>%@</status></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _to, _from, _text, isflash ? @"true" : @"false", udh, _recId, status, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}
-(void)UpdateBulkDelivery: (NSInteger) bulkId {
    _sendingElementName = @"UpdateBulkDelivery";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><bulkId>%@</bulkId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, bulkId, _sendingElementName];
    [SoapClient initAndSendRequest:self._actionsEndpoint msg:soapMessage];    
}

//Schedule API Operations
-(void)AddMultipleSchedule: (NSArray *) to
                    from: (NSString *) from
                    text: (NSArray *) text
                    isflash: (BOOL) isflash
                    scheduleDateTime: (NSDate *) scheduleDateTime
                    period: (NSString *) period {


    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringSch = [formatter stringFromDate:scheduleDateTime];

    NSString *sBegin = @"<string>";
    NSString *sEnd = @"</string>";
    NSString *joined_to = [to componentsJoinedByString:@"</string><string>"];
    NSString *_to = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_to, sEnd];

    NSString *joined_text = [text componentsJoinedByString:@"</string><string>"];
    NSString *_text = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_text, sEnd];

    _sendingElementName = @"AddMultipleSchedule";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><to>%@</to><from>%@</from><text>%@</text><isflash>%@</isflash><scheduleDateTime>%@</scheduleDateTime><period>%@</period></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, to, from, text, isflash ? @"true" : @"false", stringSch, period, _sendingElementName];
    [SoapClient initAndSendRequest:self._scheduleEndpoint msg:soapMessage];    
} 
-(void)AddNewUsance: (NSString *) to
                    from: (NSString *) from
                    text: (NSString *) text
                    isflash: (BOOL) isflash
                    scheduleDateTime: (NSDate *) scheduleDateTime
                    countrepeat: (NSInteger) countrepeat
                    scheduleEndDateTime: (NSDate *) scheduleEndDateTime
                    periodType: (NSString *) periodType {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringDateTime = [formatter stringFromDate:scheduleDateTime];
    NSString *stringEndDateTime = [formatter stringFromDate:scheduleEndDateTime];

    _sendingElementName = @"AddNewUsance";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><to>%@</to><from>%@</from><text>%@</text><isflash>%@</isflash><scheduleStartDateTime>%@</scheduleStartDateTime><countrepeat>%@</countrepeat><periodType>%@</periodType></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, to, from, text, isflash ? @"true" : @"false", stringDateTime, countrepeat, stringEndDateTime, periodType, _sendingElementName];
    [SoapClient initAndSendRequest:self._scheduleEndpoint msg:soapMessage];    
} 
-(void)AddSchedule: (NSString *) to
                    from: (NSString *) from
                    text: (NSString *) text
                    isflash: (BOOL) isflash
                    scheduleDateTime: (NSDate *) scheduleDateTime
                    period: (NSString *) period {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringDateTime = [formatter stringFromDate:scheduleDateTime];

    _sendingElementName = @"AddSchedule";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><to>%@</to><from>%@</from><text>%@</text><isflash>%@</isflash><scheduleDateTime>%@</scheduleDateTime><period>%@</period></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, to, from, text, isflash ? @"true" : @"false", stringDateTime, period, _sendingElementName];
    [SoapClient initAndSendRequest:self._scheduleEndpoint msg:soapMessage];    
}    
-(void)AddUsance: (NSString *) to
                    from: (NSString *) from
                    text: (NSString *) text
                    isflash: (BOOL) isflash
                    scheduleStartDateTime: (NSDate *) scheduleStartDateTime
                    repeatAfterDays: (NSInteger *) repeatAfterDays
                    scheduleEndDateTime: (NSDate *) scheduleEndDateTime {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];//use relative format here

    //Optionally for time zone conversions
    // [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];

    NSString *stringSDate = [formatter stringFromDate:scheduleStartDateTime];
    NSString *stringEDate = [formatter stringFromDate:scheduleEndDateTime];

    _sendingElementName = @"AddUsance";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><to>%@</to><from>%@</from><text>%@</text><isflash>%@</isflash><scheduleStartDateTime>%@</scheduleStartDateTime><repeatAfterDays>%@</repeatAfterDays><scheduleEndDateTime>%@</scheduleEndDateTime></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, to, from, text, isflash ? @"true" : @"false", stringSDate, repeatAfterDays, stringEDate, _sendingElementName];
    [SoapClient initAndSendRequest:self._scheduleEndpoint msg:soapMessage];    
}   

-(void)GetScheduleStatus: (NSInteger) scheduleId {
    _sendingElementName = @"GetScheduleStatus";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><scheduleId>%@</scheduleId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, scheduleId, _sendingElementName];
    [SoapClient initAndSendRequest:self._scheduleEndpoint msg:soapMessage];    
}   

-(void)RemoveSchedule: (NSInteger) scheduleId {
    _sendingElementName = @"RemoveSchedule";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><scheduleId>%@</scheduleId></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, scheduleId, _sendingElementName];
    [SoapClient initAndSendRequest:self._scheduleEndpoint msg:soapMessage];    
}  
-(void)RemoveScheduleList: (NSArray *) scheduleIdList {

    NSString *sBegin = @"<string>";
    NSString *sEnd = @"</string>";
    NSString *joined_sc = [scheduleIdList componentsJoinedByString:@"</string><string>"];
    NSString *_sch = [NSString stringWithFormat:@"%@%@%@", sBegin, joined_sc, sEnd];

    _sendingElementName = @"RemoveScheduleList";
    _expectedElementName = [_sendingElementName stringByAppendingString:@"Response"];

    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><%@ xmlns='http://tempuri.org/'><username>%@</username><password>%@</password><scheduleIdList>%@</scheduleIdList></%@></soap:Body></soap:Envelope>", _sendingElementName, _username, _password, _sch, _sendingElementName];
    [SoapClient initAndSendRequest:self._scheduleEndpoint msg:soapMessage];    
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
