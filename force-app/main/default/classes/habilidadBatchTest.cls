@isTest
public class habilidadBatchTest {
    
        public static testmethod void habilidadTestOk() {
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{"name": "Stench",'+
                                                               '"id": 1,'+
                                                               '"effect_entries": [ { "effect": "Attacken die Schaden verursachen haben mit jedem Treffer eine 10% Chance das Ziel zurückschrecken zu lassen, wenn die Attacke dies nicht bereits als Nebeneffekt hat.Der Effekt stapelt nicht mit dem von getragenen Items.nAußerhalb vom Kampf: Wenn ein Pokémon mit dieser Fähigkeit an erster Stelle im Team steht, tauchen wilde Pokémon nur halb so oft auf.", "language": { "name": "de", "url": "https://pokeapi.co/api/v2/language/6/" }, "short_effect": "Mit jedem Treffer besteht eine 10% Chance das Ziel zurückschrecken zu lassen." }, { "effect": "This Pokémon s damaging moves have a 10% chance to make the target flinch with each hit if they do not already cause flinching as a secondary effect.This ability does not stack with a held item.Overworld: The wild encounter rate is halved while this Pokémon is first in the party.", "language": { "name": "en", "url": "https://pokeapi.co/api/v2/language/9/" }, "short_effect": "Has a 10% chance of making target Pokémon flinch with each hit." } ]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        test.startTest();
        Id batchJobId = Database.executeBatch(new habilidadBatch(), 1);
        test.stopTest(); 
            
        List<Habilidad__c> abilityList = [SELECT Id, name,
                                          ExtId__c, Efecto__c
                                          FROM Habilidad__c LIMIT 1];
        
        System.assertEquals(1, abilityList.size(), 'los valores no coinciden');
        System.assertEquals('Stench', abilityList[0].name, 'los valores no coinciden');
        System.assertEquals(1, abilityList[0].ExtId__c, 'los valores no coinciden');
        System.assertEquals('Has a 10% chance of making target Pokémon flinch with each hit.', abilityList[0].Efecto__c, 'los valores no coinciden');   
    }   
    
    public static testmethod void habilidadTestKo(){
        SingleRequestMock fakeResponse = new SingleRequestMock(404,
                                                 'Incomplete',
                                                 '',
                                                 null);
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        Id batchJobId = Database.executeBatch(new habilidadBatch(), 1);
        Test.stopTest();
        
        List<Habilidad__c> abilityList = [SELECT Id, Name FROM Habilidad__c];
        System.debug(abilityList);
        System.assertEquals(0, abilityList.size(), 'La lista tiene contenido');
    }

}