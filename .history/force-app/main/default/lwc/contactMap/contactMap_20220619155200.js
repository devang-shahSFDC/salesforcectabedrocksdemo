import { api, LightningElement } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import LEAFLET from '@salesforce/resourceUrl/leaflet';

export default class InquiryMap extends LightningElement {
    @api recordId;
    @api height;

    renderedCallback() {
        this.template.querySelector('div').style.height = `${this.height}px`;
    }
		
    connectedCallback() {
        Promise.all([
            loadStyle(this, LEAFLET + '/leaflet.css'),
            loadScript(this, LEAFLET + '/leaflet.js'),
        ]).then(() => {
            // Leaflet should be ready, create a new draw method
            // this.draw();
        });
    }

    draw() {
        let container = this.template.querySelector('div');
        let position = [38.341891109801594, -0.48035610027642234];
        let map = L.map(container, { scrollWheelZoom: false }).setView(position, 13);
    
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="<https://www.openstreetmap.org/copyright>">OpenStreetMap</a> contributors',
        }).addTo(map);
    
        let marker = L.marker(position).addTo(map);
        let featureGroup = L.featureGroup([marker]).addTo(map);
        map.fitBounds(featureGroup.getBounds());
    }
}