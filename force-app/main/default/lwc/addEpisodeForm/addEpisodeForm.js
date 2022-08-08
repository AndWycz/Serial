import { api, LightningElement } from 'lwc';
import insertEpisode from '@salesforce/apex/SerialeController.insertEpisode';

export default class AddEpisodeForm extends LightningElement {
    @api
    seasonId;
    name;
    description;
    resoultOfUpload;

    handleClick(){
        const episode = {
            Name: this.name,
            Episode_details__c: this.description,
            Season__c: this.seasonId
        }
        insertEpisode({epi : episode}).then(result =>{
            if(result == null){
                this.resoultOfUpload = 'program failed to add episode';
            }else{
                this.resoultOfUpload = 'episode has been added';
            }
        })
    }
    onNameChange(event){
        this.name = event.detail.value;
    }
    onDescChange(event){
        this.description = event.detail.value;
    }
}