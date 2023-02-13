import { LightningElement, track, api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import saveTask from "@salesforce/apex/CreateTaskController.saveTask";

export default class CreateTask extends LightningElement {
    @track type;
    @track priority;
    @track subject;
    @track description;
    @api recordId;

    get typePicklistValues(){
        return [
            {label: 'Call', value: 'Call'},
            {label: 'Meeting', value: 'Meeting'},
            {label: 'Other', value: 'Other'},
            {label: 'Email', value: 'Email'}

        ];
    }

    get priorityPicklistValues(){
        return [
            {label: 'High', value: 'High'},
            {label: 'Normal', value: 'Normal'},
            {label: 'Low', value: 'Low'}

        ];
    }

    handleTypeChange(event){
        this.type = event.target.value
    }

    handlePriorityChange(event){
        this.priority = event.target.value
    }

    handleSubjectChange(event){
        this.subject = event.target.value
    }

    handleDescriptionChange(event){
        this.description = event.target.value
    }

    addTask(){
        console.log('gg1 log task for ' + $recordId);
        saveTask({subject: this.subject, description: this.description, priority: this.priority, type: this.type, relatedTo: '0068d000002XyEGAA0'})
            .then (task => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Success",
                        message: "Task Created",
                        variant: "success"
                    })
                );
                this.subject = '';
                this.description = '';
                this.priority = '';
                this.type = '';
            })
            .catch((error) => {               
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error creating record",
                        message: error + " " + error?.message,
                        variant: "error"
                    })
                );
            });
    }

}