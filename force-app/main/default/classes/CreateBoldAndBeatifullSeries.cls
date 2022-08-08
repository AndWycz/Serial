global with sharing class CreateBoldAndBeatifullSeries implements Database.Batchable<Episode__c>, Database.Stateful{
    private Integer intParameter;

    public CreateBoldAndBeatifullSeries(Integer intParam) {
        intParameter = intParam;
    }
    global Iterable<Episode__c> start(Database.BatchableContext BC){
        return new EpisodeIterable(intParameter);
    }
    global void execute(Database.BatchableContext BC, List<Episode__c> scope){
        List<Episode__c> epsToInsert = new List<Episode__c>();
        
        System.debug('dodałem sezon');
        for(Episode__c ep : scope){
            ep.Season__c = 'a037Q000001XOrc';
            epsToInsert.add(ep);
        }
        insert epsToInsert;
        if(!Test.isRunningTest()){
            System.AbortJob(BC.getJobId());
        }

    }
    global void finish(Database.BatchableContext BC){
        
    }
}
