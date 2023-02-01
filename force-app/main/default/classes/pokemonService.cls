public with sharing class pokemonService {
    @AuraEnabled(cacheable=true)
    public static List<Pokemon__c> getFilterPokemon(String textoBusqueda, String tipo, Integer generacion) {

        String valorContenido = '%' + textoBusqueda + '%';
        String query =  'SELECT '+
 	           		    'Id, '+
            		    ' Name, '+
            		    ' ExtId__c, '+
            		    ' image__c, '+
                        ' Tipos__c, '+
                        ' Vida__c, '+
                        ' Velocidad__c, '+
                        ' Defensa__c, '+
                        ' Ataque__c, '+
                        ' Generacion__c '+
            		    ' FROM Pokemon__c ';

        if(valorContenido != ''){
            query = query + 'WHERE Name LIKE :valorContenido ';
        }

        if(tipo != 'All'){
            query = query +'AND Tipos__c INCLUDES(:tipo) ';
        }

        if(generacion != 0){
            query = query + 'AND Generacion__c =: generacion ';
        }

		query = query + 'ORDER BY ExtId__c';
        
        return Database.query(query);

    }
}