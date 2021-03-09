//
//  NetworkUrlGetter.m
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import "NetworkUrlGetter.h"
#import "NetworkUrl.h"
@implementation NetworkUrlGetter

+ (NSString *)getHost {
    return hostReleaseUrl;
}

+ (NSString *)getUrlAvatarHeader {
    return @"";
}

+ (NSString *)login {
    return [[self getHost] stringByAppendingString:loginUrl];
}

+ (NSString *)userRegister {
    return [[self getHost] stringByAppendingString:registerUrl];
}

+ (NSString *)getSettingStarting {
    return [[self getHost] stringByAppendingString:settingStartingUrl];
}

+ (NSString *)getSmsWithPhoneNoWithType:(NSString *)type {
    return [[[self getHost] stringByAppendingPathComponent:smsUrl]stringByAppendingPathComponent:type];
}

+ (NSString *)getUserAgreenment:(NSString *)module {
    return [[[self getHost]stringByAppendingPathComponent:userAgreenmentUrl]stringByAppendingPathComponent:module];
}

+ (NSString *)getMyDynamicListWithRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[self getHost] stringByAppendingPathComponent:MyDynamicListUrl]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getDynamicList:(NSString *)regmentId andType:(NSString *)type andUserId:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[[[self getHost] stringByAppendingPathComponent:dynamicListUrl] stringByAppendingPathComponent:regmentId]stringByAppendingPathComponent:type]
        stringByAppendingPathComponent:userId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getRegimentList:(NSString *)city andCountry:(NSString *)country andUserId:(NSString *)userId {
    return [[[[[self getHost] stringByAppendingPathComponent:regimentListUrl] stringByAppendingPathComponent:city]stringByAppendingPathComponent:country]stringByAppendingPathComponent:userId];
}

+ (NSString *)getCity:(NSString *)keywords andRows:(NSString *)rows andPage:(NSString *)page{
    return [[[[[self getHost] stringByAppendingPathComponent:cityUrl]stringByAppendingPathComponent:keywords]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getCounty:(NSString *)cityCode {
    return [[[self getHost] stringByAppendingPathComponent:countyUrl]stringByAppendingPathComponent:cityCode];
}

+ (NSString *)getMemberList:(NSString *)regimentId andType:(NSString *)type andUserId:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[[[self getHost] stringByAppendingString:memberListUrl]stringByAppendingPathComponent:regimentId]stringByAppendingPathComponent:type] stringByAppendingPathComponent:userId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)joinRegiment:(NSString *)regimentId andUserId:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:joinRegimentUrl] stringByAppendingPathComponent:regimentId] stringByAppendingPathComponent:userId];
}

+ (NSString *)uploadDynamicImage {
    return [[self getHost] stringByAppendingString:uploadDynamicImageUrl];
}

+ (NSString *)addDynamic {
    return [[self getHost]stringByAppendingString:addDynamicUrl];
}

+ (NSString *)getDynamicDetail:(NSString *)dynamic_id  andUserId:(NSString *)userId{
    return [[[[self getHost]stringByAppendingString:dynamicDetail]stringByAppendingPathComponent:dynamic_id] stringByAppendingPathComponent:userId];
}

+ (NSString *)addPraise:(NSString *)dynamicId andUserId:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:addPraiseUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:userId];
}

+ (NSString *)reportDynamic {
    return [[self getHost] stringByAppendingString:reportDynamicUrl];
}

+ (NSString *)addComment {
    return [[self getHost]stringByAppendingString:addCommentUrl];
}

+ (NSString *)getCommentList:(NSString *)dynamicId andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[self getHost] stringByAppendingString:commentListUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)applyPosition {
    return [[self getHost] stringByAppendingString:applyPositionUrl];
}

+ (NSString *)candidate:(NSString *)regimentId andUserId:(NSString *)userId andTgtposiotion:(NSString *)postion {
    return [[[[[self getHost] stringByAppendingString:candidateUrl]stringByAppendingPathComponent:regimentId]stringByAppendingPathComponent:userId]stringByAppendingPathComponent:postion];
}

+ (NSString *)getSpecialtyList {
    return [[self getHost] stringByAppendingString:specialtyListUrl];
}

+ (NSString *)addSpecialty {
    return [[self getHost] stringByAppendingString:addSpecialtyUrl];
}

+ (NSString *)addResignPosition {
    return [[self getHost]stringByAppendingString:resignPositionUrl];
}

+ (NSString *)quitForced:(NSString *)regimentId andUserId:(NSString *)userId {
    return [[[[self getHost]stringByAppendingString:quitForcedUrl]stringByAppendingPathComponent:regimentId]stringByAppendingPathComponent:userId];
}

+ (NSString *)getElection {
    return [[self getHost] stringByAppendingString:electionUrl];
}

+ (NSString *)getCityEncode:(NSString *)cityName {
    return [[[[self getHost]stringByAppendingString:cityEncodeUrl]stringByAppendingString:@"?cityName="]stringByAppendingString:cityName];
}

