$(document).ready(function() {
  var downpayments = new DownpaymentSelector
  downpayments.bindEventListeners()
});

var DownpaymentSelector = function() {
  this.amountSelector = 'amount_button'
  this.percentSelector = 'percent_button'
  this.downpaymentSelector = 'downpayment_type'
}

DownpaymentSelector.prototype = {
  amountButton: function() {
    return document.getElementById(this.amountSelector)
  },
  percentButton: function() {
    return document.getElementById(this.percentSelector)
  },
  downpaymentTypeField: function() {
    return document.getElementById(this.downpaymentSelector)
  },
  setAmount: function() {
    this.downpaymentTypeField().setAttribute('value', 'downpayment_amount')
    this.amountButton().classList.add('btn-success')
    this.percentButton().classList.remove('btn-success')
  },
  setPercent: function() {
    this.downpaymentTypeField().setAttribute('value', 'downpayment_percent')
    this.percentButton().classList.add('btn-success')
    this.amountButton().classList.remove('btn-success')
  },
  bindEventListeners: function() {
    this.amountButton().addEventListener( 'click', this.setAmount.bind(this) , false)
    this.percentButton().addEventListener( 'click', this.setPercent.bind(this) , false)
  }
}

