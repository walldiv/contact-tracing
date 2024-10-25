/**
 * Created by walld on 10/24/2024.
 */

public with sharing class CTLocationTracingController {
    public static List<Location_Tracing__c> getVisitors(String locationId){
        return [SELECT FIELDS(STANDARD) FROM Location_Tracing__c
            WHERE Id = :locationId
            ORDER BY Visit_Date__c DESC NULLS LAST];
    }

    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds){
        return [SELECT FIELDS(STANDARD) FROM Location_Tracing__c
            WHERE Person__c IN :personIds
            AND Visit_Date__c = LAST_N_DAYS:10];
    }

    public static List<Location_Tracing__c> getLocationsByLocationIds(Set<Id> locationIds){
        return [SELECT FIELDS(STANDARD) FROM Location_Tracing__c
            WHERE Location__c IN :locationIds
            AND Person__r.Health_Status__c = 'Green'
            AND Visit_Date__c = LAST_N_DAYS:10];
    }

    public static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c> locationTraces){
        Set<Id> traceIds = new Set<Id>();
        Set<Id> personIds = new Set<Id>();
        for(Location_Tracing__c loc : locationTraces){
            traceIds.add(loc.Location__c);
            personIds.add(loc.Person__c)
        }
        return [SELECT FIELDS(STANDARD) FROM Location_Tracing__c WHERE Location__c IN :traceIds AND Person__c IN :personIds];
    }
}