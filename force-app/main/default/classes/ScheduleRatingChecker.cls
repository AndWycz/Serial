global with sharing class ScheduleRatingChecker implements Schedulable {
    global void execute(SchedulableContext SC) {
        RatingChecker rc = new RatingChecker();
        Database.executeBatch(rc);
    }
}
