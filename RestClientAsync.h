//
//  RestClientAsync.h
//  mp_objC
//
//  Created by Amirhossein Mehrvarzi on 11/26/19.
//  Copyright © 2019 Amirhossein Mehrvarzi. All rights reserved.
//

#ifndef RestClientAsync_h
#define RestClientAsync_h


#endif /* RestClientAsync_h */


@interface RestClientAsync : NSObject

@property NSMutableData *responseData;
@property NSString *response;

@property NSString *endpoint;//"https://rest.payamak-panel.com/api/SendSMS/"

@property NSString *sendOp;//"SendSMS"
@property NSString *sendByBaseNumberOp;
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

-(void)makeRequest:(NSString *)endpoint
     msg:(NSString *)message;

@end
