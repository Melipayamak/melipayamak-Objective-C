//
//  RestClient.h
//  MeliPayamak
//
//  Created by Amirhossein Mehrvarzi on 4/25/18.
//  Copyright © 2018 MeliPayamak. All rights reserved.
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

-(void)SendByBaseNumber: (NSString *) text
				to: (NSString *) toNum
				bodyId: (NSInteger) bId;

-(void)GetDelivery: (NSInteger) recId;

-(void)GetMessages: (NSInteger) location
					sender: (NSString *) from
					index: (NSString *) indx
					count: (NSInteger) cnt;

-(void)GetCredit;
-(void)GetBasePrice;
-(void)GetUserNumbers;

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
