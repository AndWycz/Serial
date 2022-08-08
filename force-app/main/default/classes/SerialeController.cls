public with sharing class SerialeController {
    @AuraEnabled
    public static List<Episode__c> queryEpisodesWithSerial(Id serialId) {
        return [SELECT Name, Id FROM Episode__c WHERE Season__c IN (SELECT Id FROM Season__c WHERE Serial__c = :serialId) ];
    }
    @AuraEnabled
    public static Serial__c querySeriesWithId(Id recordId) {
        return [SELECT Name, Opis_serialu__c, Url_for_logo__c, Url_to_trailer__c
        FROM Serial__c WHERE Id = :recordId LIMIT 1];
    }
    @AuraEnabled
    public static List<Season__c> querySeasonsWithSerial(Id SerialId){
       return [SELECT Name, Id FROM Season__c WHERE Serial__c = :SerialId];
    }
    @AuraEnabled
    public static Id insertEpisode(Episode__c epi){
        List <Episode__c> epiList = [SELECT Id, Name FROM Episode__c WHERE Name = :epi.Name];
        if(epiList.size()<1 && epi.Name.length() > 1){
            try{
                insert epi;
            }catch(Exception ex) {
                System.debug(ex);
            }
            
        }
        return epi.Id;
    }
    @AuraEnabled
    public static List<Actor__c> queryActorsFromSerial(Id serialId){
        // if(!isAllowedIdType(serialId, Serial__c)){
        //     return null;
        // }
        return [SELECT Name, Id FROM Actor__c WHERE Id IN (SELECT Actor__c FROM ActorSerialAssociation__c
        WHERE Serial__c = :serialId)]; 
    }
    @AuraEnabled
    public static List<Episode__c> queryEpisodesFromSeason(Id seasonId){
    //    if(!isAllowedIdType(seasonId, Season__c)){
    //     return null;
    //    }
       return [SELECT Name, Id, Episode_details__c FROM Episode__c WHERE Season__c = :seasonId];
    }
    public static Boolean isAllowedIdType( String inputId, String objectType )
{
    if ( !String.isBlank( inputId ) && inputId instanceof Id )
    {
        Id verifyId = Id.valueOf( inputId );
        if ( objectType.equalsIgnoreCase( verifyId.getSobjectType( ).getDescribe( ).getName( ) ) )
        {
            return true;
        }
    }
    return false;
    }
}
