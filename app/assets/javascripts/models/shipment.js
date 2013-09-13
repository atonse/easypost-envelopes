Easypost.Shipment = Ember.Object.extend({
  id: null,
  
  fromAddress: null,
  toAddress: null,

  parcel: null,

  rates: null,

  postageLabel: null,
  stamp: null,
  barcode: null,

  selectedRate: null,

  buy: function(rate) {
    var self = this;

    return new Ember.RSVP.Promise(function (resolve, reject) {
      if (self.get('postageLabel')) {
        resolve(self.get('postageLabel'));
        return;
      }

      self.set('selectedRate', rate);

      $.ajax({
        url: '/buy',
        method: 'POST',
        data: {
          shipment_id: self.get('id'),
          rate_id: rate.id
        }
      }).then(function(result) {
        self.set('postageLabel', result);
        self.set('stamp', '/shipment/' + self.get('id') + '/stamp');
        self.set('barcode', '/shipment/' + self.get('id') + '/barcode');
        self.set('rates', undefined);
        resolve(self);
      });
    });
  },

  save: function() {
    var self = this;

    return new Ember.RSVP.Promise(function (resolve, reject) {
      if (self.get('id')) {
        resolve(self);
        return;
      }

      $.ajax({
        url: '/shipment',
        method: 'POST',
        data: {
          from_address_id: self.get('fromAddress').get('id'),
          to_address_id: self.get('toAddress').get('id'),
          parcel_id: self.get('parcel').get('id')
        }
      }).then(function(result) {
        //self.setProperties(result);
        self.set('id', result.id);

        self.set('rates', result.rates);
        resolve(self);
      });
    });
  },

  getRates: function() {
    var self = this;

    return new Ember.RSVP.Promise(function (resolve, reject) {
      $.ajax({
        url: '/rates',
        method: 'GET',
        data: {
          from_address_id: self.get('fromAddress').get('id'),
          to_address_id: self.get('toAddress').get('id'),
          parcel_id: self.get('parcel').get('id')
        }
      }).then(function(result) {
        self.set('rates', result.rates);
      });
    });
  }
});
