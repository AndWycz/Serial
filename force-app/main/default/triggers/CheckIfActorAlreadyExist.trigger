trigger CheckIfActorAlreadyExist on Actor__c (before insert) {
    List<Actor__c> listOfAllActors = [SELECT Name FROM Actor__c];
    List<String> namesOfActors = new List<String>();
    for(Actor__c act : listOfAllActors){
        namesOfActors.add(act.Name);
    }
    for(Actor__c act : Trigger.new){
        if(namesOfActors.contains(act.Name)){
            act.Name.addError('This actor already exists in our database');
        }
    }
}