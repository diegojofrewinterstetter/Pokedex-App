global class pokemonBatch implements Database.Batchable<Integer>, Database.AllowsCallouts, Database.Stateful {
    global Iterable<Integer> start(Database.BatchableContext bc){
        List<Integer> indices = new List<Integer>();
        for (Integer i = 1; i <=898; i++) {
            indices.add(i);
        }
        return indices;
    }
    global void execute(Database.BatchableContext bc, List<Integer> indices) {
        
        Map<String, Object> result  = new Map <String,Object>();
        
        String name = '';
        List<Pokemon__c> pokemons = new List<Pokemon__c>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        request.setMethod('GET');                       
        for(Integer i : indices){
            request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + i);
            response = http.send(request);
            if(response.getStatusCode() == 200 ){
                Pokemon__c pokemon = new Pokemon__c();
                result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                name = (String)result.get('name');
                Habilidad__c abl = PokemonController.matchHabiliti(result);
                Map<String, Integer> stats = PokemonController.getStats(result);
                List<Movimiento__c> mov = PokemonController.getMoves(result);
                pokemon.Name = name.capitalize();
                pokemon.Altura__c = (Double)result.get('height')/10;
                pokemon.Peso__c = (Double)result.get('weight')/10;
                pokemon.ExtId__c = (Integer)result.get('id');
                pokemon.Vida__c = stats.get('hp');
                pokemon.Ataque__c = stats.get('attack');
                pokemon.Defensa__c = stats.get('defense');
                pokemon.Velocidad__c = stats.get('speed');
                pokemon.Habilidad__c = abl.Id;
                pokemon.Image__c = PokemonController.setUrl((Integer)result.get('id'));
                pokemon.Tipos__c = PokemonController.getType(result);
                pokemon.Slot1__c = (mov.size() < 1 ? null : mov[0].id);
                pokemon.Slot2__c = (mov.size() < 1 ? null : mov[1].id);
                pokemon.Slot3__c = (mov.size() < 1 ? null : mov[2].id);
                pokemon.Slot4__c = (mov.size() < 1 ? null : mov[3].id);
                    
                pokemons.add(pokemon);              
            }         
        }	
        insert pokemons;
    }
    global void finish(Database.BatchableContext BC) {
        system.debug('finish');
    }
}