+ (NSString *)getCirclesListDynamicUrl:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[self getHost] stringByAppendingString:circlesListDynamicUrl]stringByAppendingPathComponent:userId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getBenefitDynamicList:(NSString *)type andUserId:(NSString *)userId andLabelId:(NSString *)labelId andRows:(NSString *)rows andPage:(NSString *)page{
    
    return [[[[[[[self getHost] stringByAppendingString:benefitDynamicListUrl]stringByAppendingPathComponent:type]stringByAppendingPathComponent:userId] stringByAppendingPathComponent:labelId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)addBenefit {
    return [[self getHost] stringByAppendingString:addBendfitUrl];
}

+ (NSString *)getBenefitTagsWithUserId:(NSString *)userid{
    return [[[self getHost] stringByAppendingString:benefitTagsUrl] stringByAppendingPathComponent:userid];;
}

+(NSString *)changeBenefitPrice
{
    return [[self getHost]stringByAppendingString:changeBenefitPriceUrl];
}

+ (NSString *)uploadBenefitImage {
    return [[self getHost] stringByAppendingString:uploadBenefitImageUrl];
}

+ (NSString *)collectionBenefit:(NSString *)dynamicId andUserId:(NSString *)userId {
    return [[[[self getHost]stringByAppendingString:collectionBenefitUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:userId];
}

+ (NSString *)getBenefitAcceptList:(NSString *)dynamicId andStatus:(NSString *)status {
    return [[[[self getHost] stringByAppendingString:benefitAcceptListUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:status];
}

+ (NSString *)getBenefitSelfDetail:(NSString *)dynamicId acceptId:(NSString *)acceptId userId:(NSString *)userId rows:(NSString *)rows page:(NSString *)page{
    return [[[[[[[self getHost] stringByAppendingString:benefitSelfDetailUrl]stringByAppendingPathComponent:dynamicId] stringByAppendingPathComponent:acceptId] stringByAppendingPathComponent:userId] stringByAppendingPathComponent:rows] stringByAppendingPathComponent:page];
}

+ (NSString *)fetBenefitOtherDetail:(NSString *)dynamicId andUserId:(NSString *)userId {
    return [[[[self getHost]stringByAppendingString:benefitOtherDetailUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:userId];
}

+ (NSString *)benefitAccept {
    return [[self getHost] stringByAppendingString:benefitAcceptUrl];
}

+ (NSString *)deleteBenefitWithDynaicId:(NSString *)dynamicId {
    return [[[self getHost] stringByAppendingString:deleteBenefitUrl]stringByAppendingPathComponent:dynamicId];
}

+ (NSString *)addCirclesDynamic {
    return [[self getHost] stringByAppendingString:addCirclesDynamicUrl];
}

+ (NSString *)uploadCirclesImage {
    return [[self getHost] stringByAppendingString:uploadCirclesImageUrl];
}

+ (NSString *)addCirclesPraise:(NSString *)dynamicId andUserId:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:addCirclesPraiseUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:userId];
}

+ (NSString *)getCirclesDynamicDetail:(NSString *)dynamicId andUserId:(NSString *)userID{
    return [[[[self getHost] stringByAppendingString:circlesDynamicDetailUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:userID];;
}

+ (NSString *)getCirclesCommentList:(NSString *)dynamicId andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[self getHost] stringByAppendingString:circlesCommentListUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)addCirclesComment {
    return [[self getHost] stringByAppendingString:addCirclesCommentUrl];
}

+ (NSString *)getGroceryList:(NSString *)type andUserId:(NSString *)userId andKeywords:(NSString *)keywords andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[[[self getHost]stringByAppendingString:groceryListUrl]stringByAppendingPathComponent:type]stringByAppendingPathComponent:userId] stringByAppendingPathComponent:keywords]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getGroceryCommentList:(NSString *)dynamicId andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[self getHost] stringByAppendingString:groceryCommentListUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getGroceryDetail:(NSString *)dynamicId andUserid:(NSString *)userid{
    return [[[[self getHost] stringByAppendingString:groceryDetailUrl]stringByAppendingPathComponent:dynamicId] stringByAppendingPathComponent:userid];
}

+ (NSString *)addGrocertCommet {
    return [[self getHost] stringByAppendingString:grocertAddCommetUrl];
}

+ (NSString *)loadGrocery {
    return [[self getHost] stringByAppendingString:loadGroceryUrl];
}

+ (NSString *)collectGrocery:(NSString *)dynamicId andUserId:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:collectGroceryUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:userId];
}

+ (NSString *)groceryUpdateUrl{
    return [[self getHost] stringByAppendingString:groceryupdateUrl];
}

//生命的尊严
+ (NSString *)getFarewellWithUserId:(NSString *)userId Rows:(NSString *)rows anaPage:(NSString *)page{
    return [[[[[self getHost] stringByAppendingString:farewellUrl]stringByAppendingPathComponent:userId] stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)addFarewellDynamic {
    return [[self getHost] stringByAppendingString:farewellUrl];
}

+ (NSString *)uploadFarewellImage {
    return [[self getHost] stringByAppendingString:uploadFarewellImageUrl];
}

+ (NSString *)addLight{
    return [[self getHost] stringByAppendingString:addLightUrl];
}

+ (NSString *)getFarewellDynamicDetail:(NSString *)dynamicId andUserId:(NSString *)userId{
    return [[[[self getHost] stringByAppendingString:farewellDynamicDetailUrl]stringByAppendingPathComponent:userId] stringByAppendingPathComponent:dynamicId];
}

+ (NSString *)getFarewellCommentListWithDynacmicId:(NSString *)dynamicId parentId:(NSString *)parentId {
    return [[[[self getHost] stringByAppendingString:farewellCommentListUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:parentId];
}

//紧急救助

+ (NSString *)getAidList:(NSString *)type andUserId:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page{
    return [[[[[[self getHost] stringByAppendingString:aidListUrl]stringByAppendingPathComponent:type] stringByAppendingPathComponent:userId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)uploadAidImage {
    return [[self getHost]stringByAppendingString:uploadAidImageUrl];
}

+ (NSString *)addAidDynamic {
    return [[self getHost] stringByAppendingString:addAidDynamicUrl];
}

+ (NSString *)addAidComment {
    return [[self getHost] stringByAppendingString:addAidCommentUrl];
}

+(NSString *)aidCheck
{
    return [[self getHost]stringByAppendingString:aidCheckUrl];
}

//新型婚礼
+ (NSString *)getWeddingDynamicListWithRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[self getHost] stringByAppendingString:addWeddingDynamicUrl]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getWeddingDetailWithUserId:(NSString *)userId dynamicId:(NSString *)dynamicId{
    return [[[[self getHost] stringByAppendingString:weddingDetailUrl]stringByAppendingPathComponent:userId] stringByAppendingPathComponent:dynamicId];
}

+ (NSString *)getOwnWeddingWithUserId:(NSString *)userId {
    return [[[self getHost] stringByAppendingString:weddingOwnListUrl]stringByAppendingPathComponent:userId];
}

+ (NSString *)addWeddingComment {
    return [[self getHost] stringByAppendingString:addWeddingCommentUrl];
}

+(NSString *)getWeddingCommentListWithDynamic:(NSString *)dynamic parentId:(NSString *)parentId
{
    return [[[[self getHost]stringByAppendingString:weddingCommentsListUrl] stringByAppendingPathComponent:dynamic] stringByAppendingPathComponent:parentId];
}

+ (NSString *)addWeddingDynamic {
    return [[self getHost] stringByAppendingString:addWeddingDynamicUrl];
}

+ (NSString *)uploadWeddingImage {
    return [[self getHost] stringByAppendingString:uploadWeddingImageUrl];
}

+ (NSString *)addWeddingPraise:(NSString *)dynamicId andUserId:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:weddingAddPraiseUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:userId];
}

+ (NSString *)findJob {
    return [[self getHost] stringByAppendingString:findJobUrl];
}

+ (NSString *)findJobRecruitListWithUserId:(NSString *)userId rows:(NSString *)rows page:(NSString *)page {
    return [[[[[self getHost] stringByAppendingString:jobRecruitListUrl] stringByAppendingPathComponent:userId] stringByAppendingPathComponent:rows] stringByAppendingPathComponent:page];
}

+ (NSString *)reqJobHuntWithUserId:(NSString *)userId {
    return [[[self getHost] stringByAppendingString:reqJobHuntUrl] stringByAppendingPathComponent:userId];
}


+ (NSString *)getJobHuntDetail:(NSString *)jobId userId:(NSString *)userId{
    return [[[[self getHost] stringByAppendingString:jobHuntDetailUrl]stringByAppendingPathComponent:jobId] stringByAppendingPathComponent:userId];
}

+ (NSString *)getJobRecruitDetail:(NSString *)jobId; {
    return [[[self getHost] stringByAppendingString:jobRecruitUrl]stringByAppendingPathComponent:jobId];
}

+ (NSString *)addHunt {
    return [[self getHost] stringByAppendingString:addHuntUrl];
}

+ (NSString *)addGrocery {
    return [[self getHost]stringByAppendingString:addGroceryUrl];
}

+ (NSString *)uploadGroceryImage {
    return [[self getHost] stringByAppendingString:uploadGroceryImageUrl];
}

+ (NSString *)loveList {
    return [[self getHost]stringByAppendingString:loveListUrl];
}

+ (NSString *)addLove {
    return [[self getHost] stringByAppendingString:addLoveUrl];
}

+ (NSString *)getAidDynamicDetail:(NSString *)dynamicId  andUserId:(NSString *)userId{
    return [[[[self getHost] stringByAppendingString:aidDynamicDetailUrl]stringByAppendingPathComponent:dynamicId] stringByAppendingPathComponent:userId];
}

+ (NSString *)getAidCommentList:(NSString *)dynamicId andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[self getHost]stringByAppendingString:aidCommentListUrl] stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getCreditLimit {
    return [[self getHost] stringByAppendingString:creditLimitUrl];
}

+ (NSString *)getCreditRule {
    return [[self getHost] stringByAppendingString:creditRuleUrl];
}

+ (NSString *)collectionJober {
    return [[self getHost] stringByAppendingString:collectionJoberUrl];
}

+ (NSString *)getOwnCollectionListWithuserId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:ownCollectionListUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)getOwnCreateWithUserId:(NSString *)userId {
    return [[[self getHost] stringByAppendingString:ownCreateListUrl]stringByAppendingPathComponent:userId];
}

+ (NSString *)conditionrecruitUrl {
    return [[self getHost] stringByAppendingString:conditionrecruitUrl];
}

//通讯录
+ (NSString *)getAddrBookList:(NSString *)userId andType:(NSString *)type {
    return [[[[[[self getHost] stringByAppendingString:addrBookListUrl] stringByAppendingString:@"?userId="] stringByAppendingString:userId] stringByAppendingString:@"&type="]stringByAppendingString:type];
}

+ (NSString *)addBook {
    return [[self getHost] stringByAppendingString:addrbookUrl];
}

//我的

+ (NSString *)getAuthInfo:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:authInfoUrl]stringByAppendingString:@"?userId="]stringByAppendingString:userId];
}

+ (NSString *)getMyinfo:(NSString *)userId andOtherUserId:(NSString *)otherUserId{
    return [[self getHost]stringByAppendingString:@"/user/other_info"];
//    return [[[[[[self getHost] stringByAppendingString:my_infoUrl]stringByAppendingString:@"?userId="]stringByAppendingString:userId]stringByAppendingString:@"&userId2="]stringByAppendingString:otherUserId];
}

+ (NSString *)authAuto {
    return [[self getHost] stringByAppendingString:authAutoUrl];
}

+ (NSString *)authAdd {
    return [[self getHost] stringByAppendingString:authAddUrl];
}

+ (NSString *)uploadAuthImage {
    return [[self getHost] stringByAppendingString:uploadAuthImageUrl];
}

+ (NSString *)getWalletBanance:(NSString *)userId {
    return [[[self getHost] stringByAppendingString:walletBananceUrl]stringByAppendingPathComponent:userId];
}

+ (NSString *)getUserDetailInfo:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:userDetailInfoUrl]stringByAppendingString:@"?userId="]stringByAppendingString:userId];
}

