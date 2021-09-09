/**
 *File Name     : FACE_AccountTriggerHandler
 *@description  : ブランド店舗トリガハンドラー
 *Author        : Accenture,zhenghao.tang
 *CreatedDate   : 2021/2/8
 *UpdatedDate   :
 */
public without sharing class FACE_AccountTriggerHandler extends TriggerHandlerAdapter {
    // ブランド店舗トリガ無効化フラグ
    public static Boolean triggerDisabled = false;
    /**
     *  @description ブランド店舗トリガ無効化フラグを取得
     *  @return triggerDisabled
     */
    public override Boolean isDisabled() {
      return triggerDisabled;
    }
    /**
     *  @description 挿入前処理
     *  @param newItems
     */
    public override void beforeInsert(List<SObject> newItems) {
      // レコード新規作成時、所有者変更処理をする
      changeOwner((List<Account>) newItems);
    }
    /**
     *  @description 挿入後処理
     *  @param newItems
     */
    public override void afterInsert(Map<Id, SObject> newItems) {
      // レコード新規作成後、グループ割当処理をする
      shareGroupForInsert((Map<Id, Account>) newItems);
    }
    /**
     *  @description 更新後処理
     *  @param newItems
     *  @param oldItems
     */
    public override void afterUpdate(
      Map<Id, SObject> newItems,
      Map<Id, SObject> oldItems
    ) {
      // レコード更新後、グループ割当処理をする
      shareGroupForUpdate(
        (Map<Id, Account>) newItems,
        (Map<Id, Account>) oldItems
      );
    }
    /**
     *  @description レコード新規作成時、所有者変更処理をする
     *  @param accountList
     */
    private void changeOwner(List<Account> accountList) {
      // ログインユーザのプロファイルFlag
      Boolean systemAdmingInterfaceProfileFlag = false;
      systemAdmingInterfaceProfileFlag = FACE_CommonFunction.judgeLoginUserProfile();
      // ログインユーザのプロファイルはインターフェイスとシステム管理者プロファイル以外の場合
      if (systemAdmingInterfaceProfileFlag) {
        // システム管理者ユーザのSalesforceIDを取得する
        User systemUser = new User();
        try {
          systemUser = FACE_UserDao.getUserByName(
            System.Label.FACE_COM_OwnerSystemAdminName
          );
        } catch (Exception e) {
          // 変更先の所有者ユーザ（システム管理者）が存在しない場合
          for (Integer i = 0; i < accountList.size(); i++) {
            Trigger.new[i].adderror(System.Label.FACE_MSG_OwnerNotExist);
          }
          return;
        }
        Id systemUserId = systemUser.Id;
        System.debug('systemUserId ' + systemUserId);
        for (Account account : accountList) {
          account.OwnerId = systemUserId;
        }
      }
    }
    /**
     *  @description レコード新規作成後、グループ割当処理をする
     *  @param accountNewMap
     */
    private void shareGroupForInsert(Map<Id, Account> accountNewMap) {
      // ブランド店舗Map
      Map<Id, Account> accountMap = new Map<Id, Account>();
      // オブジェクAPI名前
      String objectAPIName = 'Account';
      for (Id accountId : accountNewMap.keySet()) {
        Account account = accountNewMap.get(accountId);
        if (
          account.SalesOrganizationCd__c != null &&
          account.CounterBrandCd__c != null &&
          account.BranchCode__c != null
        ) {
          accountMap.put(accountId, account);
        }
      }
      if (accountMap != null && accountMap.size() > 0) {
        // グループ割当処理
        try {
          FACE_CommonFunction.shareGroup(objectAPIName, accountMap);
        } catch (FACE_CommonFunction.CustomException e) {
          // カスタムメタデータ型「権限制御設定」には権限設定情報が設定されていない場合
          for (Integer i = 0; i < accountMap.size(); i++) {
            Trigger.new[i].adderror(e.getMessage());
          }
        }
      }
    }
    /**
     *  @description レコード更新後、グループ割当処理をする
     *  @param accountNewMap
     *  @param accountOldMap
     */
    private void shareGroupForUpdate(
      Map<Id, Account> accountNewMap,
      Map<Id, Account> accountOldMap
    ) {
      // グループ割当処理要更新後のブランド店舗Map
      Map<Id, Account> shareGroupAccountMap = new Map<Id, Account>();
      // オブジェクAPI名前
      String objectAPIName = 'Account';
      for (Id accountId : accountNewMap.keySet()) {
        Account newAccount = accountNewMap.get(accountId);
        Account oldAccount = accountOldMap.get(accountId);
        // 店舗コード変更場合、グループ割当処理をする
        if (newAccount.BranchCode__c != oldAccount.BranchCode__c) {
          shareGroupAccountMap.put(accountId, newAccount);
        }
      }
      // グループ割当処理
      if (shareGroupAccountMap != null && shareGroupAccountMap.size() > 0) {
        try {
          FACE_CommonFunction.shareGroup(objectAPIName, shareGroupAccountMap);
        } catch (FACE_CommonFunction.CustomException e) {
          // カスタムメタデータ型「権限制御設定」には権限設定情報が設定されていない場合
          for (Integer i = 0; i < shareGroupAccountMap.size(); i++) {
            Trigger.new[i].adderror(e.getMessage());
          }
        }
      }
    }
  }
  