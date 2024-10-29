/**
 * Created by walld on 10/24/2024.
 */

public with sharing class CTPeopleTracingController {
    public static List<People_Tracing__c> getTraces(String recordId){
        return [SELECT Id, Contact_Type__c, Contact_Date__c, Person_1__c, Person_2__c
            FROM People_Tracing__c
            WHERE Id = :recordId
            ORDER BY Contact_Date__c DESC NULLS LAST];
    }

    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> peopleTraces){
        Set<Id> personIds = new Set<Id>();
        for(People_Tracing__c trace: peopleTraces){
            personIds.add(trace.Person_1__c);
            personIds.add(trace.Person_2__c);
        }
        //duplicates list
        return [SELECT Id, Contact_Type__c, Contact_Date__c, Person_1__c, Person_2__c
            FROM People_Tracing__c
            WHERE Person_1__c IN :personIds OR Person_2__c IN :personIds];
    }
}