+ (NSString *)userDetailEdit {
    return [[self getHost] stringByAppendingString:userDetailEditUrl];
}

+ (NSString *)userInfoEdit {
    return [[self getHost] stringByAppendingString:userInfoEditUrl];
}

+ (NSString *)my_info_edit
{
    return [[self getHost]stringByAppendingString:my_info_editUrl];
}

+ (NSString *)getblessDetailWithDynamicId:(NSString *)dynamicId {
    return [[[self getHost] stringByAppendingString:blessDetailUrl]stringByAppendingPathComponent:dynamicId];
}

+ (NSString *)getBlessCommentList:(NSString *)dynaimicId andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[self getHost] stringByAppendingString:getBlessCommentListUrl]stringByAppendingPathComponent:dynaimicId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)addBlessComment {
    return [[self getHost] stringByAppendingString:addBlessCommentUrl];
}

+ (NSString *)getUserCredit:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:@"/credit/info"]stringByAppendingString:@"?userId="]stringByAppendingString:userId];
}

+ (NSString *)getUser_userInfo:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:user_userInfoUrl]stringByAppendingString:@"?userId="]stringByAppendingString:userId];
}

+ (NSString *)getUserDic {
    return [[self getHost] stringByAppendingString:getUserDicUrl];
}

+ (NSString *)getUserUserMarriageAttitudeEditUrl {
    return [[self getHost]stringByAppendingString:userUserMarriageAttitudeEditUrl];
}

