@isTest
public with sharing class CreateSerialForUsersControllerTest {
    @isTest
    public static void justOneSeries() {
        Id serId;
        Serial__c ser = new Serial__c(Name = 'test', Opis_serialu__c = 'Dłuuuuuuugi Opissssssssssssss Serialuuuuuuuuuuu' );
        try{
            serId = CreateSerialForUsersController.insertSerial(ser);
        }catch(Exception er){
            System.debug(er.getStackTraceString());
        }
        System.debug(serId);
        System.assert(serId != null);

    }
    @isTest
    public static void twoOfTheSameSeries(){
        Id serId;
        Serial__c ser = new Serial__c(Name = 'test', Opis_serialu__c = 'Dłuuuuuuugi Opissssssssssssss Serialuuuuuuuuuuu' );
        try{
            CreateSerialForUsersController.insertSerial(ser);
        }catch(Exception er){
            System.debug(er.getStackTraceString());
        }
        Serial__c ser2 = new Serial__c(Name = 'test', Opis_serialu__c = 'Dłuuuuuuugi Opissssssssssssss Serialuuuuuuuuuuu2' );
        try{
            serId = CreateSerialForUsersController.insertSerial(ser2);
        }catch(Exception er){
            System.debug(er.getStackTraceString());
        }
        System.debug(serId);
        System.assert(serId == null);
    }
}
