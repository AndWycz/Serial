@isTest
public with sharing class CreateBoldAndBeatifullTest {
    @isTest
    public static void CreateBoldAndBeatifullTest() {
        Test.startTest();
        CreateBoldAndBeatifullSeries cBABS = new CreateBoldAndBeatifullSeries(100);
        Id jobId = Database.executeBatch(cBABS, 200);
        Test.stopTest();
        System.assertEquals(99, [SELECT COUNT() FROM Episode__c WHERE Season__c = 'a037Q000001XOrc']);
    }
}