+ (NSString *)getUserUserMarriageAttitude:(NSString *)userId {
    return [[[[self getHost] stringByAppendingPathComponent:userUserMarriageAttitudeUrl]stringByAppendingString:@"?userId="]stringByAppendingString:userId];
}

+ (NSString *)getUserEducontext:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:userEducontextUrl]stringByAppendingString:@"?userId="]stringByAppendingString:userId];
}

+ (NSString *)editUserEdu {
    return [[self getHost] stringByAppendingString:userEduEditUrl];
}

+ (NSString *)userJobcontextEdit {
    return [[self getHost]stringByAppendingString:userJobcontextEditUrl];
}

+ (NSString *)getUserJobcontextList:(NSString *)userId{
    return [[[[self getHost] stringByAppendingString:userJobcontextUrl]stringByAppendingString:@"?userId="]stringByAppendingString:userId];
}

+ (NSString *)getUserSelfevaluate:(NSString *)userId {
    return [[[[self getHost]stringByAppendingString:userSelfevaluateUrl]stringByAppendingString:@"?userId="]stringByAppendingString:userId];
}


+ (NSString *)getUserSelfevaluateEdit {
    return [[self getHost] stringByAppendingString:userSelfevaluateEditUrl];
}

+ (NSString *)userHonorEdit {
    return [[self getHost] stringByAppendingString:userHonorEditUrl];
}

+ (NSString *)uploadUserHonorImage {
    return [[self getHost] stringByAppendingString:uploadUserHonorImageUrl];
}

+ (NSString *)voteMember {
    return [[self getHost] stringByAppendingString:voteMemberUrl];
}

