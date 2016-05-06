$(document).on "page:change", -> 
  $('textarea[data-autocomplete]').railsAutocomplete()