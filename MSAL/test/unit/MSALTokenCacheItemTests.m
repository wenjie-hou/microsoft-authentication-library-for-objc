//------------------------------------------------------------------------------
//
// Copyright (c) Microsoft Corporation.
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//------------------------------------------------------------------------------

#import <XCTest/XCTest.h>
#import "MSALTokenResponse.h"
#import "MSALAccessTokenCacheItem.h"
#import "MSALRefreshTokenCacheItem.h"
#import "MSALTokenCacheKey.h"

@interface MSALTokenCacheItemTests : XCTestCase

@end

@implementation MSALTokenCacheItemTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAccessTokenProperties {
    NSString *base64String = @"eyJ0b2tlbl90eXBlIjoiQmVhcmVyIiwic2NvcGUiOiJtYWlsLnJlYWQgdXNlci5yZWFkIiwiZXhwaXJlc19pbiI6MzU5OSwiZXh0X2V4cGlyZXNfaW4iOjEwODAwLCJhY2Nlc3NfdG9rZW4iOiJleUowZVhBaU9pSktWMVFpTENKdWIyNWpaU0k2SWtGUlFVSkJRVUZCUVVGRVVrNVpVbEV6WkdoU1UzSnRMVFJMTFdGa2NFTktUWEppUlhaWlEwaGlZMUJxUWs4d1psaGxiV3RTYkZOc1lqSnZaRE5SUmtkb2QzVlBXRWd5VUc1NVpHbHpkRE5xTFZScGJscHZTMGxxUWpadGIxQm9kM3BWTFdJd04yTXpSRXhOWlROSGFuVnZURko1VEdsQlFTSXNJbUZzWnlJNklsSlRNalUySWl3aWVEVjBJam9pWDFWbmNWaEhYM1JOVEdSMVUwb3hWRGhqWVVoNFZUZGpUM1JqSWl3aWEybGtJam9pWDFWbmNWaEhYM1JOVEdSMVUwb3hWRGhqWVVoNFZUZGpUM1JqSW4wLmV5SmhkV1FpT2lKb2RIUndjem92TDJkeVlYQm9MbTFwWTNKdmMyOW1kQzVqYjIwaUxDSnBjM01pT2lKb2RIUndjem92TDNOMGN5NTNhVzVrYjNkekxtNWxkQzh3TWpnM1pqazJNeTB5WkRjeUxUUXpOak10T1dVellTMDFOekExWXpWaU1HWXdNekV2SWl3aWFXRjBJam94TkRnNE1qWTBNVGt4TENKdVltWWlPakUwT0RneU5qUXhPVEVzSW1WNGNDSTZNVFE0T0RJMk9EQTVNU3dpWVdOeUlqb2lNU0lzSW1GdGNpSTZXeUp3ZDJRaVhTd2lZWEJ3WDJScGMzQnNZWGx1WVcxbElqb2lUbUYwYVhabFFYQndJaXdpWVhCd2FXUWlPaUkxWVRRek5EWTVNUzFqWTJJeUxUUm1aREV0WWprM1lpMWlOalJpWTJaaVl6QXpabU1pTENKaGNIQnBaR0ZqY2lJNklqQWlMQ0psWDJWNGNDSTZNVEE0TURBc0ltWmhiV2xzZVY5dVlXMWxJam9pVlhObGNpSXNJbWRwZG1WdVgyNWhiV1VpT2lKVGFXMXdiR1VpTENKcGNHRmtaSElpT2lJeE56UXVOaTQ0T1M0eU1UY2lMQ0p1WVcxbElqb2lVMmx0Y0d4bElGVnpaWElpTENKdmFXUWlPaUl5T1dZek9EQTNZUzAwWm1Jd0xUUXlaakl0WVRRMFlTMHlNelpoWVRCallqTm1PVGNpTENKd2JHRjBaaUk2SWpJaUxDSndkV2xrSWpvaU1UQXdNemRHUmtVNU5EVTRNamM1UXlJc0luTmpjQ0k2SWsxaGFXd3VVbVZoWkNCVmMyVnlMbEpsWVdRaUxDSnpkV0lpT2lKWlVEQktORkExU2xrdGVXcFdSM0ZoWkdwUmRtYzVNM0F6WWpoMmIxQnhWREJaWjBoSVZYSnFhbEJ6SWl3aWRHbGtJam9pTURJNE4yWTVOak10TW1RM01pMDBNell6TFRsbE0yRXROVGN3TldNMVlqQm1NRE14SWl3aWRXNXBjWFZsWDI1aGJXVWlPaUoxYzJWeVFHMXpaR1YyWlhndWIyNXRhV055YjNOdlpuUXVZMjl0SWl3aWRYQnVJam9pZFhObGNrQnRjMlJsZG1WNExtOXViV2xqY205emIyWjBMbU52YlNJc0luWmxjaUk2SWpFdU1DSjkuQ19rQ2VOdkxGR1B0N1FpcFJrTTlOUm9PRkZOUlhZOFN2THJQcXJaUDItTzFoeXpuTmZyc2gyTjExNjAwUXg2TnhMLS1Bc0o2NUZMSFVDZ0pHZ1hBSVFVSENwc290VkYxcTVWS0ZVd05zQ2g4U0RzYlN2SkxCUGdaaXhMdHNzTWtwLW1wcEFoTDJLX05BTEIySWJMWkdPQ003SkRtN3ROMC1jbVBTcE1lNWNVa0V5ZUlDcHVrQVRuVlkyd1BYc2NvUi1pWjB2MmxHekxLUVllV1dObnVGeWdybUFhb3hCcExLOGlPX2p2Y05qeEFDMWtqaHA0QVlxVGRpRTI5WnRvbVN6TDZ6ZmZCWXFVd0g4Z013bnZZMTRFQUoyb3drU1YwalA4YWV4di01YW5nclB0VmstME5IdHRZUXpuU010WUZmQTVlQ1ItYTZObjZPR2VURFEtWi1RIiwicmVmcmVzaF90b2tlbiI6Ik9BUUFCQUFBQUFBRFJOWVJRM2RoUlNybS00Sy1hZHBDSlQ1N0hXaGZMVXJEd2dweW8yRjc0UE54UjRBSGdXZTB0VW10RFV1US1wUEtuM1o2UGRCVHhrdlg0c0NSekQ2R0YxZVYtVEdCZE5XQ0xndW1BUnl2VGNBcDFCSDE5RUI0X3NlZkI4eEhHeHlMSUYtOG9PaEw5MWh0akJsWkFFZkdLUU94OU5mNExHWWZuYUYyMnBJR3dkZV93ckhPXzNsSnE5TGhoVnhIZnJOWVFFSmdJdjlGS01qdlB5WkpYNnFkTlE3aDl6d2Nndko1a3Yzb3BGc0M4bHhSNk9YX2wxYTYwOWQ2MzViUHNKY0JBYzNNOFdfVDllXzhrbzBUTVItclVvbFBGTjhzNURtSnRXMHFFbGpGa0xkWkluZjlOV2ViZ3hucy1sT0VXUTZsdFd3dUNLRk5GTFJGdFZYaWtNeHljQnVGLWIwVkxKck1hUUxVdjZQWGJpMnBjcnljbjlrek1ZM00tSkdRVUZwcHhmYjdiR2FlZmduXzE4M3pRdlBZdzlwRTA1aEg4eXEtQl9wUlJnX1VMTWRxRFZJd2dndjhMUFZ1VzJBWmJnQkl4M0tSektEaVVOV0phZ2Vya3dHYnZoMWx0eTNCSnFmYWhCYmlCRzVoYWJNQ2Npem5OTFI3X3NUTGxDUzNnaHZocmdQWGprTHp5X1RwSTJCajZGc3ZUODUwZHJmUmJkZGhfQll0YVA2SkU5ZVplY2Q5QnhJcnRPb296VUtOVGs5RUZDRjVEUDdZdkllVWxIalNYbk9Xa1pHZExGU3UxdmxVSDRYZHV3Q1MzXzI1dTd4RG1Mcks0bG9BMEFJUExlcENpOGVBN1pDQnFVemtZUHNQWE40X1NFYzFCUlZYWlNETXJNZU9XUEdsVXFiTkhyUmN4WEVsUUwyMFRYM040X3BFaFo1eHpDdjZPczRaX3Y0dmo3TjlkSUFBIiwiaWRfdG9rZW4iOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpTVXpJMU5pSXNJbXRwWkNJNklsOVZaM0ZZUjE5MFRVeGtkVk5LTVZRNFkyRkllRlUzWTA5MFl5SjkuZXlKaGRXUWlPaUkxWVRRek5EWTVNUzFqWTJJeUxUUm1aREV0WWprM1lpMWlOalJpWTJaaVl6QXpabU1pTENKcGMzTWlPaUpvZEhSd2N6b3ZMMnh2WjJsdUxtMXBZM0p2YzI5bWRHOXViR2x1WlM1amIyMHZNREk0TjJZNU5qTXRNbVEzTWkwME16WXpMVGxsTTJFdE5UY3dOV00xWWpCbU1ETXhMM1l5TGpBaUxDSnBZWFFpT2pFME9EZ3lOalF4T1RFc0ltNWlaaUk2TVRRNE9ESTJOREU1TVN3aVpYaHdJam94TkRnNE1qWTRNRGt4TENKdVlXMWxJam9pVTJsdGNHeGxJRlZ6WlhJaUxDSnZhV1FpT2lJeU9XWXpPREEzWVMwMFptSXdMVFF5WmpJdFlUUTBZUzB5TXpaaFlUQmpZak5tT1RjaUxDSndjbVZtWlhKeVpXUmZkWE5sY201aGJXVWlPaUoxYzJWeVFHMXpaR1YyWlhndWIyNXRhV055YjNOdlpuUXVZMjl0SWl3aWMzVmlJam9pVkhGblZIcDZWMkpXTVRadFNXdEpSVEJ6ZUhOU1IxRkdibkpQV1d4QlpVOVpVbmhyWkhsQ2FFUkdieUlzSW5ScFpDSTZJakF5T0RkbU9UWXpMVEprTnpJdE5ETTJNeTA1WlROaExUVTNNRFZqTldJd1pqQXpNU0lzSW5abGNpSTZJakl1TUNKOS5oeV9jOHRacWtzV210dDFuZ1Fsdl8zVDR6aXcyejhkc3RWc2RPQjA5TTVZaVhZU0dDZTZqTWRkcjY2Z0NFN0xncjZVRGRhRzZlWUZaSVF2SGFwaVVMSVo4Vi1nMC04WmEwS0t0SXprR3NMMFEybWhXRkVETl9PSUZNcE8welU4SzVXQVJzQ3g0SlgxY3BucWVValdxZ1hNVHV0d0lPeUdrWXZLUDBMbXlnMURKNHpnclpyZE1VanIwZ3J1SzRIaDB4QUM2bUpnNXVzbEgteEpUN1ZpV1ItUXVtRm9OU3VGWEgyanhKblB4OVlzeXhpVnB0a0plQTZlTFNRWXJqNVJaY3BGbklldHFnREt1R3JQd0xHaXFoa18tUGdldS1Sc0lkQzQ2dUN0VXlBVElzZWhrT015X0JsbXJnMUw3OU5GSWhGMUVpenktZ25ZY241ZV9LMG1jdHcifQ==";
    
    NSData* responseData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    MSALTokenResponse *response = [[MSALTokenResponse alloc] initWithData:responseData error:nil];
    
    MSALAccessTokenCacheItem *atItem = [[MSALAccessTokenCacheItem alloc] initWithAuthority:[NSURL URLWithString:@"https://login.microsoftonline.com/common"]
                                                                                  clientId:@"5a434691-ccb2-4fd1-b97b-b64bcfbc03fc"
                                                                                  response:response];
    
    XCTAssertEqualObjects(atItem.tokenType, @"Bearer");
    XCTAssertEqualObjects(atItem.accessToken, @"eyJ0eXAiOiJKV1QiLCJub25jZSI6IkFRQUJBQUFBQUFEUk5ZUlEzZGhSU3JtLTRLLWFkcENKTXJiRXZZQ0hiY1BqQk8wZlhlbWtSbFNsYjJvZDNRRkdod3VPWEgyUG55ZGlzdDNqLVRpblpvS0lqQjZtb1Bod3pVLWIwN2MzRExNZTNHanVvTFJ5TGlBQSIsImFsZyI6IlJTMjU2IiwieDV0IjoiX1VncVhHX3RNTGR1U0oxVDhjYUh4VTdjT3RjIiwia2lkIjoiX1VncVhHX3RNTGR1U0oxVDhjYUh4VTdjT3RjIn0.eyJhdWQiOiJodHRwczovL2dyYXBoLm1pY3Jvc29mdC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8wMjg3Zjk2My0yZDcyLTQzNjMtOWUzYS01NzA1YzViMGYwMzEvIiwiaWF0IjoxNDg4MjY0MTkxLCJuYmYiOjE0ODgyNjQxOTEsImV4cCI6MTQ4ODI2ODA5MSwiYWNyIjoiMSIsImFtciI6WyJwd2QiXSwiYXBwX2Rpc3BsYXluYW1lIjoiTmF0aXZlQXBwIiwiYXBwaWQiOiI1YTQzNDY5MS1jY2IyLTRmZDEtYjk3Yi1iNjRiY2ZiYzAzZmMiLCJhcHBpZGFjciI6IjAiLCJlX2V4cCI6MTA4MDAsImZhbWlseV9uYW1lIjoiVXNlciIsImdpdmVuX25hbWUiOiJTaW1wbGUiLCJpcGFkZHIiOiIxNzQuNi44OS4yMTciLCJuYW1lIjoiU2ltcGxlIFVzZXIiLCJvaWQiOiIyOWYzODA3YS00ZmIwLTQyZjItYTQ0YS0yMzZhYTBjYjNmOTciLCJwbGF0ZiI6IjIiLCJwdWlkIjoiMTAwMzdGRkU5NDU4Mjc5QyIsInNjcCI6Ik1haWwuUmVhZCBVc2VyLlJlYWQiLCJzdWIiOiJZUDBKNFA1SlkteWpWR3FhZGpRdmc5M3AzYjh2b1BxVDBZZ0hIVXJqalBzIiwidGlkIjoiMDI4N2Y5NjMtMmQ3Mi00MzYzLTllM2EtNTcwNWM1YjBmMDMxIiwidW5pcXVlX25hbWUiOiJ1c2VyQG1zZGV2ZXgub25taWNyb3NvZnQuY29tIiwidXBuIjoidXNlckBtc2RldmV4Lm9ubWljcm9zb2Z0LmNvbSIsInZlciI6IjEuMCJ9.C_kCeNvLFGPt7QipRkM9NRoOFFNRXY8SvLrPqrZP2-O1hyznNfrsh2N11600Qx6NxL--AsJ65FLHUCgJGgXAIQUHCpsotVF1q5VKFUwNsCh8SDsbSvJLBPgZixLtssMkp-mppAhL2K_NALB2IbLZGOCM7JDm7tN0-cmPSpMe5cUkEyeICpukATnVY2wPXscoR-iZ0v2lGzLKQYeWWNnuFygrmAaoxBpLK8iO_jvcNjxAC1kjhp4AYqTdiE29ZtomSzL6zffBYqUwH8gMwnvY14EAJ2owkSV0jP8aexv-5angrPtVk-0NHttYQznSMtYFfA5eCR-a6Nn6OGeTDQ-Z-Q");
    XCTAssertTrue([atItem.expiresOn compare:NSDate.date] == NSOrderedDescending);
    XCTAssertEqualObjects(atItem.scope.msalToString, @"mail.read user.read");
    XCTAssertTrue(atItem.isExpired);
    
    XCTAssertEqualObjects([atItem tokenCacheKey:nil].service, @"NWE0MzQ2OTEtY2NiMi00ZmQxLWI5N2ItYjY0YmNmYmMwM2Zj$bWFpbC5yZWFkIHVzZXIucmVhZA");
    XCTAssertEqualObjects([atItem tokenCacheKey:nil].account, @"0.0.1-dev$MjlmMzgwN2EtNGZiMC00MmYyLWE0NGEtMjM2YWEwY2IzZjk3@aHR0cHM6Ly9sb2dpbi5taWNyb3NvZnRvbmxpbmUuY29t");
    XCTAssertEqualObjects(atItem.authority, @"https://login.microsoftonline.com/common");
    XCTAssertEqualObjects(atItem.clientId, @"5a434691-ccb2-4fd1-b97b-b64bcfbc03fc");
    XCTAssertEqualObjects(atItem.tenantId, @"0287f963-2d72-4363-9e3a-5705c5b0f031");
    XCTAssertEqualObjects(atItem.rawIdToken, @"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Il9VZ3FYR190TUxkdVNKMVQ4Y2FIeFU3Y090YyJ9.eyJhdWQiOiI1YTQzNDY5MS1jY2IyLTRmZDEtYjk3Yi1iNjRiY2ZiYzAzZmMiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vMDI4N2Y5NjMtMmQ3Mi00MzYzLTllM2EtNTcwNWM1YjBmMDMxL3YyLjAiLCJpYXQiOjE0ODgyNjQxOTEsIm5iZiI6MTQ4ODI2NDE5MSwiZXhwIjoxNDg4MjY4MDkxLCJuYW1lIjoiU2ltcGxlIFVzZXIiLCJvaWQiOiIyOWYzODA3YS00ZmIwLTQyZjItYTQ0YS0yMzZhYTBjYjNmOTciLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ1c2VyQG1zZGV2ZXgub25taWNyb3NvZnQuY29tIiwic3ViIjoiVHFnVHp6V2JWMTZtSWtJRTBzeHNSR1FGbnJPWWxBZU9ZUnhrZHlCaERGbyIsInRpZCI6IjAyODdmOTYzLTJkNzItNDM2My05ZTNhLTU3MDVjNWIwZjAzMSIsInZlciI6IjIuMCJ9.hy_c8tZqksWmtt1ngQlv_3T4ziw2z8dstVsdOB09M5YiXYSGCe6jMddr66gCE7Lgr6UDdaG6eYFZIQvHapiULIZ8V-g0-8Za0KKtIzkGsL0Q2mhWFEDN_OIFMpO0zU8K5WARsCx4JX1cpnqeUjWqgXMTutwIOyGkYvKP0Lmyg1DJ4zgrZrdMUjr0gruK4Hh0xAC6mJg5uslH-xJT7ViWR-QumFoNSuFXH2jxJnPx9YsyxiVptkJeA6eLSQYrj5RZcpFnIetqgDKuGrPwLGiqhk_-Pgeu-RsIdC46uCtUyATIsehkOMy_Blmrg1L79NFIhF1Eizy-gnYcn5e_K0mctw");
    XCTAssertEqualObjects(atItem.uniqueId, @"29f3807a-4fb0-42f2-a44a-236aa0cb3f97");
    XCTAssertEqualObjects(atItem.displayableId, @"user@msdevex.onmicrosoft.com");
    XCTAssertEqualObjects(atItem.homeObjectId, @"29f3807a-4fb0-42f2-a44a-236aa0cb3f97");
    XCTAssertEqualObjects(atItem.user.uniqueId, @"29f3807a-4fb0-42f2-a44a-236aa0cb3f97");
    XCTAssertEqualObjects(atItem.user.displayableId, @"user@msdevex.onmicrosoft.com");
    XCTAssertEqualObjects(atItem.user.name, @"Simple User");
    XCTAssertEqualObjects(atItem.user.identityProvider, @"https://login.microsoftonline.com/0287f963-2d72-4363-9e3a-5705c5b0f031/v2.0");
    XCTAssertEqualObjects(atItem.user.clientId, @"5a434691-ccb2-4fd1-b97b-b64bcfbc03fc");
    XCTAssertEqualObjects(atItem.user.authority.absoluteString, @"https://login.microsoftonline.com/common");
    XCTAssertEqualObjects(atItem.user.homeObjectId, @"29f3807a-4fb0-42f2-a44a-236aa0cb3f97");
}