+ (NSString *)getSpecialCandidate:(NSString *)regimentId {
    return [[[self getHost] stringByAppendingString:specialCandidateUrl]stringByAppendingPathComponent:regimentId];
}

+ (NSString *)searchFriendWithUserId:(NSString *)userId andKeywords:(NSString *)keywords rows:(NSString *)rows page:(NSString *)page{
    return [[[[[[self getHost] stringByAppendingString:searchFriendUrl]stringByAppendingPathComponent:userId] stringByAppendingPathComponent:keywords] stringByAppendingPathComponent:rows] stringByAppendingPathComponent:page];
}

+ (NSString *)addChat {
    return [[self getHost] stringByAppendingString:chatAddUrl];
}

+ (NSString *)getGroupListWithUserId:(NSString *)userId {
    return [[[self getHost] stringByAppendingString:groupListUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)getChatGroupInfoWitGroupId:(NSString *)groupId {
    return [[[self getHost] stringByAppendingString:chatGroupInfoUrl]stringByAppendingPathComponent:groupId];
}

+ (NSString *)chatSettingWithType:(NSString *)type{
    return [[[[self getHost] stringByAppendingString:chatSettingUrl]stringByAppendingString:@"?type="]stringByAppendingString:type];
}

+ (NSString *)chatSetting:(NSString *)groupId andUserId:(NSString *)userId andType:(NSString *)type{
    return [[[[[self getHost] stringByAppendingString:chatSettingUrl]stringByAppendingPathComponent:groupId]stringByAppendingPathComponent:userId] stringByAppendingPathComponent:type];
}

+ (NSString *)deleteBoolWithUser:(NSString *)userId andtgtUserid:(NSString *)tgtUserId andType:(NSString *)type{
    return [[[[[[[[self getHost] stringByAppendingString:deleteBookUrl]stringByAppendingString:@"?userId1="]stringByAppendingString:userId]stringByAppendingString:@"&userId2="]stringByAppendingString:tgtUserId]stringByAppendingString:@"&userType="]stringByAppendingString:type];
}

+ (NSString *)getMemberlist:(NSString *)groupId {
    return [[[self getHost] stringByAppendingString:memberlistUrl]stringByAppendingPathComponent:groupId];
}

+ (NSString *)addGroupMember
{
    return [[self getHost]stringByAppendingString:addGroupMemberUrl];
}

+ (NSString *)exitGroupChat
{
    return [[self getHost]stringByAppendingString:exitGroupChatUrl];
}

+ (NSString *)removeGroupMember {
    return [[self getHost]stringByAppendingString:removeGroupMemberUrl];
}

+ (NSString *)getUserScreeningWithUserId:(NSString *)userId andGroupId:(NSString *)groupId {
    return [[[[self getHost] stringByAppendingString:userScreeningUrl]stringByAppendingPathComponent:userId]stringByAppendingPathComponent:groupId];
}

+ (NSString *)getChatGroupUsersWithGroupId:(NSString *)groupId andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[self getHost] stringByAppendingString:chatGroupUsersUrl]stringByAppendingPathComponent:groupId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getRegimentSubOrganize {
    return [[self getHost] stringByAppendingString:regimentSubOrganizeUrl];
}

+ (NSString *)messageMe:(NSString *)moduleType :(NSString *)userId :(NSString *)rows :(NSString *)page{
    return [[[[[[self getHost] stringByAppendingString:messagelistUrl]stringByAppendingPathComponent:moduleType]stringByAppendingPathComponent:userId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)chatListMyMessageModuleType:(NSString *)moduleType userId:(NSString *)userid rows:(NSString *)row page:(NSString *)page
{
    return [[[[[[self getHost]stringByAppendingPathComponent:moduleType]stringByAppendingPathComponent:@"message"]stringByAppendingPathComponent:userid]stringByAppendingPathComponent:row]stringByAppendingPathComponent:page];
}

+ (NSString *)regimentResignPosition {
    return [[self getHost]stringByAppendingString:regimentResignPositionUrl];
}

+ (NSString *)regimentCheck {
    return [[self getHost] stringByAppendingString:regimentCheckUrl];
}

+ (NSString *)getAgreementWithModule:(NSString *)modeule {
    return [[[self getHost] stringByAppendingString:agreementUrl]stringByAppendingPathComponent:modeule];
}

+ (NSString *)getWalletDrawalListWithUserId:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[self getHost] stringByAppendingString:walletDrawalListUrl]stringByAppendingPathComponent:userId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getWalletBalanceWithUserId:(NSString *)userId {
    return [[[self getHost]stringByAppendingString:walletBalanceUrl]stringByAppendingPathComponent:userId];
}

+ (NSString *)addBalancePwd {
    return [[self getHost] stringByAppendingString:balanceAddPwdUrl];
}

+ (NSString *)deleteDynamicWithDynamicId:(NSString *)dynamicId andUserId:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:deleteDynamicUrl]stringByAppendingPathComponent:dynamicId]stringByAppendingPathComponent:userId];
}


+ (NSString *)walletDrawalAdd {
    return [[self getHost] stringByAppendingString:walletDrawalAddUrl];
}

