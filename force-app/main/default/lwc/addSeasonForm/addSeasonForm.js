import { api, LightningElement, track } from 'lwc';
import insertSeason from '@salesforce/apex/SerialeController.insertSeason';
import querySeasonsWithSerial from '@salesforce/apex/SerialeController.querySeasonsWithSerial';

export default class AddSeasonForm extends LightningElement {
    @api
    seriesId;
    @track
    seasons;
    name;
    @track
    resoultOfUpload;
    connectedCallback(){
        querySeasonsWithSerial({SerialId:this.seriesId}).then(result=>{
            this.seasons=result;
        }).catch(error=>{
            console.log(error);
        });
    }
    onNameChange(event){
        this.name = event.detail.value;
    }
    handleClick(){
        const season = {
            Name: this.name,
            Serial__c: this.seriesId
        }
        insertSeason({sea : season}).then(result =>{
            if(result == null){
                this.resoultOfUpload = 'program failed to add episode';
            }else{
                this.resoultOfUpload = 'episode has been added';
            }   
        })
    }
}