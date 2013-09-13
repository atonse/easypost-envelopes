Easypost.AddressController = Ember.ObjectController.extend({
  actions: {
    verify: function() {
      this.get('content').verify();
    }
  }
});
