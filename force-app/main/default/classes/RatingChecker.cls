global without sharing class RatingChecker implements Database.AllowsCallouts, Database.Batchable<sObject>  {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,Name, Rating__c FROM Serial__c';
        System.debug(query);
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Serial__c> scope){
        List<Serial__c> toUpdate = new List<Serial__c>();
        System.debug('Jestem w execute. Lista to '+toUpdate);
        for(Serial__c ser : scope){
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            String nameInString = ser.Name;
            if(nameInString.containsWhitespace()){
                nameInString =nameInString.replace(' ', '%20');
            }
            req.setEndpoint('http://www.omdbapi.com/?apikey=9624749d&type=series&r=json&t='+nameInString);
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            try{
                Map<String,Object> m = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                // System.debug(m);
                Object m2 = m.get('Ratings');
                // System.debug(m2);
                String m3 = m2.toString();
                // System.debug(m3);
                String m4 = m3.substring(m3.length()-8, m3.length()-2);
                // System.debug(m4);
                System.debug(ser.Rating__c);
                ser.Rating__c=m4;
                System.debug(ser.Rating__c);
    
                toUpdate.add(ser);
                System.debug('dodaję kolejny serial do listy. Lista teraz to '+toUpdate);
            }catch(Exception e){
                System.debug('Stack trace '+e.getStackTraceString());
            }
           
        }
        System.debug(toUpdate.size());
        for(Serial__c ser : toUpdate){
            System.debug(ser.Rating__c);
        }
        System.debug(toUpdate);
        update toUpdate;
        for(Serial__c ser : toUpdate){
            System.debug(ser.Rating__c);
        }

    }
    global void finish(Database.BatchableContext BC){}
}
