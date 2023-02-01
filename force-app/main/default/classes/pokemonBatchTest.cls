@isTest
public class pokemonBatchTest{
    @testSetup
    static void makeData() {
        Habilidad__c habilidad = new Habilidad__c(Name = 'Overgrow');
        insert habilidad;
        Movimiento__c movimiento = new Movimiento__c(Name = 'Razor-wind');
        insert movimiento;
        Movimiento__c movimiento1 = new Movimiento__c(Name = 'Swords-dance');
        insert movimiento1;
        Movimiento__c movimiento2 = new Movimiento__c(Name = 'Cut');
        insert movimiento2;
        Movimiento__c movimiento3 = new Movimiento__c(Name = 'Bind');
        insert movimiento3;
    }
    
    public static testmethod void pokemonTestOk() {
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{"name": "Bulbasaur", "weight": 69, "height": 7, "id": 1,'+
                                                               '"stats": [ '+
                                                               '{ "base_stat": 45, "effort": 0, "stat": { "name": "hp", "url": "https://pokeapi.co/api/v2/stat/1/" } },'+
                                                               '{ "base_stat": 49, "effort": 0, "stat": { "name": "attack", "url": "https://pokeapi.co/api/v2/stat/2/" } },'+
                                                               '{ "base_stat": 49, "effort": 0, "stat": { "name": "defense", "url": "https://pokeapi.co/api/v2/stat/3/" } },'+
                                                               '{ "base_stat": 65, "effort": 1, "stat": { "name": "special-attack", "url": "https://pokeapi.co/api/v2/stat/4/" } },'+
                                                               '{ "base_stat": 65, "effort": 0, "stat": { "name": "special-defense", "url": "https://pokeapi.co/api/v2/stat/5/" } },'+
                                                               '{ "base_stat": 45, "effort": 0, "stat": { "name": "speed", "url": "https://pokeapi.co/api/v2/stat/6/" } } ],'+
                                                               '"abilities": ['+
                                                               '{ "ability": { "name": "Overgrow", "url": "https://pokeapi.co/api/v2/ability/65/" }, "is_hidden": false, "slot": 1 },'+
                                                               '{ "ability": { "name": "Chlorophyll", "url": "https://pokeapi.co/api/v2/ability/34/" }, "is_hidden": true, "slot": 3 } ],'+
                                                               '"sprites":{"back_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png","back_female":null,"back_shiny":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png","back_shiny_female":null,"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png","front_female":null,"front_shiny":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png","front_shiny_female":null,"other":{"dream_world":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg","front_female":null},"home":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png","front_female":null,"front_shiny":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/1.png","front_shiny_female":null},"official-artwork":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"}}},'+
                                                               '"types": [ { "slot": 1, "type": { "name": "grass", "url": "https://pokeapi.co/api/v2/type/12/" } },'+
                                                               '{ "slot": 2, "type": { "name": "poison", "url": "https://pokeapi.co/api/v2/type/4/" } } ],'+
                                                               '"moves":['+
                                                               '{ "move": { "name": "Razor-wind", "url": "https://pokeapi.co/api/v2/move/13/" }},'+
                                                               '{ "move": { "name": "Swords-dance", "url": "https://pokeapi.co/api/v2/move/14/" }},'+
                                                               '{ "move": { "name": "Cut", "url": "https://pokeapi.co/api/v2/move/15/" }},'+
                                                               '{ "move": { "name": "Bind", "url": "https://pokeapi.co/api/v2/move/20/" } } ]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        test.startTest();
        Id batchJobId = Database.executeBatch(new pokemonBatch(), 1);
        test.stopTest(); 
        
        List<Pokemon__c> pokeList = [SELECT Id, Name,
                                     Altura__c, Peso__c,
                                     ExtId__c, Vida__c, 
                                     Ataque__c, Defensa__c,
                                     Velocidad__c, Habilidad__r.name,
                                     Image__c, Tipos__c,
                                     Slot1__r.name, Slot2__r.name,
                                     Slot3__r.name, Slot4__r.name
                                     FROM Pokemon__c LIMIT 1];
        
        System.assertEquals(1, pokeList.size(), 'Los valores no coinciden');
        System.assertEquals('Bulbasaur', pokeList[0].name, 'los valores no coinciden');
        System.assertEquals(0.70, pokeList[0].Altura__c, 'los valores no coinciden');
        System.assertEquals(6.90, pokeList[0].Peso__c, 'los valores no coinciden');
        System.assertEquals(1, pokeList[0].ExtId__c, 'los valores no coinciden');
        System.assertEquals(45, pokeList[0].Vida__c, 'los valores no coinciden');
        System.assertEquals(49, pokeList[0].Ataque__c, 'los valores no coinciden');
        System.assertEquals(49, pokeList[0].Defensa__c, 'los valores no coinciden');
        System.assertEquals(45, pokeList[0].Velocidad__c, 'los valores no coinciden');
        System.assertEquals('Overgrow', pokeList[0].Habilidad__r.name, 'los valores no coinciden');
        System.assertEquals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/' + pokeList[0].ExtId__c + '.gif', pokeList[0].Image__c, 'los valores no coinciden');
        System.assertEquals('Poison;Grass', pokeList[0].Tipos__c, 'los valores no coinciden');
        System.assertEquals('Razor-wind', pokeList[0].Slot1__r.name, 'los valores no coinciden');
        System.assertEquals('Swords-dance', pokeList[0].Slot2__r.name, 'los valores no coinciden');
        System.assertEquals('Cut', pokeList[0].Slot3__r.name, 'los valores no coinciden');
        System.assertEquals('Bind', pokeList[0].Slot4__r.name, 'los valores no coinciden');
        
    }
    
    public static testmethod void pokemonTestKo() {
        
        
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'Complete',
                                                               '{"name": "Bulbasaur", "weight": 69, "height": 7, "id": 700,'+
                                                               '"stats": [ '+
                                                               '{ "base_stat": 45, "effort": 0, "stat": { "name": "hp", "url": "https://pokeapi.co/api/v2/stat/1/" } },'+
                                                               '{ "base_stat": 49, "effort": 0, "stat": { "name": "attack", "url": "https://pokeapi.co/api/v2/stat/2/" } },'+
                                                               '{ "base_stat": 49, "effort": 0, "stat": { "name": "defense", "url": "https://pokeapi.co/api/v2/stat/3/" } },'+
                                                               '{ "base_stat": 65, "effort": 1, "stat": { "name": "special-attack", "url": "https://pokeapi.co/api/v2/stat/4/" } },'+
                                                               '{ "base_stat": 65, "effort": 0, "stat": { "name": "special-defense", "url": "https://pokeapi.co/api/v2/stat/5/" } },'+
                                                               '{ "base_stat": 45, "effort": 0, "stat": { "name": "speed", "url": "https://pokeapi.co/api/v2/stat/6/" } } ],'+
                                                               '"abilities": ['+
                                                               '{ "ability": { "name": "Overgrow", "url": "https://pokeapi.co/api/v2/ability/65/" }, "is_hidden": false, "slot": 1 },'+
                                                               '{ "ability": { "name": "Chlorophyll", "url": "https://pokeapi.co/api/v2/ability/34/" }, "is_hidden": true, "slot": 3 } ],'+
                                                               '"Sprites": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",'+
                                                               '"types": [ { "slot": 1, "type": { "name": "grass", "url": "https://pokeapi.co/api/v2/type/12/" } }'+
                                                               ' ],'+
                                                               '"moves":[]}',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        Id batchJobId = Database.executeBatch(new pokemonBatch(), 1);
        Test.stopTest();
        
        List<Pokemon__c> pokeList = [SELECT Id, Name,
                                     Image__c, Tipos__c,
                                     Slot1__r.name,
                                     Slot2__r.name, Slot3__r.name,
                                     Slot4__r.name
                                     FROM Pokemon__c];
        
        System.assertEquals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/700.png', pokeList[0].Image__c, 'Los valores no coinciden');
        System.assertEquals('Grass', pokeList[0].Tipos__c, 'Los valores no coinciden');
        System.assertEquals(null, pokeList[0].Slot1__r.name, 'los valores no coinciden');
        System.assertEquals(null, pokeList[0].Slot2__r.name, 'los valores no coinciden');
        System.assertEquals(null, pokeList[0].Slot3__r.name, 'los valores no coinciden');
        System.assertEquals(null, pokeList[0].Slot4__r.name, 'los valores no coinciden');
        
        
    }   
    
    public static testmethod void callOutKo() {
        SingleRequestMock fakeResponse = new SingleRequestMock(404,
                                                               'Incomplete',
                                                               '',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        Id batchJobId = Database.executeBatch(new pokemonBatch(), 1);
        Test.stopTest();
        
        List<Pokemon__c> pokeList = [SELECT Id, Name FROM Pokemon__c];
        
        System.assertEquals(0, pokeList.size(), 'Los valores no coinciden');
        
    }
}