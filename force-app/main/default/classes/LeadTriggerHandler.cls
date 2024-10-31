/**
 * Created by walld on 10/31/2024.
 *
 * The usecase of this class is to shift logic from doing work in the trigger, to executing this class instead.

 * the BENEFIT of using this approach is shown below - where the boolean 'alreadyExecuted' is set to true when
 * this class is executed - which the class itself is an instance and thus you can have inserts into the same class
 * that hte trigger is based off of - allowing for NON INFINITE LOOPS to be handled via this approach.
 */

public class LeadTriggerHandler {
    public static Boolean alreadyExecuted = false;

    public static void validateLead(List<Lead> leads){
        for(Lead leadRecord: leads) {
            // Gives all NEW records within trigger
            if (String.isBlank(leadRecord.LeadSource)) {
                leadRecord.LeadSource = 'Blah';
            }

            // THROW ERRORS - used for validation
            if (String.isBlank(leadRecord.Industry)) {
                leadRecord.addError('Industry cannot be blank!');
            }
        }
    }

    public static void updateAndAddNew(List<Lead> leads){
        alreadyExecuted = true;
        for(Lead leadRecord : leads){
            Lead anotherLead = new Lead(LastName = 'BlahBlah', Status = 'Open - Not Contacted', Company = 'SFDCFacts', Industry = 'Fiserv');
            insert anotherLead;
        }
    }
}