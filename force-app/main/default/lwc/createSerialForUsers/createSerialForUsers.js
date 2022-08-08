import { LightningElement, api } from 'lwc';

import insertSerial from '@salesforce/apex/CreateSerialForUsersController.insertSerial';
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';

export default class CreateSerialForUsers extends LightningElement {
    name;
    description;
    _logo;
    createdSeriesId;
    numberOfSameNamedSerials;
    _trailerURL;
    resoultOfUpload;
    @api
    get logo(){
        return this._logo;
    }
    set logo(value){
        
        this._logo = value;
    }
    @api
    get trailerURL(){
        return this._trailerURL;
    }
    set trailerURL(value){
        this._trailerURL = value;
    }
    onNameChange(event){
        this.name = event.detail.value;
    }
    onTrailerChange(event){
        this.trailerURL = event.detail.value.toString();
    }
    onLogoChange(event){
        
        this.logo = event.detail.value.toString();
       
    }
    onDescChange(event){
        this.description = event.detail.value;
    }
    
    handleClick(event){
        console.log('handleclick');
        const serial = {
            Name: this.name,
            Opis_serialu__c: this.description,
            Url_for_logo__c: this.logo,
            Url_to_trailer__c: this.trailerURL   
        }
        let currentLogo = this.logo;
        let currentTrailerUrl = this.trailerURL;
        console.log(isImage(currentLogo.toString()));
        console.log(currentLogo instanceof String);
        console.log(matchYoutubeUrl(this.trailerURL.toString()));
        if(this.name.length >1 && this.name.length < 30 && this.description.length > 30 && isImage(currentLogo) && matchYoutubeUrl(this.trailerURL.toString())){
            insertSerial({ser : serial}).then(result =>{
                this.createdSeriesId = result;
                if(result == null){
                    this.resoultOfUpload = 'This serial is already in our database'
                }else{
                    this.resoultOfUpload = 'Serial '+this.name+' has been added. Refresh series list to see result';
                }
            }).catch(error =>{
                this.resoultOfUpload = 'Serial '+this.name+' hasn\'t been added';
                console.log('insert wywaliło');
                console.log(error);
            });
        }else if(this.name.length <1){
            this.resoultOfUpload = 'Name is too short';
        }else if(this.name.length >30 ){
            this.resoultOfUpload = 'Name is too long';
        }else if(this.description.length < 30){
            this.resoultOfUpload = 'Description is too short';
        }else if(!isImage(currentLogo)){
            this.resoultOfUpload = 'Invalid URL for logo';
        }else if(!matchYoutubeUrl(this.trailerURL.toString())){
            this.resoultOfUpload = 'Invalid URL for trailer. Remeber to use embed url';
        
        }else{
            this.resoultOfUpload = 'Serial hasn\'t been added. Something went wrong';
        }
        this.name = null;
        this.description = null;
        this.logo = null;
        this.trailerURL = null;
        
    }
    
}
function isImage(url) {
    return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(url);
}
function matchYoutubeUrl(url) {
    var p = /^(?:https?:\/\/)?(?:m\.|www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watrch\?v=|watrch\?.+&v=))((\w|-){11})(?:\S+)?$/;
    if(url.match(p)){
        return url.match(p)[1];
    }
    return false;
}