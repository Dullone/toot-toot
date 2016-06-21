$(document).on "page:change", -> 
  $('textarea[data-autocomplete]').railsAutocomplete()

  if $('textarea[data-autocomplete]#toot_message').length > 0
    $('textarea[data-autocomplete]#toot_message').autocomplete().data("ui-autocomplete")
      ._renderItem = (ul, item) -> 
        return $( "<li>" )
          .attr( "data-value", item.value )
          .append( item.label + ", " + item.name )
          .appendTo( ul );
      
    $('input[data-autocomplete]#username ').autocomplete().data("ui-autocomplete")
      ._renderItem = (ul, item) -> 
        return $( "<li>" )
          .attr( "data-value", item.value )
          .append( "@" + item.label + ", " + item.name )
          .appendTo( ul );