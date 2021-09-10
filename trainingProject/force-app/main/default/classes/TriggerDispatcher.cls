
public class TriggerDispatcher {
    /**
     *  @description ディスパッチャーを実行
     *  @param handler トリガのハンドラー
     *  @param triggerEvent トリガのイベント
     */
    public static void run(
      TriggerHandlerAdapter handler,
      System.TriggerOperation triggerEvent
    ) {
      // トリガ無効化フラグがTrueの場合、処理を終了
      if (handler.isDisabled())
        return;
  
      // トリガのイベントより関連処理を呼び出す
  
      switch on triggerEvent {
        when BEFORE_INSERT {
          handler.beforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE {
          handler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
        }
        when BEFORE_DELETE {
          handler.beforeDelete(Trigger.oldMap);
        }
        when AFTER_INSERT {
          handler.afterInsert(Trigger.newMap);
        }
        when AFTER_UPDATE {
          handler.afterUpdate(Trigger.newMap, Trigger.oldMap);
        }
        when AFTER_DELETE {
          handler.afterDelete(Trigger.oldMap);
        }
        when AFTER_UNDELETE {
          handler.afterUndelete(Trigger.oldMap);
        }
      }
    }
  }