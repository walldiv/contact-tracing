/**
 * Created by walld on 10/31/2024.
 */

trigger ContactTrigger on Contact (after update, after undelete, after insert, before delete ) {
    switch on Trigger.operationType {
        when BEFORE_DELETE {
            Map<Id, Boolean> accountMap = new Map<Id, Boolean>();
            List<Account> accounts = new List<Account>();
            for (Contact cont : Trigger.old) {
                if(String.isNotBlank(cont.AccountId)) {
                    accountMap.put(cont.AccountId, cont.Active__c);
                }
            }
            accounts = [SELECT ActiveContacts__c FROM Account WHERE Id IN :accountMap.keySet()];
            for(Account acct : accounts){
                if(accountMap.get(acct.Id)) {
                    acct.ActiveContacts__c = Math.max(0, acct.ActiveContacts__c - 1);
                }
            }
            update accounts;
        }
        when AFTER_UPDATE {
            Map<Id, Boolean> accountMap = new Map<Id, Boolean>();
            List<Account> accounts = new List<Account>();
            for (Contact cont : Trigger.new) {
                if(String.isNotBlank(cont.AccountId)) {
                    accountMap.put(cont.AccountId, cont.Active__c);
                }
            }
            accounts = [SELECT ActiveContacts__c FROM Account WHERE Id IN :accountMap.keySet()];
            for(Account acct : accounts){
                Boolean isActive = accountMap.get(acct.Id);
                System.debug('ACTION=> ' +Trigger.operationType+ ' ACCOUNTID=> ' +acct.Id+ ' ACTIVE => ' +isActive);
                acct.ActiveContacts__c += isActive ? 1 : -1;
            }
            update accounts;
        }
        when else {
            Map<Id, Boolean> accountMap = new Map<Id, Boolean>();
            List<Account> accounts = new List<Account>();
            for (Contact cont : Trigger.new) {
                if(String.isNotBlank(cont.AccountId)) {
                    accountMap.put(cont.AccountId, cont.Active__c);
                }
            }
            accounts = [SELECT ActiveContacts__c FROM Account WHERE Id IN :accountMap.keySet()];
            for(Account acct : accounts){
                Boolean isActive = accountMap.get(acct.Id);
                System.debug('ACTION=> ' +Trigger.operationType+ ' ACCOUNTID=> ' +acct.Id+ ' ACTIVE => ' +isActive);
                acct.ActiveContacts__c += isActive ? 1 : 0;
            }
            update accounts;
        }
    }
}