- (void)testBadAccessTokenInit {
    MSALTokenResponse *badResponse = [MSALTokenResponse new];
    MSALAccessTokenCacheItem *atItem = [[MSALAccessTokenCacheItem alloc] initWithAuthority:[NSURL URLWithString:@"https://login.microsoftonline.com/common"]
                                                                                  clientId:@"5a434691-ccb2-4fd1-b97b-b64bcfbc03fc"
                                                                                  response:badResponse];
    XCTAssertNil(atItem);
}

- (void)testRefreshTokenProperties {
    NSString *base64String = @"eyJ0b2tlbl90eXBlIjoiQmVhcmVyIiwic2NvcGUiOiJtYWlsLnJlYWQgdXNlci5yZWFkIiwiZXhwaXJlc19pbiI6MzU5OSwiZXh0X2V4cGlyZXNfaW4iOjEwODAwLCJhY2Nlc3NfdG9rZW4iOiJleUowZVhBaU9pSktWMVFpTENKdWIyNWpaU0k2SWtGUlFVSkJRVUZCUVVGRVVrNVpVbEV6WkdoU1UzSnRMVFJMTFdGa2NFTktUWEppUlhaWlEwaGlZMUJxUWs4d1psaGxiV3RTYkZOc1lqSnZaRE5SUmtkb2QzVlBXRWd5VUc1NVpHbHpkRE5xTFZScGJscHZTMGxxUWpadGIxQm9kM3BWTFdJd04yTXpSRXhOWlROSGFuVnZURko1VEdsQlFTSXNJbUZzWnlJNklsSlRNalUySWl3aWVEVjBJam9pWDFWbmNWaEhYM1JOVEdSMVUwb3hWRGhqWVVoNFZUZGpUM1JqSWl3aWEybGtJam9pWDFWbmNWaEhYM1JOVEdSMVUwb3hWRGhqWVVoNFZUZGpUM1JqSW4wLmV5SmhkV1FpT2lKb2RIUndjem92TDJkeVlYQm9MbTFwWTNKdmMyOW1kQzVqYjIwaUxDSnBjM01pT2lKb2RIUndjem92TDNOMGN5NTNhVzVrYjNkekxtNWxkQzh3TWpnM1pqazJNeTB5WkRjeUxUUXpOak10T1dVellTMDFOekExWXpWaU1HWXdNekV2SWl3aWFXRjBJam94TkRnNE1qWTBNVGt4TENKdVltWWlPakUwT0RneU5qUXhPVEVzSW1WNGNDSTZNVFE0T0RJMk9EQTVNU3dpWVdOeUlqb2lNU0lzSW1GdGNpSTZXeUp3ZDJRaVhTd2lZWEJ3WDJScGMzQnNZWGx1WVcxbElqb2lUbUYwYVhabFFYQndJaXdpWVhCd2FXUWlPaUkxWVRRek5EWTVNUzFqWTJJeUxUUm1aREV0WWprM1lpMWlOalJpWTJaaVl6QXpabU1pTENKaGNIQnBaR0ZqY2lJNklqQWlMQ0psWDJWNGNDSTZNVEE0TURBc0ltWmhiV2xzZVY5dVlXMWxJam9pVlhObGNpSXNJbWRwZG1WdVgyNWhiV1VpT2lKVGFXMXdiR1VpTENKcGNHRmtaSElpT2lJeE56UXVOaTQ0T1M0eU1UY2lMQ0p1WVcxbElqb2lVMmx0Y0d4bElGVnpaWElpTENKdmFXUWlPaUl5T1dZek9EQTNZUzAwWm1Jd0xUUXlaakl0WVRRMFlTMHlNelpoWVRCallqTm1PVGNpTENKd2JHRjBaaUk2SWpJaUxDSndkV2xrSWpvaU1UQXdNemRHUmtVNU5EVTRNamM1UXlJc0luTmpjQ0k2SWsxaGFXd3VVbVZoWkNCVmMyVnlMbEpsWVdRaUxDSnpkV0lpT2lKWlVEQktORkExU2xrdGVXcFdSM0ZoWkdwUmRtYzVNM0F6WWpoMmIxQnhWREJaWjBoSVZYSnFhbEJ6SWl3aWRHbGtJam9pTURJNE4yWTVOak10TW1RM01pMDBNell6TFRsbE0yRXROVGN3TldNMVlqQm1NRE14SWl3aWRXNXBjWFZsWDI1aGJXVWlPaUoxYzJWeVFHMXpaR1YyWlhndWIyNXRhV055YjNOdlpuUXVZMjl0SWl3aWRYQnVJam9pZFhObGNrQnRjMlJsZG1WNExtOXViV2xqY205emIyWjBMbU52YlNJc0luWmxjaUk2SWpFdU1DSjkuQ19rQ2VOdkxGR1B0N1FpcFJrTTlOUm9PRkZOUlhZOFN2THJQcXJaUDItTzFoeXpuTmZyc2gyTjExNjAwUXg2TnhMLS1Bc0o2NUZMSFVDZ0pHZ1hBSVFVSENwc290VkYxcTVWS0ZVd05zQ2g4U0RzYlN2SkxCUGdaaXhMdHNzTWtwLW1wcEFoTDJLX05BTEIySWJMWkdPQ003SkRtN3ROMC1jbVBTcE1lNWNVa0V5ZUlDcHVrQVRuVlkyd1BYc2NvUi1pWjB2MmxHekxLUVllV1dObnVGeWdybUFhb3hCcExLOGlPX2p2Y05qeEFDMWtqaHA0QVlxVGRpRTI5WnRvbVN6TDZ6ZmZCWXFVd0g4Z013bnZZMTRFQUoyb3drU1YwalA4YWV4di01YW5nclB0VmstME5IdHRZUXpuU010WUZmQTVlQ1ItYTZObjZPR2VURFEtWi1RIiwicmVmcmVzaF90b2tlbiI6Ik9BUUFCQUFBQUFBRFJOWVJRM2RoUlNybS00Sy1hZHBDSlQ1N0hXaGZMVXJEd2dweW8yRjc0UE54UjRBSGdXZTB0VW10RFV1US1wUEtuM1o2UGRCVHhrdlg0c0NSekQ2R0YxZVYtVEdCZE5XQ0xndW1BUnl2VGNBcDFCSDE5RUI0X3NlZkI4eEhHeHlMSUYtOG9PaEw5MWh0akJsWkFFZkdLUU94OU5mNExHWWZuYUYyMnBJR3dkZV93ckhPXzNsSnE5TGhoVnhIZnJOWVFFSmdJdjlGS01qdlB5WkpYNnFkTlE3aDl6d2Nndko1a3Yzb3BGc0M4bHhSNk9YX2wxYTYwOWQ2MzViUHNKY0JBYzNNOFdfVDllXzhrbzBUTVItclVvbFBGTjhzNURtSnRXMHFFbGpGa0xkWkluZjlOV2ViZ3hucy1sT0VXUTZsdFd3dUNLRk5GTFJGdFZYaWtNeHljQnVGLWIwVkxKck1hUUxVdjZQWGJpMnBjcnljbjlrek1ZM00tSkdRVUZwcHhmYjdiR2FlZmduXzE4M3pRdlBZdzlwRTA1aEg4eXEtQl9wUlJnX1VMTWRxRFZJd2dndjhMUFZ1VzJBWmJnQkl4M0tSektEaVVOV0phZ2Vya3dHYnZoMWx0eTNCSnFmYWhCYmlCRzVoYWJNQ2Npem5OTFI3X3NUTGxDUzNnaHZocmdQWGprTHp5X1RwSTJCajZGc3ZUODUwZHJmUmJkZGhfQll0YVA2SkU5ZVplY2Q5QnhJcnRPb296VUtOVGs5RUZDRjVEUDdZdkllVWxIalNYbk9Xa1pHZExGU3UxdmxVSDRYZHV3Q1MzXzI1dTd4RG1Mcks0bG9BMEFJUExlcENpOGVBN1pDQnFVemtZUHNQWE40X1NFYzFCUlZYWlNETXJNZU9XUEdsVXFiTkhyUmN4WEVsUUwyMFRYM040X3BFaFo1eHpDdjZPczRaX3Y0dmo3TjlkSUFBIiwiaWRfdG9rZW4iOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpTVXpJMU5pSXNJbXRwWkNJNklsOVZaM0ZZUjE5MFRVeGtkVk5LTVZRNFkyRkllRlUzWTA5MFl5SjkuZXlKaGRXUWlPaUkxWVRRek5EWTVNUzFqWTJJeUxUUm1aREV0WWprM1lpMWlOalJpWTJaaVl6QXpabU1pTENKcGMzTWlPaUpvZEhSd2N6b3ZMMnh2WjJsdUxtMXBZM0p2YzI5bWRHOXViR2x1WlM1amIyMHZNREk0TjJZNU5qTXRNbVEzTWkwME16WXpMVGxsTTJFdE5UY3dOV00xWWpCbU1ETXhMM1l5TGpBaUxDSnBZWFFpT2pFME9EZ3lOalF4T1RFc0ltNWlaaUk2TVRRNE9ESTJOREU1TVN3aVpYaHdJam94TkRnNE1qWTRNRGt4TENKdVlXMWxJam9pVTJsdGNHeGxJRlZ6WlhJaUxDSnZhV1FpT2lJeU9XWXpPREEzWVMwMFptSXdMVFF5WmpJdFlUUTBZUzB5TXpaaFlUQmpZak5tT1RjaUxDSndjbVZtWlhKeVpXUmZkWE5sY201aGJXVWlPaUoxYzJWeVFHMXpaR1YyWlhndWIyNXRhV055YjNOdlpuUXVZMjl0SWl3aWMzVmlJam9pVkhGblZIcDZWMkpXTVRadFNXdEpSVEJ6ZUhOU1IxRkdibkpQV1d4QlpVOVpVbmhyWkhsQ2FFUkdieUlzSW5ScFpDSTZJakF5T0RkbU9UWXpMVEprTnpJdE5ETTJNeTA1WlROaExUVTNNRFZqTldJd1pqQXpNU0lzSW5abGNpSTZJakl1TUNKOS5oeV9jOHRacWtzV210dDFuZ1Fsdl8zVDR6aXcyejhkc3RWc2RPQjA5TTVZaVhZU0dDZTZqTWRkcjY2Z0NFN0xncjZVRGRhRzZlWUZaSVF2SGFwaVVMSVo4Vi1nMC04WmEwS0t0SXprR3NMMFEybWhXRkVETl9PSUZNcE8welU4SzVXQVJzQ3g0SlgxY3BucWVValdxZ1hNVHV0d0lPeUdrWXZLUDBMbXlnMURKNHpnclpyZE1VanIwZ3J1SzRIaDB4QUM2bUpnNXVzbEgteEpUN1ZpV1ItUXVtRm9OU3VGWEgyanhKblB4OVlzeXhpVnB0a0plQTZlTFNRWXJqNVJaY3BGbklldHFnREt1R3JQd0xHaXFoa18tUGdldS1Sc0lkQzQ2dUN0VXlBVElzZWhrT015X0JsbXJnMUw3OU5GSWhGMUVpenktZ25ZY241ZV9LMG1jdHcifQ==";
    
    NSData* responseData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    MSALTokenResponse *response = [[MSALTokenResponse alloc] initWithData:responseData error:nil];
    
    MSALRefreshTokenCacheItem *rtItem = [[MSALRefreshTokenCacheItem alloc] initWithAuthority:[NSURL URLWithString:@"https://login.microsoftonline.com/common"]
                                                                                  clientId:@"5a434691-ccb2-4fd1-b97b-b64bcfbc03fc"
                                                                                  response:response];
    
    XCTAssertEqualObjects(rtItem.refreshToken, @"OAQABAAAAAADRNYRQ3dhRSrm-4K-adpCJT57HWhfLUrDwgpyo2F74PNxR4AHgWe0tUmtDUuQ-pPKn3Z6PdBTxkvX4sCRzD6GF1eV-TGBdNWCLgumARyvTcAp1BH19EB4_sefB8xHGxyLIF-8oOhL91htjBlZAEfGKQOx9Nf4LGYfnaF22pIGwde_wrHO_3lJq9LhhVxHfrNYQEJgIv9FKMjvPyZJX6qdNQ7h9zwcgvJ5kv3opFsC8lxR6OX_l1a609d635bPsJcBAc3M8W_T9e_8ko0TMR-rUolPFN8s5DmJtW0qEljFkLdZInf9NWebgxns-lOEWQ6ltWwuCKFNFLRFtVXikMxycBuF-b0VLJrMaQLUv6PXbi2pcrycn9kzMY3M-JGQUFppxfb7bGaefgn_183zQvPYw9pE05hH8yq-B_pRRg_ULMdqDVIwggv8LPVuW2AZbgBIx3KRzKDiUNWJagerkwGbvh1lty3BJqfahBbiBG5habMCciznNLR7_sTLlCS3ghvhrgPXjkLzy_TpI2Bj6FsvT850drfRbddh_BYtaP6JE9eZecd9BxIrtOoozUKNTk9EFCF5DP7YvIeUlHjSXnOWkZGdLFSu1vlUH4XduwCS3_25u7xDmLrK4loA0AIPLepCi8eA7ZCBqUzkYPsPXN4_SEc1BRVXZSDMrMeOWPGlUqbNHrRcxXElQL20TX3N4_pEhZ5xzCv6Os4Z_v4vj7N9dIAA");
    XCTAssertEqualObjects([rtItem tokenCacheKey:nil].service, @"NWE0MzQ2OTEtY2NiMi00ZmQxLWI5N2ItYjY0YmNmYmMwM2Zj$");
    XCTAssertEqualObjects([rtItem tokenCacheKey:nil].account, @"0.0.1-dev$MjlmMzgwN2EtNGZiMC00MmYyLWE0NGEtMjM2YWEwY2IzZjk3@aHR0cHM6Ly9sb2dpbi5taWNyb3NvZnRvbmxpbmUuY29t");
    XCTAssertEqualObjects(rtItem.authority, @"https://login.microsoftonline.com/common");
    XCTAssertEqualObjects(rtItem.clientId, @"5a434691-ccb2-4fd1-b97b-b64bcfbc03fc");
    XCTAssertEqualObjects(rtItem.tenantId, @"0287f963-2d72-4363-9e3a-5705c5b0f031");
    XCTAssertEqualObjects(rtItem.rawIdToken, @"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6Il9VZ3FYR190TUxkdVNKMVQ4Y2FIeFU3Y090YyJ9.eyJhdWQiOiI1YTQzNDY5MS1jY2IyLTRmZDEtYjk3Yi1iNjRiY2ZiYzAzZmMiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vMDI4N2Y5NjMtMmQ3Mi00MzYzLTllM2EtNTcwNWM1YjBmMDMxL3YyLjAiLCJpYXQiOjE0ODgyNjQxOTEsIm5iZiI6MTQ4ODI2NDE5MSwiZXhwIjoxNDg4MjY4MDkxLCJuYW1lIjoiU2ltcGxlIFVzZXIiLCJvaWQiOiIyOWYzODA3YS00ZmIwLTQyZjItYTQ0YS0yMzZhYTBjYjNmOTciLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ1c2VyQG1zZGV2ZXgub25taWNyb3NvZnQuY29tIiwic3ViIjoiVHFnVHp6V2JWMTZtSWtJRTBzeHNSR1FGbnJPWWxBZU9ZUnhrZHlCaERGbyIsInRpZCI6IjAyODdmOTYzLTJkNzItNDM2My05ZTNhLTU3MDVjNWIwZjAzMSIsInZlciI6IjIuMCJ9.hy_c8tZqksWmtt1ngQlv_3T4ziw2z8dstVsdOB09M5YiXYSGCe6jMddr66gCE7Lgr6UDdaG6eYFZIQvHapiULIZ8V-g0-8Za0KKtIzkGsL0Q2mhWFEDN_OIFMpO0zU8K5WARsCx4JX1cpnqeUjWqgXMTutwIOyGkYvKP0Lmyg1DJ4zgrZrdMUjr0gruK4Hh0xAC6mJg5uslH-xJT7ViWR-QumFoNSuFXH2jxJnPx9YsyxiVptkJeA6eLSQYrj5RZcpFnIetqgDKuGrPwLGiqhk_-Pgeu-RsIdC46uCtUyATIsehkOMy_Blmrg1L79NFIhF1Eizy-gnYcn5e_K0mctw");
    XCTAssertEqualObjects(rtItem.uniqueId, @"29f3807a-4fb0-42f2-a44a-236aa0cb3f97");
    XCTAssertEqualObjects(rtItem.displayableId, @"user@msdevex.onmicrosoft.com");
    XCTAssertEqualObjects(rtItem.homeObjectId, @"29f3807a-4fb0-42f2-a44a-236aa0cb3f97");
    XCTAssertEqualObjects(rtItem.user.uniqueId, @"29f3807a-4fb0-42f2-a44a-236aa0cb3f97");
    XCTAssertEqualObjects(rtItem.user.displayableId, @"user@msdevex.onmicrosoft.com");
    XCTAssertEqualObjects(rtItem.user.name, @"Simple User");
    XCTAssertEqualObjects(rtItem.user.identityProvider, @"https://login.microsoftonline.com/0287f963-2d72-4363-9e3a-5705c5b0f031/v2.0");
    XCTAssertEqualObjects(rtItem.user.clientId, @"5a434691-ccb2-4fd1-b97b-b64bcfbc03fc");
    XCTAssertEqualObjects(rtItem.user.authority.absoluteString, @"https://login.microsoftonline.com/common");
    XCTAssertEqualObjects(rtItem.user.homeObjectId, @"29f3807a-4fb0-42f2-a44a-236aa0cb3f97");
}

- (void)testBadRefreshTokenInit {
    MSALTokenResponse *badResponse = [MSALTokenResponse new];
    MSALRefreshTokenCacheItem *rtItem = [[MSALRefreshTokenCacheItem alloc] initWithAuthority:nil
                                                                                    clientId:@"5a434691-ccb2-4fd1-b97b-b64bcfbc03fc"
                                                                                    response:badResponse];
    XCTAssertNil(rtItem);
}

- (void)testBaseItemTokenCacheKey
{
    MSALBaseTokenCacheItem *item = [[MSALBaseTokenCacheItem alloc] initWithAuthority:nil
                                                                            clientId:nil
                                                                            response:nil];
    
    XCTAssertThrows([item tokenCacheKey:nil]);
}

@end