+ (NSString *)pwd_modifyUrl {
    
    return [[self getHost] stringByAppendingString:pwd_retrieveUrl];

}

+ (NSString *)getRegimentCount {
    return [[self getHost] stringByAppendingString:regimentCountUrl];
}

+ (NSString *)candidateListWithRegimentId:(NSString *)regimentId andUserId:(NSString *)userId {
    return [[[[self getHost] stringByAppendingString:candidateListUrl]stringByAppendingPathComponent:regimentId]stringByAppendingPathComponent:userId];
}

+ (NSString *)getOtherCandidateListWithRegimentId:(NSString *)regimentId andUserId:(NSString *)userId andIndex:(NSString *)index {
    return [[[[[self getHost] stringByAppendingString:otherCandidateListUrl]stringByAppendingPathComponent:regimentId]stringByAppendingPathComponent:userId]stringByAppendingPathComponent:index];
}

+ (NSString *)appoint_position {
    return [[self getHost] stringByAppendingString:appoint_positionUrl];
}

+ (NSString *)updateAliPay {
    return [[self getHost] stringByAppendingString:updateAliPay];
}


+ (NSString *)walletPay {
    return [[self getHost] stringByAppendingString:walletPayUrl];
}

+ (NSString *)benefitAddComment {
    return [[self getHost] stringByAppendingString:benefitAddCommentUrl];
}

+ (NSString *)getCirclesMesageList:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[self getHost] stringByAppendingString:circlesMesageListUrl]stringByAppendingPathComponent:userId]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getMessageWithUserId:(NSString *)userId andModuleType:(NSString *)moduleType andRows:(NSString *)rows andPage:(NSString *)page {
    return [[[[[[self getHost] stringByAppendingString:messageUrl]stringByAppendingPathComponent:userId]stringByAppendingPathComponent:moduleType]stringByAppendingPathComponent:rows]stringByAppendingPathComponent:page];
}

+ (NSString *)getAddrbookCorner:(NSString *)userId andtype:(NSString *)type {
    return [[[[[[self getHost] stringByAppendingString:addrbookCornerUrl]stringByAppendingString:@"?userId="]stringByAppendingString:userId]stringByAppendingString:@"&type="]stringByAppendingString:type];
}

+ (NSString *)getRegimentResignDetail:(NSString *)resignApplyId {
    return [[self getHost] stringByAppendingString:regimentResign_detailUrl];
}

+ (NSString *)recallPosition {
    return [[self getHost] stringByAppendingString:recallPositionUrl];
}

+ (NSString *)farewellAddComment {
    return [[self getHost] stringByAppendingString:farewellAddCommentUrl];
}

+ (NSString *)getOwnFareWellListWithuserId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:ownFareWellListUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)cancelapply
{
    return [[self getHost]stringByAppendingString:cancelApplyUrl];
}

+ (NSString *)industryListUrl
{
    return [[self getHost]stringByAppendingString:@"/industry"];
}

+ (NSString *)mobileChange {
    return [[self getHost] stringByAppendingString:mobile_changeUrl];
}

+ (NSString *)getSettingsList {
    return [[self getHost] stringByAppendingString:settingsListUrl];
}

+ (NSString *)pwd_modify {
    return [[self getHost] stringByAppendingString:pwd_modifyUrl];
}

+ (NSString *)submitSuggest {
    return [[self getHost] stringByAppendingString:suggestUrl];
}

+ (NSString *)setting {
    return [[self getHost] stringByAppendingString:settingUrl];
}

+ (NSString *)userbBImgChange
{
    return [[self getHost]stringByAppendingString:userbBImgChangeUrl];
}

+ (NSString *)verifyCode
{
    return  [[self getHost]stringByAppendingString:verifyCodeUrl];
}

+ (NSString *)conversationReport
{
    return [[self getHost]stringByAppendingString:conversationReportUrl];
}

+ (NSString *)getWalletListWithUserId:(NSString *)userId andRows:(NSString *)row andPage:(NSString *)page
{
    return [[[[[self getHost] stringByAppendingString:walletOrderListUrl] stringByAppendingPathComponent:userId]stringByAppendingPathComponent:row]stringByAppendingPathComponent:page];
}

+ (NSString *)updatePosition
{
    return [[self getHost]stringByAppendingString:updatePositionUrl];
}

+ (NSString *)uploadCurrencyImage
{
    return [[self getHost]stringByAppendingString:uploadCurrencyImageUrl];
}

+ (NSString *)walletRecharge
{
    return [[self getHost]stringByAppendingString:walletRechargeUrl];
}

+ (NSString *)getUserSummaryWithUserId:(NSString *)userId
{
    return [[[[self getHost]stringByAppendingString:userSummaryUrl]stringByAppendingString:@"?userId="]stringByAppendingString:userId];
}

+ (NSString *)uploadMessageImage
{
    return [[self getHost]stringByAppendingString:uploadMessageImageUrl];
}

+ (NSString *)reloadGroupHeader
{
    return [[self getHost]stringByAppendingString:reloGroupHeaderUrl];
}

