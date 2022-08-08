@isTest
public with sharing class RatingCheckerTest {
    static String CRON_EXP ='*/5 * * * *';
    
    private class RestMock implements HttpCalloutMock {

        public HTTPResponse respond(HTTPRequest req) {
            Map<String, String> insideResponse = new Map<String,String>();
            Map<String, Object> response = new Map<String,Object>();
            insideResponse.put('Source', 'Internet Movie Database');
            insideResponse.put('Value', '"8.7/10"');
            response.put('Ratings', insideResponse);
            

            HTTPResponse res = new HTTPResponse();
            res.setHeader('Content-Type', 'text/json');
            res.setBody(JSON.serialize(response));
            res.setStatusCode(200);
            return res;
        }
    }
    @isTest
    static void RatingCheckerTest()
    {
        Serial__c ser = new Serial__c(
            Name = 'The Boys',
            Opis_serialu__c ='"A group of vigilantes set out to take down corrupt superheroes who abuse their superpowers.');
        insert ser;
        Test.setMock(HttpCalloutMock.class, new RestMock());
        Test.startTest();
        RatingChecker RC = new RatingChecker();
        Id jobId = Database.executeBatch(RC);
        Test.stopTest();
        Serial__c ser2 = [SELECT Rating__c FROM Serial__c WHERE Id = :ser.Id];
        System.assertEquals('8.7/10', ser2.Rating__c);
    }
    @isTest
    public static void ScheduleRatingCheckerTest() {
        Serial__c ser = new Serial__c(
            Name = 'The Boys',
            Opis_serialu__c ='"A group of vigilantes set out to take down corrupt superheroes who abuse their superpowers.');
        insert ser;
        Test.setMock(HttpCalloutMock.class, new RestMock());
        Test.startTest();
        ScheduleRatingChecker SRC = new ScheduleRatingChecker();
        SchedulableContext sc = null;
        SRC.execute(sc);
        // String jobId= System.schedule('job', CRON_EXP, SRC );
        
        Test.stopTest();
        Serial__c ser2 = [SELECT Rating__c FROM Serial__c WHERE Id = :ser.Id];
        System.assertEquals('8.7/10', ser2.Rating__c);
    }
   
}
