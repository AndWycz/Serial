import { api, LightningElement, track, wire } from 'lwc';
import querySeasonsWithSerial from '@salesforce/apex/SerialeController.querySeasonsWithSerial';

export default class AddEpisodeToSeriesForUsers extends LightningElement {
    @api
    seriesId;
    @track
    seasons;
    @track
    selectedSeason;
    
    connectedCallback(){
        querySeasonsWithSerial({SerialId:this.seriesId}).then(result=>{
            this.seasons=result;
            console.log('lista sezonów z dodawania epizodów '+ this.seasons);
        }).catch(error=>{
            console.log(error);
        });
    }
    handleButtonGroup(event){
        const idFromButton = event.target.dataset.id;
        
        console.log('id wybranego sezonu to '+ idFromButton);
        this.selectedSeason = idFromButton;
    }

}
// function addToSeasons(element) {
//     let thisSeason = {label: element.Name, value: element.Id};
//     this.seasons.push(thisSeason);
// }