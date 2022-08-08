import { api, LightningElement, track } from 'lwc';
import queryActorsFromSerial from '@salesforce/apex/SerialeController.queryActorsFromSerial';

export default class DisplayListOfActors extends LightningElement {
    @api
    seriesId;
    @track
    actors;
    connectedCallback(){
        queryActorsFromSerial({serialId:this.seriesId}).then(result=>{
            this.actors = result;
        }).catch(error=>{
            console.log(error);
        });
       
    }
}