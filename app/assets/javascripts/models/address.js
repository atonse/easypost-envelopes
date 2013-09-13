Easypost.Address = Ember.Object.extend({
  id: null,

  name: null,
  street1: null,
  street2: null,
  city: null,
  state: null,
  zip: null,
  country: 'US',

  isVerified: false,

  setVerifiedFalse: function() {
    this.set('isVerified', false);
  }.observes('street1', 'city', 'state', 'zip'),

  verify: function() {
    // ajax code to verify from easypost

    var self = this;

    this.set('verificationMessage', 'Verifying...')

    $.ajax({
      url: '/verify',
      method: 'POST',
      data: {
        name: this.get('name'),
        street1: this.get('street1'),
        street2: this.get('street2'),
        city: this.get('city'),
        state: this.get('state'),
        zip: this.get('zip'),
        country: this.get('country')
      }
    }).then(function(result) {
      self.setProperties(result);
      self.set('verificationMessage', result.message);
      self.set('isVerified', true);
    });
  }
});
