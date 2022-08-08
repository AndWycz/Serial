@isTest
public with sharing class CheckIfActorAlreadyExistTest {
    @isTest
    public static void CheckIfActorAlreadyExistTest() {
        Actor__c act1 = new Actor__c(Name = 'test');
        insert act1;
        try {
            Actor__c act2 = new Actor__c(Name = 'test');
            insert act2;
        } catch (Exception e) {
            System.debug(e.getStackTraceString());         
        }
        Integer i = [SELECT COUNT() FROM Actor__c WHERE Name = 'test'];
        System.assertEquals(1, i);
    }
    public static void CheckIfActorAlreadyExistMultipleEntriesTest() {
        Actor__c act1 = new Actor__c(Name = 'test');
        insert act1;
        List<Actor__c> lista = new List<Actor__c>();
        for(Integer i = 0; i< 50; i++){
            Actor__c act2 = new Actor__c(Name = 'test');
            lista.add(act2);
        }
        try {
               
            insert lista;
        } catch (Exception e) {
            System.debug(e.getStackTraceString());         
        }
        
        Integer i = [SELECT COUNT() FROM Actor__c WHERE Name = 'test'];
        System.assertEquals(1, i);
    }
}
