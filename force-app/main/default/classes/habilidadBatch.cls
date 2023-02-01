global class habilidadBatch implements Database.Batchable<Integer>, Database.AllowsCallouts, Database.Stateful {
    global Iterable<Integer> start(Database.BatchableContext bc){
        List<Integer> indices = new List<Integer>();
        for (Integer i = 1; i <= 1; i++) {
            indices.add(i);
        }
        return indices;
    }
    global void execute(Database.BatchableContext bc, List<Integer> indices) {
        List<Habilidad__c> habilidades = new List<Habilidad__c>();
        Map<String, Object> result  = new Map <String,Object>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        request.setMethod('GET');
        List<Object> listResponse = new List<Object>();
        List<Object> efectData = new List<Object>();
        String name = '';
        for(Integer i : indices){
            request.setEndpoint('https://pokeapi.co/api/v2/ability/' + i);
            response = http.send(request);
            if(response.getStatusCode() == 200 ){
                result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                efectData = (List<Object>) result.get('effect_entries');
                name = (String)result.get('name');
                listResponse = (List<Object>)result.get('results');         
                Habilidad__c habilidad = new Habilidad__c(Name = name.capitalize(),
                                                          ExtId__c = (Integer) result.get('id'),
                                                          Efecto__c = PokemonController.idiomaEfecto(efectData));

                habilidades.add(habilidad);
                
            }            
        }
        insert habilidades;
    }
    global void finish(Database.BatchableContext BC) {
        system.debug('finish');
    }
}