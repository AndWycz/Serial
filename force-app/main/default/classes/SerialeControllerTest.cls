@isTest
public with sharing class SerialeControllerTest {
    private class RestMock implements HttpCalloutMock {

        public HTTPResponse respond(HTTPRequest req) {
            String fullJson = 'your Json Response';

            HTTPResponse res = new HTTPResponse();
            res.setHeader('Content-Type', 'text/json');
            res.setBody(fullJson);
            res.setStatusCode(200);
            return res;
        }
    }
    @isTest
    static void queryEpisodesWithSerialTest() {

        Serial__c ser = new Serial__C(Name = 'test', Opis_serialu__c = 'Dłuuuuuuugi Opissssssssssssss Serialuuuuuuuuuuu' );
        insert ser;
        Season__c sea = new Season__c(Name = 'S1', Serial__c = ser.Id);
        insert sea;

        List<Episode__c> listOfEps = new List<Episode__c>();
        for(Integer i = 0; i < 9 ; i++){
            Episode__c ep = new Episode__c(Name = 'E'+i, Season__c = sea.Id);
            listOfEps.add(ep);
        }
        insert listOfEps;
        System.assertNotEquals(Null, ser.Id);
        List<Episode__c> listOfEpsTest = SerialeController.queryEpisodesWithSerial(ser.Id);
        System.assertEquals(9, listOfEpsTest.size());
    }
    @isTest
    public static void querySeriesWithId(){
        Serial__c ser = new Serial__C(Name = 'test', Opis_serialu__c = 'Dłuuuuuuugi Opissssssssssssss Serialuuuuuuuuuuu' );
        insert ser;
        Serial__c serFromQuery = SerialeController.querySeriesWithId(ser.Id);
        System.assertEquals(ser, serFromQuery);
    }
    @isTest
    static void querySeasonsWithSerialTest(){
        Serial__c ser = new Serial__C(Name = 'test', Opis_serialu__c = 'Dłuuuuuuugi Opissssssssssssss Serialuuuuuuuuuuu' );
        insert ser;
        List<Season__c> addSea = new List<Season__c>();
        for(Integer i = 0; i<3; i++){
            Season__c sea = new Season__c(Name=''+i, Serial__c = ser.Id);
            addSea.add(sea);
        }
        insert addSea;
        List<Season__c> lista = SerialeController.querySeasonsWithSerial(ser.Id);
        System.assertEquals(3, lista.size());
        System.assertEquals('0', lista.get(0).Name);
    }
    @isTest
    static void queryActorsFromSerialTest(){
        Serial__c ser = new Serial__C(Name = 'test', Opis_serialu__c = 'Dłuuuuuuugi Opissssssssssssss Serialuuuuuuuuuuu' );
        insert ser;
        List<Actor__c> lis = new List<Actor__c>();
        for(Integer i = 0; i< 4 ; i++){
            Actor__c act = new Actor__c(Name='Test'+i);
            lis.add(act);
        }
        insert lis;
        List<ActorSerialAssociation__c> lis2 = new List<ActorSerialAssociation__c>();
        for(Integer i =0; i<lis.size(); i++){
            ActorSerialAssociation__c aSA = new ActorSerialAssociation__c(Serial__c = ser.Id, Actor__c = lis.get(i).Id);
            lis2.add(aSA);
        }
        insert lis2;
        List<Actor__c> lista = SerialeController.queryActorsFromSerial(ser.Id);
        System.assert(!lista.isEmpty());
        System.assert(lista.size()==4);
    }
    @isTest
    public static void insertEpisodeTest(){
        Serial__c ser = new Serial__C(Name = 'test', Opis_serialu__c = 'Dłuuuuuuugi Opissssssssssssss Serialuuuuuuuuuuu' );
        insert ser;
        Season__c sea = new Season__c(Name='Season 1', Serial__c = ser.Id);
        insert sea;
        for(Integer i = 0; i<10 ; i++){
            Episode__c epi = new Episode__c(Name = 'testing', Season__c = sea.Id);
            SerialeController.insertEpisode(epi);
        }
        System.assertEquals(1, [SELECT COUNT() FROM Episode__c WHERE Season__c = :sea.Id]);
    }    
}
