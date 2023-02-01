import { LightningElement, wire } from 'lwc';
import getFilterPokemon from '@salesforce/apex/pokemonService.getFilterPokemon';
export default class PokemonList extends LightningElement {

    textoBusqueda = "";
    tipo = "All";
    generacion = 0;

    @wire(getFilterPokemon, { textoBusqueda: "$textoBusqueda", tipo: "$tipo", generacion: "$generacion" })
    pokemon;

    get getMultiPiclistType() {
        return (this.tipo = 'All');
    }

w3

    get optionsGeneration() {
        return [
			{ label: 'All', value: '0' },
			{ label: '1', value: '1' },
			{ label: '2', value: '2' },
			{ label: '3', value: '3' },
			{ label: '4', value: '4' },
			{ label: '5', value: '5' },
			{ label: '6', value: '6' },
			{ label: '7', value: '7' },
			{ label: '8', value: '8' },
		];
    }

    get optionsType() {
        return [
            { label: 'All', value: 'All' },
            { label: 'Normal', value: 'Normal' },
            { label: 'Fighting', value: 'Fighting' },
            { label: 'Flying', value: 'Flying' },
            { label: 'Poison', value: 'Poison' },
            { label: 'Ground', value: 'Ground' },
            { label: 'Rock', value: 'Rock' },
            { label: 'Bug', value: 'Bug' },
            { label: 'Ghost', value: 'Ghost' },
            { label: 'Steel', value: 'Steel' },
            { label: 'Fire', value: 'Fire' },
            { label: 'Water', value: 'Water' },
            { label: 'Grass', value: 'Grass' },
            { label: 'Electric', value: 'Electric' },
            { label: 'Psychic', value: 'Psychic' },
            { label: 'Ice', value: 'Ice' },
            { label: 'Dragon', value: 'Dragon' },
            { label: 'Dark', value: 'Dark' },
            { label: 'Fairy', value: 'Fairy' }
        ];
    }

    handleTypeChange(event) {
        this.tipo = event.detail.value;
    }

    handleGenChange(event) {
        this.generacion = event.target.value;
    }

    handleNameChange(event) {
        const textoBusqueda = event.target.value;
        if (textoBusqueda === "" || textoBusqueda.length >= 1)
            this.textoBusqueda = textoBusqueda;
    }
}