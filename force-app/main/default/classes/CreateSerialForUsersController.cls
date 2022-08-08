public with sharing class CreateSerialForUsersController {

    @AuraEnabled
    public static Id insertSerial(Serial__c ser){
        Integer serList = [SELECT COUNT() FROM Serial__c WHERE Name = :ser.Name];
        Id serId = null;
        if(serList<1){
            try{
                insert ser;
                serId = ser.Id;
            }catch(Exception ex) {
                System.debug(ex);
            }
            
        }
        return ser.Id;
    }
}
