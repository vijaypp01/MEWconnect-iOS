//
//  OperationFactoriesAssembly.m
//  MyEtherWallet-iOS
//
//  Created by Mikhail Nikanorov on 21/05/2018.
//  Copyright © 2018 MyEtherWallet, Inc. All rights reserved.
//

#import "OperationFactoriesAssembly.h"

#import "NetworkCompoundOperationBuilder.h"
#import "OperationChainer.h"

#import "QueryTransformerBase.h"
#import "FiatPricesQueryTransformer.h"
#import "SimplexQueryTransformer.h"

#import "BodyTransformerBase.h"
#import "ContractsBodyTransformer.h"
#import "BalanceBodyTransformer.h"
#import "SimplexBodyTransformer.h"

#import "HeadersBuilderBase.h"
#import "SimplexHeadersBuilder.h"

#import "TokensOperationFactory.h"
#import "AccountsOperationFactory.h"
#import "FiatPricesOperationFactory.h"
#import "SimplexOperationFactory.h"

@implementation OperationFactoriesAssembly

- (TokensOperationFactory *) tokensOperationFactory {
  return [TyphoonDefinition withClass:[TokensOperationFactory class]
                        configuration:^(TyphoonDefinition *definition) {
                          [definition useInitializer:@selector(initWithBuilder:queryTransformer:bodyTransformer:headersBuilder:)
                                          parameters:^(TyphoonMethod *initializer) {
                                            [initializer injectParameterWith:[self networkOperationBuilder]];
                                            [initializer injectParameterWith:[self tokensQueryTransformer]];
                                            [initializer injectParameterWith:[self contractsBodyTransformer]];
                                            [initializer injectParameterWith:[self headersBuilder]];
                                          }];
                        }];
}

- (AccountsOperationFactory *) accountsOperationFactory {
  return [TyphoonDefinition withClass:[AccountsOperationFactory class]
                        configuration:^(TyphoonDefinition *definition) {
                          [definition useInitializer:@selector(initWithBuilder:queryTransformer:bodyTransformer:headersBuilder:)
                                          parameters:^(TyphoonMethod *initializer) {
                                            [initializer injectParameterWith:[self networkOperationBuilder]];
                                            [initializer injectParameterWith:[self accountsQueryTransformer]];
                                            [initializer injectParameterWith:[self balanceBodyTransformer]];
                                            [initializer injectParameterWith:[self headersBuilder]];
                                          }];
                        }];
}

- (FiatPricesOperationFactory *) fiatPricesOperationFactory {
  return [TyphoonDefinition withClass:[FiatPricesOperationFactory class]
                        configuration:^(TyphoonDefinition *definition) {
                          [definition useInitializer:@selector(initWithBuilder:queryTransformer:bodyTransformer:headersBuilder:)
                                          parameters:^(TyphoonMethod *initializer) {
                                            [initializer injectParameterWith:[self networkOperationBuilder]];
                                            [initializer injectParameterWith:[self fiatPricesQueryTransformer]];
                                            [initializer injectParameterWith:[self fiatPricesBodyTransformer]];
                                            [initializer injectParameterWith:[self headersBuilder]];
                                          }];
                        }];
}

- (SimplexOperationFactory *) simplexOperationFactory {
  return [TyphoonDefinition withClass:[SimplexOperationFactory class]
                        configuration:^(TyphoonDefinition *definition) {
                          [definition useInitializer:@selector(initWithBuilder:queryTransformer:bodyTransformer:headersBuilder:)
                                          parameters:^(TyphoonMethod *initializer) {
                                            [initializer injectParameterWith:[self networkOperationBuilder]];
                                            [initializer injectParameterWith:[self simplexQueryTransformer]];
                                            [initializer injectParameterWith:[self simplexBodyTransformer]];
                                            [initializer injectParameterWith:[self simplexHeadersBuilder]];
                                          }];
                          [definition injectProperty:@selector(requestConfiguratorsFactory)
                                                with:self.requestConfiguratorsFactory];
                        }];
}

#pragma mark - Builders

- (NetworkCompoundOperationBuilder *) networkOperationBuilder
{
  return [TyphoonDefinition withClass:[NetworkCompoundOperationBuilder class]
                        configuration:^(TyphoonDefinition *definition) {
                          [definition useInitializer:@selector(initWithOperationChainer:)
                                          parameters:^(TyphoonMethod *initializer) {
                                            [initializer injectParameterWith:[self operationChainer]];
                                          }];
                          [definition injectProperty:@selector(requestConfiguratorsFactory)
                                                with:self.requestConfiguratorsFactory];
//                          [definition injectProperty:@selector(requestSignersFactory)
//                                                with:self.requestSignersFactory];
                          [definition injectProperty:@selector(networkClientsFactory)
                                                with:self.networkClientsFactory];
                          [definition injectProperty:@selector(responseDeserializersFactory)
                                                with:self.responseDeserializersFactory];
                          [definition injectProperty:@selector(responseValidatorsFactory)
                                                with:self.responseValidatorsFactory];
                          [definition injectProperty:@selector(responseMappersFactory)
                                                with:self.responseMappersFactory];
                          [definition injectProperty:@selector(responseConverterFactory)
                                                with:self.responseConverterFactory];
                        }];
}

#pragma mark - Query Transformers

- (QueryTransformerBase *) tokensQueryTransformer {
  return [TyphoonDefinition withClass:[QueryTransformerBase class]];
}

- (QueryTransformerBase *) accountsQueryTransformer {
  return [TyphoonDefinition withClass:[QueryTransformerBase class]];
}

- (FiatPricesQueryTransformer *) fiatPricesQueryTransformer {
  return [TyphoonDefinition withClass:[FiatPricesQueryTransformer class]];
}

- (SimplexQueryTransformer *) simplexQueryTransformer {
  return [TyphoonDefinition withClass:[SimplexQueryTransformer class]];
}

#pragma mark - Body Transformers

- (ContractsBodyTransformer *) contractsBodyTransformer {
  return [TyphoonDefinition withClass:[ContractsBodyTransformer class]];
}

- (BalanceBodyTransformer *) balanceBodyTransformer {
  return [TyphoonDefinition withClass:[BalanceBodyTransformer class]];
}

- (BodyTransformerBase *) fiatPricesBodyTransformer {
  return [TyphoonDefinition withClass:[BodyTransformerBase class]];
}

- (SimplexBodyTransformer *) simplexBodyTransformer {
  return [TyphoonDefinition withClass:[SimplexBodyTransformer class]];
}

#pragma mark - Headers Builders

- (HeadersBuilderBase *) headersBuilder {
  return [TyphoonDefinition withClass:[HeadersBuilderBase class]];
}

- (SimplexHeadersBuilder *) simplexHeadersBuilder {
  return [TyphoonDefinition withClass:[SimplexHeadersBuilder class]];
}

#pragma mark - Others

- (OperationChainer *) operationChainer
{
  return [TyphoonDefinition withClass:[OperationChainer class]];
}

@end
