Easypost.EnvelopeRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    this._super(controller, model);

    blankFromAddress = Easypost.Address.create({ namePlaceholder: 'Sender Name' });
    blankToAddress = Easypost.Address.create({ namePlaceholder: 'Recipient Name' });

    testToAddress = Easypost.Address.create({
      namePlaceholder: 'Sender Name',
      name: 'Ashish Tonse',
      street1: '5225 Pooks Hill Rd #1722S',
      city: 'Bethesda',
      state: 'MD',
      zip: '20814' 
    });

    testFromAddress = Easypost.Address.create({
      namePlaceholder: 'Recipient Name',
      name: 'EasyPost',
      street1: '2135 Sacramento St Apt 209',
      city: 'San Francisco',
      state: 'CA',
      zip: '94109' 
    });

    var parcel = Easypost.Parcel.create({ predefined_package: 'Letter', weight: 1 });

    parcel.save().then(function(parcel) {
      controller.set('parcel', parcel);
    });

    //controller.set('fromAddress', blankFromAddress);
    controller.set('toAddress', blankToAddress);

    controller.set('fromAddress', testFromAddress);
    //controller.set('toAddress', testToAddress);
  }
});

