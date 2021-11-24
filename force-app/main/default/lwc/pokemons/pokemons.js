import { LightningElement } from 'lwc';
import getData from '@salesforce/apex/DataServiceController.getData';


export default class Pokemons extends LightningElement {

    pokemonList = [];
    error = null;

    connectedCallback() {
        getData()
            .then(result => {
                this.pokemonList = result;
                //console.log(result.results);
            })
            .catch(error => {
                this.error = error;
            });
    }


}