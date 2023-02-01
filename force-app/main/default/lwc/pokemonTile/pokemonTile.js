import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

const colores = [
    'Poison',
    'Fire',
    'Electric',
    'Normal',
    'Water',
    'Ice',
    'Rock',
    'Flying',
    'Grass',
    'Psychic',
    'Ghost',
    'Bug',
    'Ground',
    'Dragon',
    'Steel',
    'Fighting',
    'Dark'
];

export default class PokemonTile extends NavigationMixin(LightningElement) {
    @api pokemon

    renderedCallback() {
        
        if (this.pokemon) {
            
            const tipos = this.pokemon.Tipos__c.split(';');
            const index = colores.indexOf(tipos[0]);
            this.template.querySelector('.card').classList.add(colores[index]);
            

        }
    }

    navigateToRecordViewPage() {

        this[NavigationMixin.Navigate](
            {
                type: 'standard__recordPage',
                attributes: {
                    objectApiName: 'Pokemon__c',
                    recordId: this.pokemon.Id,
                    actionName: 'view'
                }
            }
        );
    }

    get isPoison() {
        return this.pokemon.Tipos__c.includes("Poison")
    }

    get isGrass() {
        return this.pokemon.Tipos__c.includes("Grass")
    }

    get isNormal() {
        return this.pokemon.Tipos__c.includes("Normal")
    }

    get isFighting() {
        return this.pokemon.Tipos__c.includes("Fighting")
    }

    get isFlying() {
        return this.pokemon.Tipos__c.includes("Flying")
    }

    get isGround() {
        return this.pokemon.Tipos__c.includes("Ground")
    }

    get isRock() {
        return this.pokemon.Tipos__c.includes("Rock")
    }

    get isBug() {
        return this.pokemon.Tipos__c.includes("Bug")
    }

    get isGhost() {
        return this.pokemon.Tipos__c.includes("Ghost")
    }

    get isSteel() {
        return this.pokemon.Tipos__c.includes("Steel")
    }

    get isFire() {
        return this.pokemon.Tipos__c.includes("Fire")
    }

    get isWater() {
        return this.pokemon.Tipos__c.includes("Water")
    }

    get isElectric() {
        return this.pokemon.Tipos__c.includes("Electric")
    }

    get isPsychic() {
        return this.pokemon.Tipos__c.includes("Psychic")
    }

    get isIce() {
        return this.pokemon.Tipos__c.includes("Ice")
    }

    get isDragon() {
        return this.pokemon.Tipos__c.includes("Dragon")
    }

    get isDark() {
        return this.pokemon.Tipos__c.includes("Dark")
    }

    get isFairy() {
        return this.pokemon.Tipos__c.includes("Fairy")
    }

    
}