+ (NSString *)removeBlackMember
{
    return  [[self getHost] stringByAppendingString:removeBlackMemberUrl];
}

+ (NSString *)getMyBgImgWithuserId:(NSString *)userId Row:(NSString *)row andPage:(NSString *)page
{
    return [[[[[[self getHost] stringByAppendingString:getMyBgImgUrl]stringByAppendingPathComponent:@"2"] stringByAppendingPathComponent:userId]stringByAppendingPathComponent:row] stringByAppendingPathComponent:page];
}

+ (NSString *)benefitSoldOut
{
    return [[self getHost] stringByAppendingString:soldOutUrl];
}

+ (NSString *)getMyGroupOtherMemberWithGroupId:(NSString *)groupId andUserId:(NSString *)userId
{
    return [[[[self getHost] stringByAppendingString:chatJoinUserUrl] stringByAppendingPathComponent:groupId] stringByAppendingPathComponent:userId];
}

+ (NSString *)walletBindingAli
{
    return [[self getHost] stringByAppendingString:walletBindingAliUrl];
}

+ (NSString *)walletAuthorise
{
    return [[self getHost] stringByAppendingString:walletAuthoriseUrl];
}

+ (NSString *)benefitDelLogical
{
    return [[self getHost] stringByAppendingString:benefitDelLogicalUrl];
}

+ (NSString *)protectLogin
{
    return [[self getHost]stringByAppendingString:protectLoginUrl];
}

+ (NSString *)getOfficialDynamicListWithRows:(NSString *)row page:(NSString *)page{
    return [[[[self getHost] stringByAppendingString:officialListUrl] stringByAppendingPathComponent:row]stringByAppendingPathComponent:page];
}

+ (NSString *)FindLoveReport{
    return [[self getHost] stringByAppendingString:FindLoveReportUrl];
}

+ (NSString *)FindLoveMatchingWithUserId:(NSString *)userid{
    return [[[self getHost] stringByAppendingString:FindLoveMatchingUrl] stringByAppendingPathComponent:userid];
}

+ (NSString *)FindLoveInfoDetailWithuserId:(NSString *)userId otherId:(NSString *)otherId{
    return [[[[self getHost] stringByAppendingString:FindLoveInfoDetailUrl] stringByAppendingPathComponent:userId] stringByAppendingPathComponent:otherId];
}

+ (NSString *)FindLoveUserImagesWithUserId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:FindLoveUserImagesUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)FindLoveDeleteImage{
    return [[self getHost] stringByAppendingString:FindLoveUserImagesUrl];
}

+ (NSString *)FindLoveUploadImage{
    return [[self getHost] stringByAppendingString:FindLoveUserImagesUrl];
}

+ (NSString *)UploadFindLoveImage{
    return [[self getHost] stringByAppendingString:UploadFindLoveImageurl];
}

+ (NSString *)FindLoveScopeWithType:(NSString *)type{
    return [[[self getHost] stringByAppendingString:FindLoveScopeUrl] stringByAppendingPathComponent:type];
}

+ (NSString *)FindLoveGetLabelWithUserId:(NSString *)userId labelType:(NSString *)labelType{
    return [[[[self getHost] stringByAppendingString:FindLoveLabelListUrl] stringByAppendingPathComponent:userId] stringByAppendingPathComponent:labelType];
}

+ (NSString *)FindLoveAddLabel{
    return [[self getHost] stringByAppendingString:FindLoveLabelListUrl];
}

+ (NSString *)FindLoveEditInfo{
    return [[self getHost] stringByAppendingString:FindLoveEditInfoUrl];
}

+ (NSString *)FindLoveLikeListWithUserId:(NSString *)userId status:(NSString *)status{
    return [[[[self getHost] stringByAppendingString:FindLoveLikeListUrl] stringByAppendingPathComponent:userId] stringByAppendingPathComponent:status];
}

+ (NSString *)FindLoveDeleteMatching{
    return [[self getHost] stringByAppendingString:FindLoveMatchingUrl];
}

+ (NSString *)FindLoveTag{
    return [[self getHost] stringByAppendingString:FindLoveTagUrl];
}

+ (NSString *)FindLoveScreening{
    return [[self getHost] stringByAppendingString:FindLoveScreeningUrl];
}

+ (NSString *)FindLoveGetScreeningWithUsrId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:FindLoveScreeningUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)FinfLoveCheckWithUserId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:FindLoveCheckUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)FindLoveContact{
    return [[self getHost] stringByAppendingString:FindLoveContactUrl];
}

+ (NSString *)getRegimentApplicantWithRegimentId:(NSString *)regiment userId:(NSString *)userId{
    return [[[[self getHost] stringByAppendingString:regimentApplicantUrl] stringByAppendingPathComponent:regiment] stringByAppendingPathComponent:userId];
}

+ (NSString *)searchBenefitWithUserId:(NSString *)userId srange:(NSString *)range keywords:(NSString *)keywords{
    return [[[[[self getHost] stringByAppendingString:searchBenefitUrl] stringByAppendingPathComponent:userId] stringByAppendingPathComponent:range] stringByAppendingPathComponent:keywords];
}

