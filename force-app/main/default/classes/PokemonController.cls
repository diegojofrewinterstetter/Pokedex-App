public class PokemonController {
    
    private static List<Movimiento__c> movesBD =[SELECT Id, name FROM Movimiento__c];
    private static List<Habilidad__c> abilitiesBD = [SELECT Id, name FROM Habilidad__c];
    
    public static Habilidad__c matchHabiliti(Map<String,Object> result){
        Habilidad__c abl = new Habilidad__c();
        List<Object> abilities =(List<Object>) result.get('abilities');
        Map<String,Object> ability0 =(Map<String,Object>) abilities.get(0);
        Map<String,Object> ability01 =(Map<String,Object>) ability0.get('ability');
        String name = (String) ability01.get('name');
        
        for(Habilidad__c a :abilitiesBD){
            if(a.name == name){
                abl.id = a.id;
                break; 
            }
        }
        
        return abl;
        
    }
    
    public static String setUrl(Integer id){
        if (integer.valueof(id) < 650) {
            return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/' + id + '.png';
        } else {
            return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/'+ id + '.png';
        }
    }
    
    public static String getType(Map<String, Object> result){
        List<Object> types =(List<Object>) result.get('types');
        Map<String,Object> type0 =(Map<String,Object>) types.get(0);
        Map<String,Object> type00 = (Map<String,Object>) type0.get('type');
        String typename0 = (String) type00.get('name');
        if(types.size() == 1){            
            return typename0.capitalize();
        }else if (types.size() > 1){
            Map<String,Object> type1 =(Map<String,Object>) types.get(1);
            Map<String,Object> type01 = (Map<String,Object>) type1.get('type');
            String typename1 = (String) type01.get('name');
            return typename0.capitalize()+ ';' + +typename1.capitalize();
        }else{
            return null;
        }
    }
    
    public static List<Movimiento__c> getMoves(Map<String, Object> result){
        List<Movimiento__c> movimientosEmpty = new List<Movimiento__c>();
        List<Movimiento__c> movimientosReturn = new List<Movimiento__c>();
        List<String> names = new List<String>();   
        List<Object> moves =(List<Object>) result.get('moves');
        
        if(moves.size() != 0){
            for(Integer i = 0;  i>= math.min(3, moves.size()); i++){
                Map<String,Object> move0 =(Map<String,Object>) moves.get(i);
                Map<String,Object> move01 = (Map<String,Object>) move0.get('move');
                String move1 =(String) move01.get('name');
                names.add(move1.capitalize());
            }
            
            for(Movimiento__c m : movesBD){
                for (String n : names){
                    if (m.name == n){
                        
                        movimientosReturn.add(m);
                    }                
                }
                if(movimientosReturn.size() == names.size()){
                    
                    return movimientosReturn;
                }             
            }
            
        }else{
            return movimientosEmpty;
        }
        
        return movimientosEmpty;
        
        
        
    }
    
    public static String idiomaEfecto(List<Object>  effectData) {
        
        for (Object e : effectData) {
            Map<String, Object> entry = (Map<String, Object>) e;
            Map<String, Object> language = (Map<String, Object>)entry.get('language');
            
            if ((String)language.get('name') == 'en') {
                return (String)entry.get('short_effect');	
            }
            
        }
        return null;
        
    }
    
    public static Map<String, Integer> getStats(Map<String, Object> result){
        Map<String, Integer> statsReturn = new Map<String, Integer>();
        List<Object> stats = (List<Object>) result.get('stats');
        for(Integer i = 0; i <= 5; i++){
            Map<String, Object> stat = (Map<String, Object>) stats[i];
            Map<String, Object> statData = (Map<String, Object>) stat.get('stat');
            String name = (String) statData.get('name'); 
            Integer baseStat = (Integer) stat.get('base_stat');
            
            statsReturn.put(name, baseStat);
        }        
        return statsReturn;
    }
}