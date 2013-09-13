Easypost.EnvelopeController = Ember.ObjectController.extend({
  fromAddress: null,
  toAddress: null,
  parcel: null,
  shipment: null,

  someAddressesUnverified: true,

  actions: {
    estimatePostage: function() {
      var shipment = Easypost.Shipment.create({
        fromAddress: this.get('fromAddress'),
        toAddress: this.get('toAddress'),
        parcel: this.get('parcel')
      });

      this.set('shipment', shipment);
      shipment.save();
    },

    buy: function(rate) {
      this.get('shipment').buy(rate);
    }
  }
});
