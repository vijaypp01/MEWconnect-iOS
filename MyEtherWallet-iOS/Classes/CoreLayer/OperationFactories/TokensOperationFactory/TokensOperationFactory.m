//
//  TokensOperationFactory.m
//  MyEtherWallet-iOS
//
//  Created by Mikhail Nikanorov on 20/05/2018.
//  Copyright © 2018 MyEtherWallet, Inc. All rights reserved.
//

#import "TokensOperationFactory.h"

#import "CompoundOperationBuilderConfig.h"
#import "NetworkingConstantsHeader.h"
#import "NetworkCompoundOperationBuilder.h"

#import "QueryTransformer.h"
#import "BodyTransformer.h"
#import "HeadersBuilder.h"

#import "RequestDataModel.h"

#import "TokenModelObject.h"

@interface TokensOperationFactory ()
@property (nonatomic, strong) NetworkCompoundOperationBuilder *networkOperationBuilder;
@property (nonatomic, strong) id <QueryTransformer> queryTransformer;
@property (nonatomic, strong) id <BodyTransformer> bodyTransformer;
@property (nonatomic, strong) id <HeadersBuilder> headersBuilder;
@end

@implementation TokensOperationFactory

#pragma mark - Initialization

- (instancetype)initWithBuilder:(NetworkCompoundOperationBuilder *)builder
               queryTransformer:(id<QueryTransformer>)queryTransformer
                bodyTransformer:(id<BodyTransformer>)bodyTransformer
                 headersBuilder:(id<HeadersBuilder>)headersBuilder {
  self = [super init];
  if (self) {
    _networkOperationBuilder = builder;
    _queryTransformer = queryTransformer;
    _bodyTransformer = bodyTransformer;
    _headersBuilder = headersBuilder;
  }
  return self;
}

#pragma mark - Operations creation

- (CompoundOperationBase *) ethereumBalanceWithBody:(TokensBody *)body {
  CompoundOperationBuilderConfig *config = [[CompoundOperationBuilderConfig alloc] init];
  
  config.requestConfigurationType = RequestConfigurationRestType;
  config.requestMethod = kHTTPMethodPOST;
  config.serviceName = kServiceNameETH;
  
  //  config.requestSigningType = RequestSigningDisabledType;
  
  config.responseDeserializationType = ResponseDeserializationJSONType;
  
  config.responseConvertingType = ResponseConvertingEthereumType;
  
  config.responseValidationType = ResponseValidationDisabledType;
  
  config.responseMappingType = ResponseMappingCoreDataType;
  
  config.mappingContext = @{kMappingContextModelClassKey : NSStringFromClass([TokenModelObject class])};
  
  NSData *bodyData = [self.bodyTransformer deriveDataFromBody:body];
  NSDictionary *headers = [self.headersBuilder build];
  RequestDataModel *inputData = [[RequestDataModel alloc] initWithHTTPHeaderFields:headers
                                                                   queryParameters:nil
                                                                          bodyData:bodyData];
  config.inputQueueData = inputData;
  return [self.networkOperationBuilder buildCompoundOperationWithConfig:config];
}

- (CompoundOperationBase *) contractBalancesWithBody:(TokensBody *)body {
  CompoundOperationBuilderConfig *config = [[CompoundOperationBuilderConfig alloc] init];
  
  config.requestConfigurationType = RequestConfigurationRestType;
  config.requestMethod = kHTTPMethodPOST;
  config.serviceName = kServiceNameETH;
  
//  config.requestSigningType = RequestSigningDisabledType;
  
  config.responseDeserializationType = ResponseDeserializationJSONType;
  
  config.responseConvertingType = ResponseConvertingTokensType;
  
  config.responseValidationType = ResponseValidationDisabledType;
  
  config.responseMappingType = ResponseMappingCoreDataType;
  
  config.mappingContext = @{kMappingContextModelClassKey : NSStringFromClass([TokenModelObject class])};
  
  NSData *bodyData = [self.bodyTransformer deriveDataFromBody:body];
  NSDictionary *headers = [self.headersBuilder build];
  RequestDataModel *inputData = [[RequestDataModel alloc] initWithHTTPHeaderFields:headers
                                                                   queryParameters:nil
                                                                          bodyData:bodyData];
  config.inputQueueData = inputData;
  return [self.networkOperationBuilder buildCompoundOperationWithConfig:config];
}

@end
