global class EpisodeIterable implements Iterable<Episode__c>{
    Integer numOfRepeats;
    public EpisodeIterable(Integer numberOfRepeats ){
        numOfRepeats = numberOfRepeats;
    }
    public Iterator<Episode__c> iterator(){
        List<Episode__c> eps = new List<Episode__c>();
        for(Integer i = 0; i < numOfRepeats; i++){
            Episode__c Episode = new Episode__c (Name='Episode '+(i+1));
            eps.add(Episode);
        }
        return new EpisodeIterator(eps);
        
    }

}