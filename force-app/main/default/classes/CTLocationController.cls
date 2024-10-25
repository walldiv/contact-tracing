/**
 * Created by walld on 10/24/2024.
 */

public with sharing class CTLocationController {
    public static List<Location__c> getRecentStatusChanges(){
        return [SELECT FIELDS(STANDARD) FROM Location__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
    }

    public static List<Location__c> searchLocations(String searchTerm){
        return [SELECT FIELDS(STANDARD) FROM Location__c WHERE Name LIKE :searchTerm OR Pincode__c LIKE :searchTerm OR Address__c LIKE :searchTerm ORDER BY Status_Update_Date__c DESC NULLS LAST];
    }

    public static Location__c getLocationById(String locationId){
        List<Location__c> loc = [SELECT FIELDS(STANDARD) FROM Location__c WHERE Id=:locationId];
        return loc.size() > 0 ? loc[0] : null;
    }
}