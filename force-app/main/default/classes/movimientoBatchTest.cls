@isTest
public class movimientoBatchTest {
            public static testmethod void habilidadTestOk() {
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{"name": "Pound",'+
                                                               '"id": 1,'+
                                                               '"accuracy": 100,'+
                                                               '"effect_chance": null,'+
                                                               '"priority": 0,'+
                                                               '"target": { "name": "selected-pokemon", "url": "https://pokeapi.co/api/v2/move-target/10/" },'+
                                                               '"effect_entries": [ { "effect": "Inflicts regular damage.", "language": { "name": "en", "url": "https://pokeapi.co/api/v2/language/9/" }, "short_effect": "Inflicts regular damage with no additional effect." } ],'+
                                                               '"power": 40,'+
                                                               '"pp": 35,'+
                                                               '"type": { "name": "normal", "url": "https://pokeapi.co/api/v2/type/1/" }}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        test.startTest();
        Id batchJobId = Database.executeBatch(new movimientoBatch(), 1);
        test.stopTest(); 
        List<Movimiento__c> moveList = [SELECT Id, name, ExtId__c,
                                        Punteria__c, Chance_de_Efecto__c,
                                        Prioridad__c, Objetivo__c,
                                        Efecto__c, Poder__c,
                                        Pp__c, Tipo__c
                                        FROM Movimiento__c LIMIT 1];
        
        System.assertEquals(1, moveList.size(), 'los valores no coinciden');
        System.assertEquals('Pound', moveList[0].name, 'los valores no coinciden');
        System.assertEquals(1, moveList[0].ExtId__c, 'los valores no coinciden');
        System.assertEquals(100, moveList[0].Punteria__c, 'los valores no coinciden');
        System.assertEquals(null, moveList[0].Chance_de_Efecto__c, 'los valores no coinciden');
        System.assertEquals(0, moveList[0].Prioridad__c, 'los valores no coinciden');
		System.assertEquals('selected-pokemon', moveList[0].Objetivo__c, 'los valores no coinciden');
        System.assertEquals('Inflicts regular damage with no additional effect.', moveList[0].Efecto__c, 'los valores no coinciden');
        System.assertEquals(40, moveList[0].Poder__c, 'los valores no coinciden');
        System.assertEquals(35, moveList[0].Pp__c, 'los valores no coinciden');
        System.assertEquals('Normal', moveList[0].Tipo__c, 'los valores no coinciden');
                
    }
    
    public static testmethod void habilidadTestKo(){
        SingleRequestMock fakeResponse = new SingleRequestMock(404,
                                                 'Incomplete',
                                                 '',
                                                 null);
		Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        Id batchJobId = Database.executeBatch(new movimientoBatch(), 1);
        Test.stopTest();
        
        List<Movimiento__c> moveList = [SELECT Id, Name FROM Movimiento__c];
        
        System.assertEquals(0, moveList.size(), 'La lista tiene contenido');
    }

}