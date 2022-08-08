import queryEpisodesWithSerial from '@salesforce/apex/SerialeController.queryEpisodesWithSerial';
import querySeasonsWithSerial from '@salesforce/apex/SerialeController.querySeasonsWithSerial';
import { LightningElement, track, api } from 'lwc';

export default class DisplayEpisodesForWholeSeries extends LightningElement {
    @api
    recordId;
    // @track
    // episodes;
    @track
    seasons;
    connectedCallback(){
        // queryEpisodesWithSerial({serialId:this.recordId}).then(result=>{
         
        //     this.episodes = result;

        // }).catch(error => {
        //     console.log(error);
        // });
        querySeasonsWithSerial({SerialId:this.recordId}).then(result=>{
            this.seasons=result;
            console.log('lista sezonów z wyświetlania epizodów '+ this.seasons);
        }).catch(error=>{
            console.log(error);
        });
    }
}