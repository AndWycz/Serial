import { api, LightningElement, track } from 'lwc';
import queryEpisodesFromSeason from '@salesforce/apex/SerialeController.queryEpisodesFromSeason';

export default class DisplayEpisodesForSeason extends LightningElement {
    @api
    seasonId;
    @track
    episodes
    connectedCallback(){
        queryEpisodesFromSeason({seasonId:this.seasonId}).then(result=>{
            this.episodes = result;}).catch(error=>{
                console.log(error);
        });
    }
}