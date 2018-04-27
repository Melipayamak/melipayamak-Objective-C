//
//  RestClient.h
//  mp_objC
//
//  Created by Amirhossein Mehrvarzi on 4/25/18.
//  Copyright © 2018 Amirhossein Mehrvarzi. All rights reserved.
//

#ifndef RestClient_h
#define RestClient_h


#endif /* RestClient_h */

@interface RestClient : NSObject

@property NSMutableData *responseData;
@property NSString *response;

@property NSString *endpoint;//"https://rest.payamak-panel.com/api/SendSMS/"

@property NSString *sendOp;//"SendSMS"
@property NSString *getDeliveryOp;//"GetDeliveries2"
@property NSString *getMessagesOp;//"GetMessages"
@property NSString *getCreditOp;//"GetCredit"
@property NSString *getBasePriceOp;//"GetBasePrice"
@property NSString *getUserNumbersOp;//"GetUserNumbers"

@property NSString *username;
@property NSString *password;

-(void)Send: (NSString *) to
               sender: (NSString *) from
                  msg: (NSString *) message
                flash: (BOOL) isFlash;

-(id)initCred:(NSString *)aUsername
     password:(NSString *)aPassword;

@end

//response class
@interface RestResponse : NSObject

@property NSString *Value;
@property NSString *RetStatus;
@property NSString *StrRetStatus;

-(id)init:(NSData *)mutableData;

@end
