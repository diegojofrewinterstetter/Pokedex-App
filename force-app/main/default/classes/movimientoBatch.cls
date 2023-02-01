global class movimientoBatch implements Database.Batchable<Integer>, Database.AllowsCallouts, Database.Stateful {
    global Iterable<Integer> start(Database.BatchableContext bc){
        List<Integer> indices = new List<Integer>();
        for (Integer i = 1; i <= 1; i++) {
            indices.add(i);
        }
        return indices;
    }
    global void execute(Database.BatchableContext bc, List<Integer> indices) {
        String name = '';
        List<Movimiento__c> movimientos = new List<Movimiento__c>();
        List<Object> efectData = new List<Object>();
       	Map<String, Object> targetData = new Map<String, Object>();
        Map<String, Object> typeData = new Map<String, Object>();
        Map<String, Object> result  = new Map <String,Object>();
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        request.setMethod('GET');
        
        for(Integer i : indices){
            request.setEndpoint('https://pokeapi.co/api/v2/move/' + i);
            response = http.send(request);
            if(response.getStatusCode() == 200 ){
                result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                name = (String)result.get('name');
                targetData = (Map<String, Object>)result.get('target');
                efectData = (List<Object>) result.get('effect_entries');
				typeData = (Map<String, Object>)result.get('type');
                Movimiento__c movimiento = new Movimiento__c(Name = name.capitalize(),
                                                             ExtId__c = (Integer)result.get('id'),
                                                             Punteria__c = (Integer)result.get('accuracy'),
                                                             Chance_de_Efecto__c = (Integer)result.get('effect_chance'),
                                                             Objetivo__c = (String) targetData.get('name'),
                                                             Prioridad__c = (Integer)result.get('priority'),
                											 Efecto__c = (efectData.size() == 0 ? '' : ((String)((Map<String, Object>) efectData[0]).get('short_effect'))),
                                                             Poder__c = (Integer)result.get('power'),
                                                             Pp__c = (Integer)result.get('pp'),
                                                             Tipo__c = (String)typeData.get('name'));
                											                									
                movimientos.add(movimiento);
                
            }
            
        }
        insert movimientos;
    }
    global void finish(Database.BatchableContext BC) {
        system.debug('finish');
    }
}