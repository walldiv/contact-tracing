/**
 * Created by walld on 10/28/2024.
 */

trigger LeadTrigger on Lead (before insert, before update) {
//    System.debug('Lead trigger called');
    for(Lead leadRecord: Trigger.new){
        // Gives all NEW records within trigger
        if(String.isBlank(leadRecord.LeadSource)){
            leadRecord.LeadSource = 'Blah';
        }

        // THROW ERRORS - used for validation
        if(String.isBlank(leadRecord.Industry)){
            leadRecord.addError('Industry cannot be blank!');
        }

        // TRIGGER VARIABLES
        //Trigger.isInsert - Return true if this trigger was fired due to an Insert Operation
        //Trigger.isUpdate - Return true if this trigger was fired due to an update operation
        //Trigger.isDelete - Return true if this trigger was fired due to an delete operation
        //Trigger.isUndelete - Return true if this trigger was fired due to an undelete operation
        //Trigger.isBefore - Return true if this trigger was fired BEFORE any record was saved
        //Trigger.isAfter - Return true if this trigger was fired AFTER all record were saved
    }
}