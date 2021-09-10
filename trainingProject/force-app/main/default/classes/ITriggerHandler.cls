/**
 *File Name     : ITriggerHandler
 *@description  : トリガハンドラーのインターフェース
 *Author        : zhi.b.zhang
 *CreatedDate   : 2021/02/02
 *UpdatedDate   :
 */
public interface ITriggerHandler {
    /**
     *  @description 挿入前処理
     *  @param newItems SObjectのリスト(更新後)
     */
    void beforeInsert(SObject[] newItems);
  
    /**
     *  @description 更新前処理
     *  @param newItems SObjectのマップ(更新後)
     *  @param oldItems SObjectのマップ(更新前)
     */
    void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems);
  
    /**
     *  @description 削除前処理
     *  @param oldItems SObjectのマップ(更新前)
     */
    void beforeDelete(Map<Id, SObject> oldItems);
  
    /**
     *  @description 挿入後処理
     *  @param newItems SObjectのマップ(更新後)
     */
    void afterInsert(Map<Id, SObject> newItems);
  
    /**
     *  @description 更新後処理
     *  @param newItems SObjectのマップ(更新後)
     *  @param oldItems SObjectのマップ(更新前)
     */
    void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems);
  
    /**
     *  @description 削除後処理
     *  @param oldItems SObjectのマップ(更新前)
     */
    void afterDelete(Map<Id, SObject> oldItems);
  
    /**
     *  @description 削除取り戻し後処理
     *  @param oldItems SObjectのマップ(更新前)
     */
    void afterUndelete(Map<Id, SObject> oldItems);
  
    /**
     *  @description トリガ無効化フラグを取得
     *  @return Boolean トリガ無効化フラグの値
     */
    Boolean isDisabled();
  }