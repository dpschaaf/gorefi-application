$('.calculator').ready(function() {
  var updater = new LoanUpdater
  updater.changeEvent()
});

var LoanUpdater = function() {
  this.downpaymentSelector = 'downpayment_values'
  this.formSelector = '.edit_loan'
}

LoanUpdater.prototype = {
  downpaymentDisplay: function() {
    return document.getElementById(this.downpaymentSelector)
  },
  loanId: function() {
    return $(this.downpaymentDisplay()).data()['id']
  },
  updateDomValues: function(data, status) {
    $(this.downpaymentDisplay()).empty().append(data)
  },
  updateLoanDetails: function(event) {
    var request = $.ajax({
      url: '/loans/'+this.loanId()+'/calculator',
      type: 'PUT',
      data: $(this.formSelector).serialize()
    })
    request.done(this.updateDomValues.bind(this))
  },
  changeEvent: function() {
    $(this.formSelector).change( this.updateLoanDetails.bind(this) )
  }
};

