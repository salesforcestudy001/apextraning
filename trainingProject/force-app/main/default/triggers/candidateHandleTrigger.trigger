trigger candidateHandleTrigger on Candidate2__c (before insert) {
    List<Candidate2__c> canList = [select CandidateNo__c from Candidate2__c];
    List<Decimal> CanNo = new List<Decimal>();
    for (Candidate2__c can : canList) {
        CanNo.add(can.CandidateNo__c);
    }
    canNo.sort();
    for (Candidate2__c can : trigger.new) {
        if (can.CandidateNo__c==null) {
            can.CandidateNo__c=canNo[canNo.size()-1]+1;
        }
    }
}