+ (NSString *)findUnReadNumberWithUserId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:findUnReadNumberUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)uploadJoberImage{
    return [[self getHost] stringByAppendingString:uploadJoberImageUrl];
}

+ (NSString *)getOwnJobScreeningWithUserId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:groceryupdateUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)getJobIndustry{
    return [[self getHost] stringByAppendingString:JobIndustryUrl];
}

+ (NSString *)getThemeHot{
    return [[self getHost] stringByAppendingString:ThemeHotUrl];
}

+ (NSString *)getThemeDetailWithThemeId:(NSString *)themeId userId:(NSString *)userId{
    return [[[[self getHost] stringByAppendingString:ThemeDetailUrl] stringByAppendingPathComponent:themeId] stringByAppendingPathComponent:userId];
}

+ (NSString *)getThemeFirstCommentsWithThemeId:(NSString *)themeId rows:(NSString *)rows page:(NSString *)page{
    return [[[[[self getHost] stringByAppendingString:ThemeFirstConmentsUrl] stringByAppendingPathComponent:themeId] stringByAppendingPathComponent:rows] stringByAppendingPathComponent:page];
}

+ (NSString *)getOwnThemeListWithUserId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:OwnThemeListUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)joinTheme{
    return [[self getHost] stringByAppendingString:JoinThemeUrl];
}

+ (NSString *)getThemeMemberListWithThemeId:(NSString *)themeId rows:(NSString *)rows page:(NSString *)page{
    return [[[[[self getHost] stringByAppendingString:ThemeMemberListUrl] stringByAppendingPathComponent:themeId] stringByAppendingPathComponent:rows] stringByAppendingPathComponent:page];
}

+ (NSString *)getThemeScreeningWithUserId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:ThemeScreeningUrl] stringByAppendingPathComponent:userId];;
}

+ (NSString *)getThemeCommentListWithThemeId:(NSString *)themeId parentId:(NSString *)parentId{
    return [[[[self getHost] stringByAppendingString:ThemeSecondConmentsUrl] stringByAppendingPathComponent:themeId] stringByAppendingPathComponent:parentId];
}

+ (NSString *)addThemeComment{
    return [[self getHost] stringByAppendingString:AddThemeCommentUrl];
}

+ (NSString *)uploadThemeImage{
    return [[self getHost] stringByAppendingString:UploadThemeImageUrl];
}

+ (NSString *)addTheme{
    return [[self getHost] stringByAppendingString:AddThemeUrl];
}

+ (NSString *)getThemeDynamicListWithUserId:(NSString *)userId regimentId:(NSString *)regimentId moduleId:(NSString *)moduleId rows:(NSString *)row page:(NSString *)page{
    return [[[[[[[self getHost] stringByAppendingString:ThemeDynamicListUrl] stringByAppendingPathComponent:userId] stringByAppendingPathComponent:regimentId] stringByAppendingPathComponent:moduleId] stringByAppendingPathComponent:row] stringByAppendingPathComponent:page];
}

+ (NSString *)getOtherThemeRegimentDynamicListWithRegimentId:(NSString *)regimentId userId:(NSString *)userId rows:(NSString *)rows page:(NSString *)page{
    return [[[[[[self getHost] stringByAppendingString:OtherThemeRegimentDynamicListUrl] stringByAppendingPathComponent:regimentId] stringByAppendingPathComponent:userId] stringByAppendingPathComponent:rows] stringByAppendingPathComponent:page];
}

+ (NSString *)themeDynamicPraise{
    return [[self getHost] stringByAppendingString:ThemeDynamicPraiseUrl];
}

+ (NSString *)getThemeBadgeNumberWithUserId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:ThemeBadgeNumberUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)getOwnThemeDynamicListWithUserId:(NSString *)userId rows:(NSString *)rows page:(NSString *)page{
    return [[[[[self getHost] stringByAppendingString:OwnThemeDynamicListUrl] stringByAppendingPathComponent:userId] stringByAppendingPathComponent:rows] stringByAppendingPathComponent:page];
}

+ (NSString *)getOtherDynamicListWithOwnUserId:(NSString *)ownUserId otherId:(NSString *)otherId rows:(NSString *)rows page:(NSString *)page{
    return [[[[[[self getHost] stringByAppendingString:OtherDynamicListUrl] stringByAppendingPathComponent:ownUserId] stringByAppendingPathComponent:otherId] stringByAppendingPathComponent:rows] stringByAppendingPathComponent:page];
}

+ (NSString *)getuserShareWithUserId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:UserShareUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)getInvitationRankingWithUsrId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:InvitationRankingListUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)addFillInviter{
    return[[self getHost] stringByAppendingString:UserFillInviterUrl];
}

+ (NSString *)getNearUserListWithUserId:(NSString *)userId{
    return [[[self getHost] stringByAppendingString:NearUserListUrl] stringByAppendingPathComponent:userId];
}

+ (NSString *)uploadCredentialImage{
    return [[self getHost] stringByAppendingString:credentialImageUrl];
}

+ (NSString *)uploadTalentImage{
    return [[self getHost] stringByAppendingString:uploadTalentImageUrl];
}

@end
