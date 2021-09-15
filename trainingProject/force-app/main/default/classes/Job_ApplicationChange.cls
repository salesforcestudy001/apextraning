public with sharing class Job_ApplicationChange extends TriggerHandlerAdapter{
    
    FunctionRealization fr = new FunctionRealization();
    //実現クラスを作成

    public override void beforeInsert(List<SObject> newItems) {
        fr.BangoInsert(newItems);
        //挿入する前に番号を生成
    }

    public override void afterDelete(Map<Id, SObject> oldItems){
        fr.HeikinKibouKyuryou();
        //平均希望給料の計算（削除後）
    }

    public override void afterInsert(Map<Id, SObject> newItems){
        fr.HeikinKibouKyuryou();
        //平均希望給料の計算（挿入後）
    }

    public override void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){
        fr.HeikinKibouKyuryou();
        //平均希望給料の計算（更新後）
    }
}
