@isTest
public class pokemonServiceTest {
    @isTest 
    static void getFilterPokemonTestOk() {
        
        Pokemon__c pokemon = new Pokemon__c(Name='Pikachu', Tipos__c='Electric', ExtId__c=25);       
        insert pokemon;
        
        List<Pokemon__c> pokemons = PokemonService.getFilterPokemon('Pik', 'Electric', 1);
        
        System.assertEquals(1, pokemons.size());
        System.assertEquals('Pikachu', pokemons[0].Name);
    }
    
    @isTest 
    static void getFilterPokemonTestKo() {
        List<Pokemon__c> pokemons = PokemonService.getFilterPokemon('', '', -1);
        
        System.assertEquals(0, pokemons.size());
    }
}