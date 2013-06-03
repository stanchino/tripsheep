$ ->
  window.Tripsheep or= {}
  window.Tripsheep.ViewHelpers or= {}

  class Tripsheep.ViewHelpers.TripsHelper
    constructor: ->
      @selectors = 
        new_destination_link: '.add-destination'
        destinations_placeholder: '#destinations'
        new_destination_template: '#new_destination_template'
        autocomplete: '.autocomplete'
        remove_destination: '.remove-destination'
        destination_placeholder: '.destination-placeholder'

    init: ->
      @$destinations_placeholder = $(@selectors.destinations_placeholder)
      @$new_destination_content =  $(@selectors.new_destination_template).html()
      
      @bind_address_autocomplete()
      @bind_add_destination()
      @bind_remove_destination()
      
    bind_add_destination: ->
      $(@selectors.new_destination_link).on 'click', @$destinations_placeholder, (event) =>
        @$destinations_placeholder.append $(@new_destination_template()).fadeIn()
        @bind_address_autocomplete()
        @bind_remove_destination()
        return false

    bind_remove_destination: ->
      $(@selectors.remove_destination).on 'click', @$destinations_placeholder, (event) =>
        $(event.target).
        closest(@selectors.destination_placeholder).
        fadeOut(400, () -> this.remove())
        return false
    
    bind_address_autocomplete: ->
      $(@selectors.autocomplete).autocomplete
        source: (request, response) ->
          $.ajax
            url: "http://ws.geonames.org/searchJSON",
            dataType: "jsonp",
            data: 
              featureClass: "P",
              style: "full",
              maxRows: 12,
              name_startsWith: request.term
            success: (data) ->
              response $.map data.geonames, (item) ->
                {
                label: item.name + ", " + item.countryName,
                value: item.name + ", " + item.countryName
                }
        select: (event, ui) ->
          #console.log ui.item
          #ui.item ? "Selected: " + ui.item.label : "Nothing selected, input was " + this.value);
        open: ->
          $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
        close: ->
          $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );

    new_destination_template: =>
      new_content = @$new_destination_content
      new_id = new Date().getTime()
      regexp = new RegExp("new_destination", "g")
      new_content.replace(regexp, new_id)

  trips_helper = new Tripsheep.ViewHelpers.TripsHelper
  trips_helper.init()
    
