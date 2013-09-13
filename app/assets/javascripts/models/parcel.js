Easypost.Parcel = Ember.Object.extend({
  id: null,

  predefined_package: null,

  weight: null,

  save: function() {
    var self = this;

    return new Ember.RSVP.Promise(function (resolve, reject) {
      $.ajax({
        url: '/parcel',
        method: 'POST',
        data: {
          predefined_package: self.get('predefined_package'),
          weight: self.get('weight')
        }
      }).then(function(result) {
        self.setProperties(result);
        resolve(self);
      });
    });
  }
});
