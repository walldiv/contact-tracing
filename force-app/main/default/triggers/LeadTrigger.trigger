/**
 * Created by walld on 10/28/2024.
 *
 * TRIGGERS are bulkified by default - make sure that your business logic is also bulkified
 * IE: instead of insert Object in a for loop - add that object to a List<SObject> and insert the list variable at end
 * of for loop.
 */

trigger LeadTrigger on Lead (before insert, before update) {
//    System.debug('Lead trigger called');
//        BEST METHOD OF APPROACH -
        switch on Trigger.operationType{
            when BEFORE_INSERT {
                LeadTriggerHandler.validateLead(Trigger.new);
            }

            when AFTER_INSERT {
                if(!LeadTriggerHandler.alreadyExecuted){
                    LeadTriggerHandler.updateAndAddNew(Trigger.new);
                }
            }
        }


        // TRIGGER VARIABLES
        //Trigger.new - list of new versions of records - available in before/after insert, before/after update, after undelete
        //Trigger.newMap - Map of Id & new versions of records - available in after insert, before/after update, after undelete
        //Trigger.old/oldMap - same as above
        // USE .get() on maps!
        //Trigger.isInsert - Return true if this trigger was fired due to an Insert Operation
        //Trigger.isUpdate - Return true if this trigger was fired due to an update operation
        //Trigger.isDelete - Return true if this trigger was fired due to an delete operation
        //Trigger.isUndelete - Return true if this trigger was fired due to an undelete operation
        //Trigger.isBefore - Return true if this trigger was fired BEFORE any record was saved
        //Trigger.isAfter - Return true if this trigger was fired AFTER all record were saved
        //Trigger isExecuting - return true if current context for the apex code is a trigger
        //Trigger.size - the total number records in a trigger invoc, both old & new
        //Trigger.operationType - returns enum of hte current operation - IE:  BEFORE_INSERT, AFTER_UPDATE, etc



}