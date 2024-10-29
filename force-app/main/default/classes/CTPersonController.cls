/**
 * Created by walld on 10/24/2024.
 */

public with sharing class CTPersonController {
    public static String getToken(String mobile){
        Blob encrypted = Crypto.generateDigest('MD5', Blob.valueOf(mobile));
        return EncodingUtil.base64Encode(encrypted);
    }

    public static List<Person__c> getRecentHealthChanges(){
        return [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
    }

    public static List<Person__c> searchPeople(String searchTerm){
        searchTerm += '%';
        return [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c WHERE Name LIKE :searchTerm OR Mobile__c LIKE :searchTerm OR Token__c LIKE :searchTerm ORDER BY Status_Update_Date__c DESC NULLS LAST];
    }

    public static Person__c getPersonById(String personId){
        List<Person__c> person = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c FROM Person__c WHERE Id=:personId];
        return person.size() > 0 ? person[0] : null;
    }

    public static Map<String, Integer> getHealthStatusCount(){
        Map<String, Integer> retMap = new Map<String, Integer>();
        for(AggregateResult res : [SELECT Health_Status__c, COUNT(Id) numberOfPeople FROM Person__c GROUP BY Health_Status__c]){
            retMap.put((String) res.get('Health_Status__c'), (Integer) res.get('numberOfPeople'));
        }
        return retMap;
    }
}