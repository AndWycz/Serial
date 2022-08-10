import querySeriesWithId from '@salesforce/apex/SerialeController.querySeriesWithId';

import { api, LightningElement, track } from 'lwc';

export default class DisplaySeriesInfoForUsers extends LightningElement {
    @api
    recordId;
    @track
    name;
    @track
    logo;
    @track
    desc;
    @track
    imageURL;
    @track
    trailerURL;
    @track
    rating;
    connectedCallback(){
        console.log(this.recordId);
        console.log('jestem w callbacku');
        querySeriesWithId({recordId:this.recordId}).then(result=>{
            this.name = result.Name;
            this.logo = result.Url_for_logo__c;
            this.desc = result.Opis_serialu__c;
            this.imageURL = result.Url_for_logo__c;
            this.trailerURL = result.Url_to_trailer__c;
            this.rating = result.Rating__c;
        })
       
    }
}