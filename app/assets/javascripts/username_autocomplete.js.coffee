$(document).on "page:change", -> 
  $('textarea[data-autocomplete]').railsAutocomplete()

  $('textarea[data-autocomplete]').autocomplete().data("ui-autocomplete")
    ._renderItem = (ul, item) -> 
      return $( "<li>" )
        .attr( "data-value", item.value )
        .append( item.label + ", " + item.name )
        .appendTo( ul );
    