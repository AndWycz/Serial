public with sharing class EpisodeIterator implements Iterator<Episode__c>{
    private List<Episode__c> eps;
    private Integer currentIndex;
    public EpisodeIterator(List<Episode__c> eps){
        this.eps = eps;
        this.currentIndex = 0;
    }
    public boolean hasNext(){ 
        return currentIndex < eps.size() - 1;
    } 
    public Episode__c next(){
        if(hasNext()){
            currentIndex++;
            return eps[currentIndex];
        }else{
            throw new  NoSuchElementException();
        }
    }
}
